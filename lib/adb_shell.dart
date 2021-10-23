import 'package:shell/shell.dart';

class ADBShell {
  final Shell shell;
  final String address;

  ADBShell({required this.address}) : shell = Shell();

  void connect() async {
    var pwd = await shell.startAndReadAsString('.\\platform-tools\\adb.exe',
        arguments: ["connect", address]);
    print('ADB: $pwd');
  }

  void disconnect() async {
    var pwd = await shell.startAndReadAsString('.\\platform-tools\\adb.exe',
        arguments: ["disconnect", address]);
    print('cwd: $pwd');
  }

  Future<bool> setup(String appPath) async {
    var pwd = await shell
        .startAndReadAsString('.\\platform-tools\\adb.exe', arguments: [
      "install",
      appPath
    ]);
    print('cwd: $pwd');
    return true;
  }

  Future<bool> status() async {
    var pwd = await shell.startAndReadAsString('.\\platform-tools\\adb.exe',
        arguments: ["devices"]);
    print('cwd: $pwd');
    return false;
  }
}