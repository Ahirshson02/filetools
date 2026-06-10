import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'dart:typed_data';

class ApiSerivce {

  final client = Client();
  String baseurl = "http://localhost:5000";

  Future<Uint8List> pdftoword(Uint8List fileBytes, String filename) async{
    final request = MultipartRequest('POST', Uri.parse('$baseurl/api/convert'));
    final multiipartFile = MultipartFile.fromBytes('file', fileBytes, filename: filename);

    request.files.add(multiipartFile);
    request.fields.addAll({"source": 'pdf', "target": "docx"});
    Uint8List? bytes;
    // print("MADE IT TO API CALL");
    // return fileBytes;
    try{
      final response = await client.send(request);
      if (response.statusCode >= 400){
        String errorMessage = jsonDecode(response.toString())["error"] ?? "unknown error";
        throw ClientException(errorMessage);
      }
      bytes = await response.stream.toBytes();
    }
    catch(e){
      print("error in sending file: $e");
    }
    finally{
      client.close();
      //convert response to File and return
    }
    print("returning from pdfToWord");
    return bytes!;
  }

}