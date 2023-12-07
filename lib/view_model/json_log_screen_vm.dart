// @dart = 2.12
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:collection';
import 'dart:convert';

import 'package:mobx/mobx.dart';

// Include generated file
part 'json_log_screen_vm.g.dart';

// This is the class used by rest of your codebase
class JsonLogScreenVm = _JsonLogScreenVm with _$JsonLogScreenVm;

// The store-class
abstract class _JsonLogScreenVm with Store {
  _JsonLogScreenVm() {}
  final int _bufferSize = 50;

  @readonly
  ListQueue<Map<String, dynamic>> _buffer = ListQueue();

  @readonly
  ListQueue<Map<String, dynamic>> _filterBuffer = ListQueue();

  @readonly
  int _bufferReceived = 0;

  @readonly
  Map<String, dynamic>? _selected;

  @readonly
  String _filter = '';  

  @action
  void addBuffer(Map<String, dynamic> item, String itemString) {
    if (_buffer.length == _bufferSize) {
      _buffer.removeFirst();
    }
    if (null != item['responseHeader'] && item['responseHeader'] is String) {
      item['responseHeader'] = jsonDecode(item['responseHeader']);
    }
    if (null != item['responseBody'] && item['responseBody'] is String) {
      item['responseBody'] = jsonDecode(item['responseBody']);
    }
    _buffer.add(item);
    if(_filter.trim().isNotEmpty && itemString.contains(_filter.trim())){
      _filterBuffer.add(item);
      _bufferReceived++;
    }else if(_filter.trim().isEmpty){
      _filterBuffer.add(item);
      _bufferReceived++;
    }
  }
  @action
  void setSelected(Map<String, dynamic> item) {
    _selected = item;
  }

  @action
  void setFilter(String filter){
    print("$_filter  vs $filter");
    if(filter.trim() == _filter.trim()){
      return;
    }
    _filter = filter;
    if(_filter.trim().isEmpty){
      _filterBuffer = ListQueue.from(_buffer);
      _bufferReceived++;
    }else {
      _filterBuffer = ListQueue();
      for(int i=0; i < _buffer.length; i++){
        if(_buffer.elementAt(i).toString().contains(filter)){
          _filterBuffer.add(_buffer.elementAt(i));
        }
      }
      _bufferReceived++;
    }
  }
}
