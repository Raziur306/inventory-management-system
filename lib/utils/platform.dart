import 'dart:io';

extension Target on Object{
  static bool isPc(){
    return Platform.isWindows||Platform.isMacOS || Platform.isLinux;
}
}