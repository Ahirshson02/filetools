import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend2/tools/pdf/fileupload.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:frontend2/api_serivce.dart';
import 'dart:html' as html;

class PdfToWord extends StatefulWidget {
  const PdfToWord({super.key});

  @override
  State<PdfToWord> createState() {
    return _PdfToWordState();
  }
}

class _PdfToWordState extends State<PdfToWord> {
  ApiSerivce api = ApiSerivce();
  Uint8List? selectedFile;
  String? selectedFileName;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(withData: true, allowMultiple: false);
    if (result != null){
      setState(() {
        try{
        selectedFile = result.files.first.bytes;
        if(selectedFile == null){
          print("FILE IS NULL");
        }
        }catch(e){
          print("problem getting file from result");
        }
        selectedFileName = result.files.single.name;
      });
    // final bytes = await selectedFile!.readAsBytes();
    final response = await api.pdftoword(selectedFile!, selectedFileName ?? "");
    downloadDocx(response);
    }
  }
  void downloadDocx(Uint8List bytes){
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..download = '${selectedFileName}_converted.docx'
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.08),
            Text(
              "PDF to Word",
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: height * 0.02),
            FileUploder(
              title: "PDF to Word",
              subtitle: "Convert only one file at a time",
              backgroundColor: Color(0xffEFEEF3),
              width: width * 0.70,
              function: pickFile
              
            )
          ],
        ));
  }
}
