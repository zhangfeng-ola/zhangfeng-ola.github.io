// @dart = 2.12
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:html' hide Platform, HttpRequest;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web_log_console/view_model/json_log_screen_vm.dart';
import 'package:xterm/xterm.dart';
import './model/cmd.pb.dart';

class Communication {
  Communication({required this.onUpdate, required this.terminal, required this.caches});

  final Function() onUpdate;
  final Terminal terminal;
  final Map<LogType, JsonLogScreenVm> caches;

  LogLevel get logLevel => _logLevel;
  LogLevel _logLevel = LogLevel.Verbose;
  LogType get logType => _logType;
  LogType _logType = LogType.Console;

  WebSocket? _socket;

  Future<void> bindToWebSocket(String webSocketUrl) async {
    print("FeiLong: bindToWebSocket: $webSocketUrl");
    if (kIsWeb) {
      _socket = WebSocket("ws://$webSocketUrl");

      _socket!.onOpen.listen((e) {
        onUpdate();
        terminal.write('Connected to WebSocket: $webSocketUrl \r\n');
        setLogType(_logType);
        setLogFilterLevel(_logLevel);
      }, onDone: () {
        onUpdate();
        terminal.write('WebSocket connection closed \r\r');
      }, onError: (e) {
        onUpdate();
        terminal.write('Error connecting to WebSocket $e \r\n');
      });

      _socket!.onMessage.listen((e) {
        switch (_logType) {
          case LogType.Console:
            terminal.write((e.data ?? '') + '\r\n');
            break;
          case LogType.Http:
          case LogType.ImSocket:
          case LogType.RoomSocket:
            if (e.data is String) {
              Map<String, dynamic> item = jsonDecode(e.data);
              caches[_logType]?.addBuffer(item, e.data);
            }
            break;
        }
      });

      _socket!.onError.listen((e) {
        terminal.write('Error connecting to WebSocket \r\n');
      });

      _socket!.onClose.listen((e) {
        terminal.write('WebSocket connection closed \r\r');
      });
    }
  }

  void setLogFilterLevel(LogLevel level) {
    if (null != _socket) {
      Cmd cmd = Cmd();
      cmd.op = Op.SetLogLevel;
      cmd.data = Data();
      cmd.data.logLevel = level;

      /// convert cmd to List<int>
      _socket!.send(cmd.writeToBuffer());
      _logLevel = level;
    }
  }

  void setLogType(LogType type) {
    if (null != _socket) {
      Cmd cmd = Cmd();
      cmd.op = Op.SetLogType;
      cmd.data = Data();
      cmd.data.logType = type;

      /// convert cmd to List<int>
      _socket!.send(cmd.writeToBuffer());
      _logType = type;
    }
  }
}
