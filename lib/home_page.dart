import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:web_log_console/model/cmd.pbenum.dart';
import 'package:web_log_console/screen/json_log_screen_widget.dart';
import 'package:web_log_console/view_model/home_page_vm.dart';
import 'package:web_log_console/view_model/json_log_screen_vm.dart';
import 'package:xterm/xterm.dart';

import './communication.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Communication? comm;
  TextEditingController txtController = TextEditingController();
  TextEditingController _txtEditController = TextEditingController();

  HomePageVm vm = HomePageVm();
  final terminal = Terminal(
    maxLines: 10000,
  );
  final terminalController = TerminalController();

  String title = 'OlaChat LogConsole';
  String bindToServer = '';
  Map<LogType, JsonLogScreenVm> caches = Map<LogType, JsonLogScreenVm>();

  @override
  void initState() {
    createComm();
    super.initState();
    caches[LogType.Http] = JsonLogScreenVm();
    caches[LogType.RoomSocket] = JsonLogScreenVm();
    caches[LogType.ImSocket] = JsonLogScreenVm();
  }

  Future<void> createComm() async {
    if (comm != null) {
      return;
    }
    comm = Communication(
      onUpdate: () {
        setState(() {
          title = 'OlaChat LogConsole connected';
        });
      },
      terminal: terminal,
      caches: caches,
    );
    vm.updateLogType(comm!.logType);
    vm.updateLogLevel(comm!.logLevel);
    terminal.write('OlaChat LogConsole \r\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 500,
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _txtEditController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'localhost:8080',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    height: 0,
                  ),
                  ElevatedButton(
                    child: const Text('Connect'),
                    onPressed: () {
                      bindToServer = _txtEditController.text;
                      if (null != comm) {
                        comm!.bindToWebSocket(bindToServer);
                      }
                    },
                  ),
                  SizedBox(
                    width: 20,
                    height: 0,
                  ),
                  Title(color: Colors.white, child: Text(title)),
                  SizedBox(
                    width: 20,
                    height: 0,
                  ),
                  Observer(builder: (_) {
                    return DropdownButton<LogType>(
                      value: vm.logType,
                      items: const [
                        DropdownMenuItem(
                          child: Text("Console"),
                          value: LogType.Console,
                        ),
                        DropdownMenuItem(
                          child: Text("http"),
                          value: LogType.Http,
                        ),
                        DropdownMenuItem(
                          child: Text("Room Socket"),
                          value: LogType.RoomSocket,
                        ),
                        DropdownMenuItem(
                          child: Text("IM"),
                          value: LogType.ImSocket,
                        ),
                        DropdownMenuItem(
                          child: Text("埋点"),
                          value: LogType.Tracker,
                        ),
                      ],
                      onChanged: (value) {
                        comm?.setLogType(value!);
                        vm.updateLogType(value!);
                      },
                    );
                  }),
                  SizedBox(
                    width: 20,
                    height: 0,
                  ),
                  Observer(builder: (_) {
                    return DropdownButton<LogLevel>(
                      value: vm.logLevel,
                      items: const [
                        DropdownMenuItem(
                          child: Text("Verbose"),
                          value: LogLevel.Verbose,
                        ),
                        DropdownMenuItem(
                          child: Text("info"),
                          value: LogLevel.Info,
                        ),
                        DropdownMenuItem(
                          child: Text("Debug"),
                          value: LogLevel.Debug,
                        ),
                        DropdownMenuItem(
                          child: Text("Warning"),
                          value: LogLevel.Warning,
                        ),
                        DropdownMenuItem(
                          child: Text("Error"),
                          value: LogLevel.Error,
                        ),
                        DropdownMenuItem(
                          child: Text("Wtf"),
                          value: LogLevel.Wtf,
                        ),
                      ],
                      onChanged: (value) {
                        comm?.setLogFilterLevel(value!);
                        vm.updateLogLevel(value!);
                      },
                    );
                  }),
                ],
              ),
            )),
            Expanded(
              flex: 10,
              child: Observer(builder: (_) {
                if (vm.logType == LogType.Http || vm.logType == LogType.ImSocket || vm.logType == LogType.RoomSocket) {
                  return JsonLogScreenWidget(vm: caches[vm.logType]!);
                }
                return TerminalView(
                  terminal,
                  controller: terminalController,
                  textStyle: TerminalStyle.fromTextStyle(
                      TextStyle(fontSize: 12, color: Colors.white, letterSpacing: 0, fontFamily: 'sans-serif')),
                  autofocus: true,
                  backgroundOpacity: 1.0,
                  onSecondaryTapDown: (details, offset) async {
                    final selection = terminalController.selection;
                    if (selection != null) {
                      final text = terminal.buffer.getText(selection);
                      terminalController.clearSelection();
                      await Clipboard.setData(ClipboardData(text: text));
                    } else {
                      final data = await Clipboard.getData('text/plain');
                      final text = data?.text;
                      if (text != null) {
                        terminal.paste(text);
                      }
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
