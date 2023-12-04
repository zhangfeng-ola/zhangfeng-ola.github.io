// @dart = 2.12
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:html' hide Platform, HttpRequest;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:xterm/xterm.dart';


class Communication {
  Communication({ required this.onUpdate, required this.terminal});
  final Function() onUpdate;
  final Terminal terminal;

  WebSocket? _socket;

  Future<void> bindToWebSocket(String webSocketUrl) async {
    print("FeiLong: bindToWebSocket: $webSocketUrl");
    if (kIsWeb) {
      _socket = WebSocket("ws://$webSocketUrl");

      _socket!.onOpen.listen((e) {
        onUpdate();
        terminal.write('Connected to WebSocket: $webSocketUrl \r\n');
      });

      _socket!.onMessage.listen((e) {
        terminal.write((e.data ?? '')+'\r\n');
      });

      _socket!.onError.listen((e) {
        terminal.write('Error connecting to WebSocket \r\n');
      });

      _socket!.onClose.listen((e) {
        terminal.write('WebSocket connection closed \r\r');
      });
    }
  }
}
