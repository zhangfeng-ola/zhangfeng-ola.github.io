// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'json_log_screen_vm.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$JsonLogScreenVm on _JsonLogScreenVm, Store {
  late final _$_bufferAtom =
      Atom(name: '_JsonLogScreenVm._buffer', context: context);

  ListQueue<Map<String, dynamic>> get buffer {
    _$_bufferAtom.reportRead();
    return super._buffer;
  }

  @override
  ListQueue<Map<String, dynamic>> get _buffer => buffer;

  @override
  set _buffer(ListQueue<Map<String, dynamic>> value) {
    _$_bufferAtom.reportWrite(value, super._buffer, () {
      super._buffer = value;
    });
  }

  late final _$_filterBufferAtom =
      Atom(name: '_JsonLogScreenVm._filterBuffer', context: context);

  ListQueue<Map<String, dynamic>> get filterBuffer {
    _$_filterBufferAtom.reportRead();
    return super._filterBuffer;
  }

  @override
  ListQueue<Map<String, dynamic>> get _filterBuffer => filterBuffer;

  @override
  set _filterBuffer(ListQueue<Map<String, dynamic>> value) {
    _$_filterBufferAtom.reportWrite(value, super._filterBuffer, () {
      super._filterBuffer = value;
    });
  }

  late final _$_bufferReceivedAtom =
      Atom(name: '_JsonLogScreenVm._bufferReceived', context: context);

  int get bufferReceived {
    _$_bufferReceivedAtom.reportRead();
    return super._bufferReceived;
  }

  @override
  int get _bufferReceived => bufferReceived;

  @override
  set _bufferReceived(int value) {
    _$_bufferReceivedAtom.reportWrite(value, super._bufferReceived, () {
      super._bufferReceived = value;
    });
  }

  late final _$_selectedAtom =
      Atom(name: '_JsonLogScreenVm._selected', context: context);

  Map<String, dynamic>? get selected {
    _$_selectedAtom.reportRead();
    return super._selected;
  }

  @override
  Map<String, dynamic>? get _selected => selected;

  @override
  set _selected(Map<String, dynamic>? value) {
    _$_selectedAtom.reportWrite(value, super._selected, () {
      super._selected = value;
    });
  }

  late final _$_filterAtom =
      Atom(name: '_JsonLogScreenVm._filter', context: context);

  String get filter {
    _$_filterAtom.reportRead();
    return super._filter;
  }

  @override
  String get _filter => filter;

  @override
  set _filter(String value) {
    _$_filterAtom.reportWrite(value, super._filter, () {
      super._filter = value;
    });
  }

  late final _$_keyWordAtom =
      Atom(name: '_JsonLogScreenVm._keyWord', context: context);

  String get keyWord {
    _$_keyWordAtom.reportRead();
    return super._keyWord;
  }

  @override
  String get _keyWord => keyWord;

  @override
  set _keyWord(String value) {
    _$_keyWordAtom.reportWrite(value, super._keyWord, () {
      super._keyWord = value;
    });
  }

  late final _$_displayModelAtom =
      Atom(name: '_JsonLogScreenVm._displayModel', context: context);

  DisplayModel get displayModel {
    _$_displayModelAtom.reportRead();
    return super._displayModel;
  }

  @override
  DisplayModel get _displayModel => displayModel;

  @override
  set _displayModel(DisplayModel value) {
    _$_displayModelAtom.reportWrite(value, super._displayModel, () {
      super._displayModel = value;
    });
  }

  late final _$_JsonLogScreenVmActionController =
      ActionController(name: '_JsonLogScreenVm', context: context);

  @override
  void updateKeyWord(String keyWord) {
    final _$actionInfo = _$_JsonLogScreenVmActionController.startAction(
        name: '_JsonLogScreenVm.updateKeyWord');
    try {
      return super.updateKeyWord(keyWord);
    } finally {
      _$_JsonLogScreenVmActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDisplayModel(DisplayModel displayModel) {
    final _$actionInfo = _$_JsonLogScreenVmActionController.startAction(
        name: '_JsonLogScreenVm.updateDisplayModel');
    try {
      return super.updateDisplayModel(displayModel);
    } finally {
      _$_JsonLogScreenVmActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addBuffer(Map<String, dynamic> item, String itemString) {
    final _$actionInfo = _$_JsonLogScreenVmActionController.startAction(
        name: '_JsonLogScreenVm.addBuffer');
    try {
      return super.addBuffer(item, itemString);
    } finally {
      _$_JsonLogScreenVmActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelected(Map<String, dynamic> item) {
    final _$actionInfo = _$_JsonLogScreenVmActionController.startAction(
        name: '_JsonLogScreenVm.setSelected');
    try {
      return super.setSelected(item);
    } finally {
      _$_JsonLogScreenVmActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(String filter) {
    final _$actionInfo = _$_JsonLogScreenVmActionController.startAction(
        name: '_JsonLogScreenVm.setFilter');
    try {
      return super.setFilter(filter);
    } finally {
      _$_JsonLogScreenVmActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_JsonLogScreenVmActionController.startAction(
        name: '_JsonLogScreenVm.clear');
    try {
      return super.clear();
    } finally {
      _$_JsonLogScreenVmActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
