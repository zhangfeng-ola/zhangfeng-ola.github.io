import 'package:flutter/material.dart';
import 'package:xterm/ui.dart';
import './../../../terminal_theme_item.dart';

const TerminalThemeItem GrassTheme = TerminalThemeItem(
  name: "GrassTheme",
  theme: TerminalTheme(
    cursor: Color(0XFF8c2800),
    selection: Color(0XFF8c2800),
    foreground: Color(0XFFfff0a5),
    background: Color(0XFF13773d),
    black: Color(0XFF000000),
    brightBlack: Color(0XFF555555),
    red: Color(0XFFbb0000),
    brightRed: Color(0XFFbb0000),
    green: Color(0XFF00bb00),
    brightGreen: Color(0XFF00bb00),
    yellow: Color(0XFFe7b000),
    brightYellow: Color(0XFFe7b000),
    blue: Color(0XFF0000a3),
    brightBlue: Color(0XFF0000bb),
    magenta: Color(0XFF950062),
    brightMagenta: Color(0XFFff55ff),
    cyan: Color(0XFF00bbbb),
    brightCyan: Color(0XFF55ffff),
    white: Color(0XFFbbbbbb),
    brightWhite: Color(0XFFffffff),
    searchHitBackground: Color(0XFF13773d),
    searchHitBackgroundCurrent: Color(0XFFfff0a5),
    searchHitForeground: Color(0XFF000000),
));
