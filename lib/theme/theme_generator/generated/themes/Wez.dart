import 'package:flutter/material.dart';
import 'package:xterm/ui.dart';
import './../../../terminal_theme_item.dart';

const TerminalThemeItem WezTheme = TerminalThemeItem(
  name: "WezTheme",
  theme: TerminalTheme(
    cursor: Color(0XFF53ae71),
    selection: Color(0XFF53ae71),
    foreground: Color(0XFFb3b3b3),
    background: Color(0XFF000000),
    black: Color(0XFF000000),
    brightBlack: Color(0XFF555555),
    red: Color(0XFFcc5555),
    brightRed: Color(0XFFff5555),
    green: Color(0XFF55cc55),
    brightGreen: Color(0XFF55ff55),
    yellow: Color(0XFFcdcd55),
    brightYellow: Color(0XFFffff55),
    blue: Color(0XFF5555cc),
    brightBlue: Color(0XFF5555ff),
    magenta: Color(0XFFcc55cc),
    brightMagenta: Color(0XFFff55ff),
    cyan: Color(0XFF7acaca),
    brightCyan: Color(0XFF55ffff),
    white: Color(0XFFcccccc),
    brightWhite: Color(0XFFffffff),
    searchHitBackground: Color(0XFF000000),
    searchHitBackgroundCurrent: Color(0XFFb3b3b3),
    searchHitForeground: Color(0XFF000000),
));
