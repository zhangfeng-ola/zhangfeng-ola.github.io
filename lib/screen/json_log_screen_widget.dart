// @dart = 2.12

// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:json_view/json_view.dart';
import 'package:my_local_network_comm/view_model/json_log_screen_vm.dart';

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
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    // reverse: true,
                    padding: const EdgeInsetsDirectional.only(start: 4, end: 4, bottom: 0, top: 8),
                    itemCount: widget.vm.filterBuffer.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          widget.vm.setSelected(widget.vm.filterBuffer.elementAt(index));
                        },
                        child: Container(
                          color: index % 2 == 0 ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(1.0),
                          child: Text(
                            widget.vm.filterBuffer.elementAt(index)['url'] ??
                                widget.vm.filterBuffer.elementAt(index).toString(),
                            style: TextStyle(
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
                        width: 20,
                        height: 0,
                      ),
                      ElevatedButton(
                        child: const Text('Filter'),
                        onPressed: () {
                          widget.vm.setFilter(_txtEditController.text);
                        },
                      ),
                      SizedBox(
                        width: 20,
                        height: 0,
                      ),
                      ElevatedButton(
                        child: const Text('Clear'),
                        onPressed: () {
                          widget.vm.clear();
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
                  depth: 5,
                ),
                color: const JsonColorScheme(),
              ),
              child: JsonView(
                json: widget.vm.selected ?? Map(),
              ),
            );
          }),
        ),
      ],
    );
  }
}
