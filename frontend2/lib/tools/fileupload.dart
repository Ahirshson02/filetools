import 'dart:isolate';

import 'package:flutter/material.dart';

class FileUploder extends StatefulWidget {
  const FileUploder( //add a themecolor (Red for pdf, green for excel, etc?)
      {Key? key,
      required this.title,
      this.subtitle,
      this.backgroundColor,
      this.width,
      this.function,
      this.themeColor,
      this.height})
      : super(key: key);

  final String title;
  final String? subtitle;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final Color? themeColor;
  final Future<void> Function()? function;

  @override
  State<FileUploder> createState() => _FileUploderState();
}

enum FileStates { empty, attached, loading, received }

class _FileUploderState extends State<FileUploder> {
  FileStates filestate = FileStates.empty;

  void dummyClick() {
    print("dummy Click");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 700,
      height: widget.height ?? 300,
     // color: widget.backgroundColor ?? Colors.grey,
     //foregroundDecoration: BoxDecoration(co),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.grey,
        border: Border.all(color: Colors.blueGrey, width: 4),
        borderRadius: BorderRadius.circular(5),
        
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ElevatedButton(
          //     style: ButtonStyle(),
          //     onPressed: dummyClick,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Icon(Icons.file_upload_rounded),
          //         Text(
          //           (filestate == FileStates.empty
          //               ? "Choose File"
          //               : "Choose A New File"),
          //           style: TextStyle(
          //               fontWeight: FontWeight.w600,
          //               fontSize: 16,
          //               color: Colors.white),
          //         )
          //       ],
          //     )),
          ElevatedButton.icon(
            onPressed: widget.function ?? dummyClick,
            icon: const Icon(Icons.insert_drive_file_outlined, size: 28, color: Colors.white),
            label: const Text('Choose files', style: TextStyle(fontSize: 28)),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.themeColor ?? const Color(0xFF6360C8), //make a theme color?
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 3,
              shadowColor: Color(0x386360C8),
            ),
          ),
          Text(widget.subtitle ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: const Color.fromARGB(255, 65, 64, 64)))
        ],
      ),
    );
  }
}
