// @dart = 2.12
// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:web_log_console/view_model/home_page_vm.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:web_log_console/theme/terminal_theme.dart';

class FontStylingDialog extends StatefulWidget {
  const FontStylingDialog({
    Key? key,
    required this.vm,
  }) : super(key: key);
  final HomePageVm vm;

  @override
  State<FontStylingDialog> createState() => _FontStylingDialogState();

  static Future<void> show(
      {required BuildContext context, required HomePageVm homePageVm}) async {
    await showDialog(
      context: context,
      builder: (context) => FontStylingDialog(vm: homePageVm),
      barrierDismissible: true,
    );
  }
}

class _FontStylingDialogState extends State<FontStylingDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _textEditingController.text.isNotEmpty) {
        updateTextControllerValue(double.parse(_textEditingController.text));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void updateTextControllerValue(double value) {
    widget.vm.fontSize = value;
    _textEditingController.text = "$value";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        alignment: AlignmentDirectional.topCenter,
        padding: const EdgeInsetsDirectional.all(45.0),
        width: 500,
        height: 600,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Terminal Theme",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10.0),
              Observer(builder: (_) {
                return DropdownButton<TerminalThemeItem>(
                  value: widget.vm.terminalTheme,
                  items: widget.vm.themes
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item.name)))
                      .toList(),
                  onChanged: (TerminalThemeItem? value) {
                    widget.vm.terminalTheme = value!;
                  },
                  alignment: Alignment.center,
                );
              }),
              const SizedBox(height: 30.0),
              const Text(
                "Font Style",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10.0),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 20.0,
                      padding: const EdgeInsetsDirectional.all(5.0),
                      onPressed: () {
                        updateTextControllerValue(widget.vm.fontSize - 1);
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    SizedBox(
                      width: 50,
                      child: Observer(builder: (context) {
                        _textEditingController.value =
                            TextEditingValue(text: "${widget.vm.fontSize}");
                        return TextField(
                          focusNode: _focusNode,
                          controller: _textEditingController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textAlign: TextAlign.center,
                        );
                      }),
                    ),
                    IconButton(
                      iconSize: 20.0,
                      padding: const EdgeInsetsDirectional.all(5.0),
                      onPressed: () {
                        updateTextControllerValue(widget.vm.fontSize + 1);
                      },
                      icon: const Icon(Icons.add),
                    ),
                    Observer(builder: (context) {
                      return IconButton(
                        iconSize: 20.0,
                        padding: const EdgeInsetsDirectional.all(5.0),
                        onPressed: () {
                          widget.vm.isBold = !widget.vm.isBold;
                        },
                        icon: widget.vm.isBold
                            ? const Icon(Icons.cancel_outlined)
                            : const Icon(Icons.format_bold),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              const Text(
                "Font Family",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10.0),
              Observer(builder: (_) {
                return DropdownButton<String>(
                  value: widget.vm.fontFamily,
                  items: widget.vm.googleFontsNames
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: (String? value) {
                    widget.vm.fontFamily = value!;
                  },
                  alignment: Alignment.center,
                );
              }),
              const SizedBox(height: 30.0),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xFFFFC200);
                            }
                            return const Color(0xFFF5E200);
                          },
                        ),
                      ),
                      onPressed: () {
                        widget.vm.saveToLocalStorage();
                      },
                      child: const Text(
                        "Save to browser",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xFFFF0276);
                            }
                            return const Color(0xFFFF00D5);
                          },
                        ),
                      ),
                      onPressed: () {
                        widget.vm.retrieveFromLocalStorage();
                      },
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
