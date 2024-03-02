import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  bool showSpinner = false;
  Map<String, dynamic>? _predictionResults;

  Future _pickFrontImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage == null) {
        if (kDebugMode) {
          print("No photo Selected");
        }
      } else {
        image = File(pickedImage.path);
      }
    });
  }


  Future<void> _sendImageToServer(dynamic data) async {
    print('called');
    setState(() {
      showSpinner = false;
    })
    const url = "https://backend-major-2tai.onrender.com/predict/";
    try {
      List<int> imageBytes = await data.readAsBytes();
      String frontFileName = path.basename(data.path);
      String frontExt = path.extension(frontFileName);
      String base64 =
          '${frontExt.split('.')[1]};base64,${base64Encode(imageBytes)}';
      var imageData = jsonEncode({'image': base64});
      var headers = {'Content-type': 'application/json'};
      final response = await http.post(Uri.parse(url), headers: headers, body: imageData);
      if (response.statusCode == 200) {
        dynamic responseJson = jsonDecode(response.body);
        print(responseJson);
        setState(() {
          showSpinner = false;
        });
        return responseJson;
      }
    } catch (e) {
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
