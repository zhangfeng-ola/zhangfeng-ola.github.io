import 'package:flutter/material.dart';
import 'package:xterm/ui.dart';
import './../../../terminal_theme_item.dart';

const TerminalThemeItem DarksideTheme = TerminalThemeItem(
  name: "DarksideTheme",
  theme: TerminalTheme(
    cursor: Color(0XFFbbbbbb),
    selection: Color(0XFFbbbbbb),
    foreground: Color(0XFFbababa),
    background: Color(0XFF222324),
    black: Color(0XFF000000),
    brightBlack: Color(0XFF000000),
    red: Color(0XFFe8341c),
    brightRed: Color(0XFFe05a4f),
    green: Color(0XFF68c256),
    brightGreen: Color(0XFF77b869),
    yellow: Color(0XFFf2d42c),
    brightYellow: Color(0XFFefd64b),
    blue: Color(0XFF1c98e8),
    brightBlue: Color(0XFF387cd3),
    magenta: Color(0XFF8e69c9),
    brightMagenta: Color(0XFF957bbe),
    cyan: Color(0XFF1c98e8),
    brightCyan: Color(0XFF3d97e2),
    white: Color(0XFFbababa),
    brightWhite: Color(0XFFbababa),
    searchHitBackground: Color(0XFF222324),
    searchHitBackgroundCurrent: Color(0XFFbababa),
    searchHitForeground: Color(0XFF000000),
));
