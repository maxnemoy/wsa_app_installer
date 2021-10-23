import 'package:flutter/material.dart';
import 'package:wsa_app_installer/adb_shell.dart';
import 'package:wsa_app_installer/app_data.dart';
import 'package:wsa_app_installer/app_view.dart';
import 'package:wsa_app_installer/drop_target.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ADBShell? _adb;
  TextEditingController? _ipAddress;

  @override
  void initState() {
    _ipAddress = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: AppBar(
        title: const Text("WSA App Installer (Experimental)"),
      ),
      body: _adb == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _ipAddress!,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            label: Text("ADB IP Adress")),
                      )),
                  TextButton(
                    child: const Text("Set ADB IP"),
                    onPressed: () {
                      setState(() {
                        _adb = ADBShell(address: _ipAddress!.text);
                        _adb!.connect();
                      });
                    },
                  )
                ],
              ),
            )
          : Center(
              child: Column(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: MediaQuery.of(context).size.width > 800 ? 5 : 3,
                      children: appList
                          .map((e) => AppView(
                                data: e,
                                adb: _adb!,
                              ))
                          .toList(),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DropTargetArea(adb: _adb!),
                  )),
                ],
              ),
            ),
    );
  }
}
