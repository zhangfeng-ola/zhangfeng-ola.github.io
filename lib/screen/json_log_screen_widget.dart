// @dart = 2.12

// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:json_view/json_view.dart';
import 'package:web_log_console/model/display.pbenum.dart';
import 'package:web_log_console/view_model/json_log_screen_vm.dart';

import '../utils/super_clipboard_util.dart';

class JsonLogScreenWidget extends StatefulWidget {
  final JsonLogScreenVm vm;

  const JsonLogScreenWidget({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  _JsonLogScreenWidget createState() => _JsonLogScreenWidget();
}

class _JsonLogScreenWidget extends State<JsonLogScreenWidget> {
  var _scrollController = ScrollController();
  final _txtEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Observer(builder: (_) {
            /// listening buffer received event
            widget.vm.bufferReceived;
            // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (widget.vm.displayModel == DisplayModel.Normal)
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      // reverse: true,
                      padding: const EdgeInsetsDirectional.only(
                          start: 4, end: 4, bottom: 0, top: 8),
                      itemCount: widget.vm.filterBuffer.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            widget.vm.setSelected(
                                widget.vm.filterBuffer.elementAt(index));
                          },
                          child: Container(
                            color: index % 2 == 0
                                ? Colors.white.withOpacity(0.8)
                                : Colors.white.withOpacity(1.0),
                            alignment: AlignmentDirectional.centerStart,
                            height: 36,
                            child: Text(
                              widget.vm.filterBuffer.elementAt(index)['url'] ??
                                  widget.vm.filterBuffer
                                      .elementAt(index)
                                      .toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                if (widget.vm.displayModel == DisplayModel.Search)
                  Expanded(
                    child: _buildSearchResult(),
                  ),
                SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: _txtEditController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'filter',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                        height: 0,
                      ),
                      ElevatedButton(
                        child: Observer(builder: (_) {
                          return Text(
                              widget.vm.displayModel == DisplayModel.Normal
                                  ? 'Filter'
                                  : 'Search');
                        }),
                        onPressed: () {
                          if (widget.vm.displayModel == DisplayModel.Normal) {
                            widget.vm.setFilter(_txtEditController.text);
                          } else if (widget.vm.displayModel ==
                              DisplayModel.Search) {
                            widget.vm.updateKeyWord(_txtEditController.text);
                          }
                        },
                      ),
                      SizedBox(
                        width: 10,
                        height: 0,
                      ),
                      if (widget.vm.displayModel == DisplayModel.Normal)
                        ElevatedButton(
                          child: const Text('Clear'),
                          onPressed: () {
                            if (widget.vm.displayModel == DisplayModel.Normal) {
                              widget.vm.clear();
                            } else if (widget.vm.displayModel ==
                                DisplayModel.Search) {
                              widget.vm.updateKeyWord('');
                            }
                          },
                        ),
                      SizedBox(
                        width: 10,
                        height: 0,
                      ),
                      ElevatedButton(
                          child: Observer(builder: (_) {
                            return Text(
                                widget.vm.displayModel == DisplayModel.Normal
                                    ? 'Normal Model'
                                    : 'Search Model');
                          }),
                          onPressed: () {
                            widget.vm.switchDisplayModel();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                widget.vm.displayModel == DisplayModel.Normal
                                    ? Colors.blue
                                    : Colors.green,
                          )),
                      if (widget.vm.displayModel == DisplayModel.Search)
                        ElevatedButton(
                          child: const Text('Next'),
                          onPressed: () {
                            widget.vm.scrollToNext((p0) {
                              if (mounted && null != p0.currentContext) {
                                Scrollable.ensureVisible(p0.currentContext!,
                                    alignment: 0.2,
                                    duration: const Duration(milliseconds: 0));
                              }
                            });
                          },
                        ),
                      if (widget.vm.displayModel == DisplayModel.Search)
                        ElevatedButton(
                          child: const Text('Previous'),
                          onPressed: () {
                            widget.vm.scrollToPrevious((p0) {
                              if (mounted && null != p0.currentContext) {
                                Scrollable.ensureVisible(p0.currentContext!,
                                    alignment: 0.2,
                                    duration: const Duration(milliseconds: 0));
                              }
                            });
                          },
                        ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
        Expanded(
          child: Observer(builder: (_) {
            return JsonConfig(
              data: JsonConfigData(
                gap: 100,
                style: const JsonStyleScheme(
                  quotation: JsonQuotation.same('"'),
                  // set this to true to open all nodes at start
                  // use with caution, it will cause performance issue when json items is too large
                  openAtStart: false,
                  arrow: Icon(Icons.arrow_forward),
                  // too large depth will cause performance issue
                  depth: 2,
                ),
                color: const JsonColorScheme(),
              ),
              child: Column(
                children: [
                  if (widget.vm.selected?.isNotEmpty ?? false)
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            SuperClipboardUtil.writeData(jsonEncode(
                                widget.vm.selected?['responseBody']));
                          },
                          child: const Text("Copy Response Body"),
                        ),
                      ],
                    ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Expanded(
                    child: JsonView(
                      json: widget.vm.selected ?? {},
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSearchResult() {
    return Observer(builder: (_) {
      if (null == widget.vm.selected) {
        return const SizedBox.shrink();
      }
      List<InlineSpan> textSpans = [];
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String jsonString = encoder.convert(widget.vm.selected);
      if (widget.vm.keyWord.isEmpty) {
        return SingleChildScrollView(
          child: SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: jsonString,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.32,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        );
      }
      String searchKey = widget.vm.keyWord;
      List<GlobalKey> keys = [];
      jsonString.splitMapJoin(RegExp('(${RegExp.escape(searchKey)})'),
          onMatch: (m) {
        GlobalKey key = GlobalKey();
        keys.add(key);
        textSpans.add(
          WidgetSpan(
            child: Text(
              m[0] ?? '',
              key: key,
              style: const TextStyle(
                color: Color(0xFFFF70CE),
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.bold,
                letterSpacing: -0.32,
              ),
            ),
          ),
        );
        return m[0]!;
      }, onNonMatch: (n) {
        textSpans.add(TextSpan(
            text: n,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.32,
            )));
        return n;
      });
      widget.vm.keyList = keys;
      return SingleChildScrollView(
        child: SelectableText.rich(
          TextSpan(
            children: [
              ...textSpans,
            ],
          ),
          textAlign: TextAlign.left,
        ),
      );
    });
  }
}
