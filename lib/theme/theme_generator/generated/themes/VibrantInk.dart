import 'package:flutter/material.dart';
import 'package:xterm/ui.dart';
import './../../../terminal_theme_item.dart';

const TerminalThemeItem VibrantInkTheme = TerminalThemeItem(
  name: "VibrantInkTheme",
  theme: TerminalTheme(
    cursor: Color(0XFFffffff),
    selection: Color(0XFFffffff),
    foreground: Color(0XFFffffff),
    background: Color(0XFF000000),
    black: Color(0XFF878787),
    brightBlack: Color(0XFF555555),
    red: Color(0XFFff6600),
    brightRed: Color(0XFFff0000),
    green: Color(0XFFccff04),
    brightGreen: Color(0XFF00ff00),
    yellow: Color(0XFFffcc00),
    brightYellow: Color(0XFFffff00),
    blue: Color(0XFF44b4cc),
    brightBlue: Color(0XFF0000ff),
    magenta: Color(0XFF9933cc),
    brightMagenta: Color(0XFFff00ff),
    cyan: Color(0XFF44b4cc),
    brightCyan: Color(0XFF00ffff),
    white: Color(0XFFf5f5f5),
    brightWhite: Color(0XFFe5e5e5),
    searchHitBackground: Color(0XFF000000),
    searchHitBackgroundCurrent: Color(0XFFffffff),
    searchHitForeground: Color(0XFF878787),
));
