// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'home_page_vm.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageVm on _HomePageVm, Store {
  Computed<List<String>>? _$googleFontsNamesComputed;

  @override
  List<String> get googleFontsNames => (_$googleFontsNamesComputed ??=
          Computed<List<String>>(() => super.googleFontsNames,
              name: '_HomePageVm.googleFontsNames'))
      .value;

  late final _$titleAtom = Atom(name: '_HomePageVm.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$_logTypeAtom =
      Atom(name: '_HomePageVm._logType', context: context);

  LogType get logType {
    _$_logTypeAtom.reportRead();
    return super._logType;
  }

  @override
  LogType get _logType => logType;

  @override
  set _logType(LogType value) {
    _$_logTypeAtom.reportWrite(value, super._logType, () {
      super._logType = value;
    });
  }

  late final _$_logLevelAtom =
      Atom(name: '_HomePageVm._logLevel', context: context);

  LogLevel get logLevel {
    _$_logLevelAtom.reportRead();
    return super._logLevel;
  }

  @override
  LogLevel get _logLevel => logLevel;

  @override
  set _logLevel(LogLevel value) {
    _$_logLevelAtom.reportWrite(value, super._logLevel, () {
      super._logLevel = value;
    });
  }

  late final _$terminalThemeAtom =
      Atom(name: '_HomePageVm.terminalTheme', context: context);

  @override
  TerminalThemeItem get terminalTheme {
    _$terminalThemeAtom.reportRead();
    return super.terminalTheme;
  }

  @override
  set terminalTheme(TerminalThemeItem value) {
    _$terminalThemeAtom.reportWrite(value, super.terminalTheme, () {
      super.terminalTheme = value;
    });
  }

  late final _$fontSizeAtom =
      Atom(name: '_HomePageVm.fontSize', context: context);

  @override
  double get fontSize {
    _$fontSizeAtom.reportRead();
    return super.fontSize;
  }

  @override
  set fontSize(double value) {
    _$fontSizeAtom.reportWrite(value, super.fontSize, () {
      super.fontSize = value;
    });
  }

  late final _$isBoldAtom = Atom(name: '_HomePageVm.isBold', context: context);

  @override
  bool get isBold {
    _$isBoldAtom.reportRead();
    return super.isBold;
  }

  @override
  set isBold(bool value) {
    _$isBoldAtom.reportWrite(value, super.isBold, () {
      super.isBold = value;
    });
  }

  late final _$fontFamilyAtom =
      Atom(name: '_HomePageVm.fontFamily', context: context);

  @override
  String get fontFamily {
    _$fontFamilyAtom.reportRead();
    return super.fontFamily;
  }

  @override
  set fontFamily(String value) {
    _$fontFamilyAtom.reportWrite(value, super.fontFamily, () {
      super.fontFamily = value;
    });
  }

  late final _$retrieveFromLocalStorageAsyncAction =
      AsyncAction('_HomePageVm.retrieveFromLocalStorage', context: context);

  @override
  Future<void> retrieveFromLocalStorage() {
    return _$retrieveFromLocalStorageAsyncAction
        .run(() => super.retrieveFromLocalStorage());
  }

  late final _$_HomePageVmActionController =
      ActionController(name: '_HomePageVm', context: context);

  @override
  void updateLogLevel(LogLevel logLevel) {
    final _$actionInfo = _$_HomePageVmActionController.startAction(
        name: '_HomePageVm.updateLogLevel');
    try {
      return super.updateLogLevel(logLevel);
    } finally {
      _$_HomePageVmActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateLogType(LogType logType) {
    final _$actionInfo = _$_HomePageVmActionController.startAction(
        name: '_HomePageVm.updateLogType');
    try {
      return super.updateLogType(logType);
    } finally {
      _$_HomePageVmActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
terminalTheme: ${terminalTheme},
fontSize: ${fontSize},
isBold: ${isBold},
fontFamily: ${fontFamily},
googleFontsNames: ${googleFontsNames}
    ''';
  }
}
