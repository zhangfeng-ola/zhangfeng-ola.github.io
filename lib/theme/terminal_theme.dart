import 'package:web_log_console/theme/theme_generator/generated/theme_list.dart';
import 'package:xterm/ui.dart';
import 'package:flutter/material.dart';

import './theme_generator/generated/theme.dart';
import './terminal_theme_item.dart';

export './terminal_theme_item.dart';

const TerminalThemeItem customBlueTheme = TerminalThemeItem(
    name: "customBlueTheme",
    theme: TerminalTheme(
      cursor: Color(0XAAAEAFAD),
      selection: Color(0XAAAEAFAD),
      foreground: Color(0XFFCCCCCC),
      background: Color(0xFF002B36),
      black: Color(0XFF000000),
      red: Color(0XFFCD3131),
      green: Color(0XFF0DBC79),
      yellow: Color(0XFFE5E510),
      blue: Color(0XFF2472C8),
      magenta: Color(0XFFBC3FBC),
      cyan: Color(0XFF11A8CD),
      white: Color(0XFFE5E5E5),
      brightBlack: Color(0XFF666666),
      brightRed: Color(0XFFF14C4C),
      brightGreen: Color(0XFF23D18B),
      brightYellow: Color(0XFFF5F543),
      brightBlue: Color(0XFF3B8EEA),
      brightMagenta: Color(0XFFD670D6),
      brightCyan: Color(0XFF29B8DB),
      brightWhite: Color(0XFFFFFFFF),
      searchHitBackground: Color(0XFFFFFF2B),
      searchHitBackgroundCurrent: Color(0XFF31FF26),
      searchHitForeground: Color(0XFF000000),
    ));

const TerminalThemeItem defaultTheme =
    TerminalThemeItem(name: "defaultTheme", theme: TerminalThemes.defaultTheme);

const TerminalThemeItem whiteOnBlack =
    TerminalThemeItem(name: "whiteOnBlack", theme: TerminalThemes.whiteOnBlack);

const List<TerminalThemeItem> allThemes = [...generatedThemes, defaultTheme, whiteOnBlack];
