import 'package:flutter/material.dart';
import 'package:xterm/ui.dart';
import './../../../terminal_theme_item.dart';

const TerminalThemeItem DesertTheme = TerminalThemeItem(
  name: "DesertTheme",
  theme: TerminalTheme(
    cursor: Color(0XFF00ff00),
    selection: Color(0XFF00ff00),
    foreground: Color(0XFFffffff),
    background: Color(0XFF333333),
    black: Color(0XFF4d4d4d),
    brightBlack: Color(0XFF555555),
    red: Color(0XFFff2b2b),
    brightRed: Color(0XFFff5555),
    green: Color(0XFF98fb98),
    brightGreen: Color(0XFF55ff55),
    yellow: Color(0XFFf0e68c),
    brightYellow: Color(0XFFffff55),
    blue: Color(0XFFcd853f),
    brightBlue: Color(0XFF87ceff),
    magenta: Color(0XFFffdead),
    brightMagenta: Color(0XFFff55ff),
    cyan: Color(0XFFffa0a0),
    brightCyan: Color(0XFFffd700),
    white: Color(0XFFf5deb3),
    brightWhite: Color(0XFFffffff),
    searchHitBackground: Color(0XFF333333),
    searchHitBackgroundCurrent: Color(0XFFffffff),
    searchHitForeground: Color(0XFF4d4d4d),
));
