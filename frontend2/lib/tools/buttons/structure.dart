import 'dart:core';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend2/api_serivce.dart';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:frontend2/tools/fileupload.dart';

class StructureConverter extends StatefulWidget {
  const StructureConverter({super.key});

  @override
  State<StructureConverter> createState() => _StructureConverterState();
}

// typedef FormatEntry = DropdownMenuEntry<Format>;
// enum Format{
//   json("json"),
//   xlsx("xlsx"),

// }

class _StructureConverterState extends State<StructureConverter> {
  ApiSerivce api = ApiSerivce();
  Uint8List? selectedFile;
  String? selectedFileName;
  String source = "json";
  String target = "json";
  //final formats = ["json", "xlsx", "csv"];

  final formats = [
    DropdownMenuEntry(value: "json", label: "json"),
    DropdownMenuEntry(value: "xlsx", label: "xlsx"),
    DropdownMenuEntry(value: "csv", label: "csv"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(withData: true, allowMultiple: false);

    if (result != null) {
      print("Attached file type: ${result.files.first.extension}");
      if(result.files.first.extension != source){
        showMessage(context: context, message: "File does not match selected format");
        return;
      }
      setState(() {
        try {
          selectedFile = result.files.first.bytes;
          if (selectedFile == null) {
            print("FILE IS NULL");
          }
        } catch (e) {
          print("problem getting file from result");
        }
        selectedFileName = result.files.single.name;
      });
      // final bytes = await selectedFile!.readAsBytes();
      final response =
          await api.convertFile(selectedFile!, selectedFileName ?? "", source, target);
      downloadDocx(response);
    }
  }

  void downloadDocx(Uint8List bytes) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..download = '${selectedFileName}_converted.$target'
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  void showMessage(
      {required BuildContext context, required String message, double? width}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
            content: Text(message),
            backgroundColor: const Color.fromARGB(255, 116, 20, 13),
            duration: Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
            width: width ?? 500),
      );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: h * 0.08),
          Text("Convert Structured Data",
              style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          SizedBox(height: h * 0.02),
          FileUploder(
            title: "Convert Structured Data",
            subtitle: "Convert only one file at a time",
            backgroundColor: Color(0xffEFEEF3),
            width: w * 0.70,
            function: () async {
              //if target and source don't match, dont send to server
              print("$target, $source");
              if (target == source) {
                showMessage(
                    context: context,
                    message:
                        "Source and target file formats cannot be the same");
                return;
              }
              await pickFile();
            },
          ),
          SizedBox(height: h * 0.01),
          Text("Select your formats",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: const Color.fromARGB(255, 65, 64,
                      64)) //TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
              ),
          SizedBox(height: h * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownMenu(
                hintText: "Select the file's original format",
                dropdownMenuEntries: formats,
                onSelected: (format) {
                  setState(() {
                    source = format!;
                  });
                },
              ),
              SizedBox(width: w * 0.02),
              Icon(Icons.arrow_forward),
              SizedBox(width: w * 0.02),
              DropdownMenu(
                hintText: "Selected your desired format",
                dropdownMenuEntries: formats,
                onSelected: (format) {
                  setState(() {
                    target = format!;
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
