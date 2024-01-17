// @dart = 2.12
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:mobx/mobx.dart';
import 'package:web_log_console/model/cmd.pbenum.dart';

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

  @action
  void updateLogLevel(LogLevel logLevel) {
    _logLevel = logLevel;
  }

  @action
  void updateLogType(LogType logType) {
    _logType = logType;
  }
}
