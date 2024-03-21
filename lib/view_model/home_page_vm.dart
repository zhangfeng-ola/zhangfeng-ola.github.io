// @dart = 2.12
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import 'package:web_log_console/model/cmd.pbenum.dart';
import 'package:xterm/ui.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../theme/terminal_theme.dart';
import './../utils/shared_preferences_utils.dart';


// Include generated file
part 'home_page_vm.g.dart';

// This is the class used by rest of your codebase
class HomePageVm = _HomePageVm with _$HomePageVm;

// The store-class
abstract class _HomePageVm with Store {

  @observable
  String title = 'OlaChat LogConsole';

  @readonly
  LogType _logType = LogType.Console;

  @readonly
  LogLevel _logLevel = LogLevel.Info;

  @observable
  TerminalThemeItem terminalTheme = defaultTheme;

  @observable
  double fontSize = 16.0;

  @observable
  bool isBold = false;

  @observable
  String fontFamily = "Fira Code";

  @computed
  List<String> get googleFontsNames =>
      GoogleFonts
          .asMap()
          .keys
          .toList();

  final List<TerminalThemeItem> themes = allThemes;

  @action
  void updateLogLevel(LogLevel logLevel) {
    _logLevel = logLevel;
  }

  @action
  void updateLogType(LogType logType) {
    _logType = logType;
  }

  @action
  Future<void> retrieveFromLocalStorage() async {
    fontSize = await SharedPreferencesUtils.getDouble(SharedPreferencesUtils.fontSize, defaultValue: fontSize);
    fontFamily = await SharedPreferencesUtils.getString(SharedPreferencesUtils.fontFamily, defaultValue: fontFamily);
    String themeName = await SharedPreferencesUtils.getString(SharedPreferencesUtils.terminalTheme, defaultValue: "");
    List<TerminalThemeItem> matchedThemeItems = themes.where((theme)=> theme.name == themeName).toList();
    if(matchedThemeItems.isNotEmpty) {
      terminalTheme = matchedThemeItems[0];
    }
    isBold = await SharedPreferencesUtils.getBool(SharedPreferencesUtils.fontIsBold, defaultValue: false);
  }

  Future<void> saveToLocalStorage() async {
    SharedPreferencesUtils.setDouble(SharedPreferencesUtils.fontSize, fontSize);
    SharedPreferencesUtils.setString(SharedPreferencesUtils.fontFamily, fontFamily);
    SharedPreferencesUtils.setString(SharedPreferencesUtils.terminalTheme, terminalTheme.name);
    SharedPreferencesUtils.setBool(SharedPreferencesUtils.fontIsBold, isBold);
  }
}
