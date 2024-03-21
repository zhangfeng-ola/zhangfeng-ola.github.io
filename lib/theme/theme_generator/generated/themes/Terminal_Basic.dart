import 'package:flutter/material.dart';
import 'package:xterm/ui.dart';
import './../../../terminal_theme_item.dart';

const TerminalThemeItem Terminal_BasicTheme = TerminalThemeItem(
  name: "Terminal_BasicTheme",
  theme: TerminalTheme(
    cursor: Color(0XFF7f7f7f),
    selection: Color(0XFF7f7f7f),
    foreground: Color(0XFF000000),
    background: Color(0XFFffffff),
    black: Color(0XFF000000),
    brightBlack: Color(0XFF666666),
    red: Color(0XFF990000),
    brightRed: Color(0XFFe50000),
    green: Color(0XFF00a600),
    brightGreen: Color(0XFF00d900),
    yellow: Color(0XFF999900),
    brightYellow: Color(0XFFe5e500),
    blue: Color(0XFF0000b2),
    brightBlue: Color(0XFF0000ff),
    magenta: Color(0XFFb200b2),
    brightMagenta: Color(0XFFe500e5),
    cyan: Color(0XFF00a6b2),
    brightCyan: Color(0XFF00e5e5),
    white: Color(0XFFbfbfbf),
    brightWhite: Color(0XFFe5e5e5),
    searchHitBackground: Color(0XFFffffff),
    searchHitBackgroundCurrent: Color(0XFF000000),
    searchHitForeground: Color(0XFF000000),
));
