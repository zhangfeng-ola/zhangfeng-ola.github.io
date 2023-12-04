import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final terminal = Terminal(
    maxLines: 10000,
  );
  final terminalController = TerminalController();

  String title = 'OlaChat LogConsole';
  String bindToServer = '';
  @override
  void initState() {
    createComm();
    super.initState();
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
    );
    terminal.write('OlaChat LogConsole \r\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
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
            ],
          )),
          Expanded(
            flex: 10,
            child: TerminalView(
              terminal,
              controller: terminalController,
              textStyle: TerminalStyle.fromTextStyle(TextStyle(fontSize: 12, color: Colors.white, letterSpacing: 0, fontFamily: 'sans-serif')),
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
            ),
          ),
        ],
      ),
    );
  }
}
