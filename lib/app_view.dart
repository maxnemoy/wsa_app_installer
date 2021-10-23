import 'package:flutter/material.dart';
import 'package:wsa_app_installer/adb_shell.dart';
import 'package:wsa_app_installer/app_data.dart';
import 'package:flowder/flowder.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppView extends StatefulWidget {
  final AppData data;
  final ADBShell adb;
  AppView({Key? key, required this.data, required this.adb}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  bool isLoad = false;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 200,
        child: Card(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  widget.data.iconPath,
                  width: 80,
                ),
                if (isLoad)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: LinearProgressIndicator(
                      value: progress,
                    ),
                  ),
                if (!isLoad)
                  TextButton.icon(
                      onPressed: () async {
                        Directory? path_to_store_file =
                            await getDownloadsDirectory();

                        final fileName =
                            '${path_to_store_file!.path}\\${widget.data.name}.apk';
                        final downloaderUtils = DownloaderUtils(
                          progressCallback: (current, total) {
                            setState(() {
                              isLoad = true;
                              progress = (current / total) * 100;
                            });
                          },
                          file: File(fileName),
                          progress: ProgressImplementation(),
                          onDone: () {
                            setState(() {
                              isLoad = false;
                              progress = 0;
                              widget.adb.setup("$fileName");
                            });
                          },
                          deleteOnCancel: true,
                        );

                        final core = await Flowder.download(
                            'https://appdl-11-drcn.dbankcdn.com/dl/appdl/application/apk/77/778c4ec7f8e644169084e92e4edb925b/com.huawei.appmarket.2109160959.apk?maple=0&trackId=0&distOpEntity=HWSW',
                            downloaderUtils);
                      },
                      icon: const Icon(Icons.download),
                      label: Text(widget.data.name)),
              ],
            ),
          ),
        ));
  }
}
