import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:wsa_app_installer/adb_shell.dart';

class DropTargetArea extends StatefulWidget {
  final ADBShell adb;
  const DropTargetArea({Key? key,required this.adb}) : super(key: key);

  @override
  _DropTargetAreaState createState() => _DropTargetAreaState();
}

class _DropTargetAreaState extends State<DropTargetArea> {
  final List<Uri> _list = [];

  bool _dragging = false;

  Offset? offset;

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (detail) async{
        setState(() {
          _list.addAll(detail.urls);
        });
        detail.urls.forEach((element) async{
          await widget.adb.setup(element.toFilePath());
        });
        setState(() {
          _list.clear();
        });
      },
      onDragUpdated: (details) {
        setState(() {
          offset = details.localPosition;
        });
      },
      onDragEntered: (detail) {
        setState(() {
          _dragging = true;
          offset = detail.localPosition;
        });
      },
      onDragExited: (detail) {
        setState(() {
          _dragging = false;
          offset = null;
        });
      },
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
            color: !_dragging
                ? Theme.of(context).cardTheme.color
                : Theme.of(context).focusColor,
            border: Border.all(width: 3, color: Theme.of(context).focusColor),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Stack(
          children: [
            if (_list.isEmpty)
              const Center(child: Text("Drop .apk file here"))
            else
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).focusColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Installing...")
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
