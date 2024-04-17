import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_log_console/model/cmd.pbenum.dart';
import 'package:web_log_console/screen/json_log_screen_widget.dart';
import 'package:web_log_console/view_model/home_page_vm.dart';
import 'package:web_log_console/view_model/json_log_screen_vm.dart';
import 'package:xterm/xterm.dart';

import './dialog/font_styling_dialog.dart';

import './communication.dart';
import 'dialog/help_center_dialog.dart';

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
    vm.retrieveFromLocalStorage();
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'localhost:8080',
                      ),
                    ),
                  ),
                  const SizedBox(
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
                  const SizedBox(width: 20),
                  Title(color: Colors.white, child: Text(title)),
                  const SizedBox(width: 20),
                  Observer(builder: (_) {
                    return DropdownButton<LogType>(
                      value: vm.logType,
                      items: const [
                        DropdownMenuItem(
                          value: LogType.Console,
                          child: Text("Console"),
                        ),
                        DropdownMenuItem(
                          value: LogType.Http,
                          child: Text("http"),
                        ),
                        DropdownMenuItem(
                          value: LogType.RoomSocket,
                          child: Text("Room Socket"),
                        ),
                        DropdownMenuItem(
                          value: LogType.ImSocket,
                          child: Text("IM"),
                        ),
                        DropdownMenuItem(
                          value: LogType.Tracker,
                          child: Text("埋点"),
                        ),
                      ],
                      onChanged: (value) {
                        comm?.setLogType(value!);
                        vm.updateLogType(value!);
                      },
                    );
                  }),
                  const SizedBox(width: 20),
                  Observer(builder: (_) {
                    return DropdownButton<LogLevel>(
                      value: vm.logLevel,
                      items: const [
                        DropdownMenuItem(
                          value: LogLevel.Verbose,
                          child: Text("Verbose"),
                        ),
                        DropdownMenuItem(
                          value: LogLevel.Debug,
                          child: Text("Debug"),
                        ),
                        DropdownMenuItem(
                          value: LogLevel.Info,
                          child: Text("Info"),
                        ),
                        DropdownMenuItem(
                          value: LogLevel.Warning,
                          child: Text("Warning"),
                        ),
                        DropdownMenuItem(
                          value: LogLevel.Error,
                          child: Text("Error"),
                        ),
                        DropdownMenuItem(
                          value: LogLevel.Wtf,
                          child: Text("Wtf"),
                        ),
                      ],
                      onChanged: (value) {
                        comm?.setLogFilterLevel(value!);
                        vm.updateLogLevel(value!);
                        terminal.write('\r\n' +
                            '\u001b[37mLogging level has changed to ' +
                            value.name +
                            '\r\n\r\n');
                      },
                    );
                  }),
                  const SizedBox(width: 20),
                  IconButton(
                      iconSize: 20.0,
                      icon: const Icon(Icons.format_color_text_outlined),
                      onPressed: () {
                        FontStylingDialog.show(
                            context: context, homePageVm: vm);
                      }),
                  const SizedBox(width: 20),
                  IconButton(
                      iconSize: 20.0,
                      icon: const Icon(Icons.help_center),
                      onPressed: () {
                        HelpCenterDialog.show(context: context);
                      }),
                ],
              ),
            )),
            Expanded(
              flex: 10,
              child: Observer(builder: (_) {
                if (vm.logType == LogType.Http ||
                    vm.logType == LogType.ImSocket ||
                    vm.logType == LogType.RoomSocket) {
                  return JsonLogScreenWidget(vm: caches[vm.logType]!);
                }
                return TerminalView(
                  terminal,
                  padding: const EdgeInsets.only(
                      top: 17.0, bottom: 5.0, left: 5.0, right: 5.0),
                  controller: terminalController,
                  textStyle: TerminalStyle.fromTextStyle(
                    GoogleFonts.getFont(
                      vm.fontFamily,
                      fontSize: vm.fontSize,
                      color: vm.terminalTheme.theme.white,
                      letterSpacing: 0,
                      fontWeight:
                          vm.isBold ? FontWeight.w900 : FontWeight.normal,
                    ),
                  ),
                  autofocus: true,
                  theme: vm.terminalTheme.theme,
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
            IconButton(
                onPressed: () {
                  terminal.buffer.clear();
                  terminal.buffer.setCursor(0, 0);
                  terminal.write("");
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
