import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';

import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _picker = ImagePicker();
  bool showSpinner = false;
  Map<String, dynamic>? _predictionResults;

  // Future<void> _getImageFromCamera() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     image = File(pickedFile.path);
  //
  //     setState(() {});
  //
  //     _sendImageToServer(image);
  //   } else {
  //     // User canceled image selection or an error occurred
  //     print("Image selection canceled or an error occurred");
  //   }
  // }

  Future<void> _sendImageToServer(dynamic data) async {
    print('called');
    const url = "https://backend-major-2tai.onrender.com/predict";

    try {
      List<int> imageBytes = await data.readAsBytes();
      String frontFileName = path.basename(data.path);
      String frontExt = path.extension(frontFileName);
      String base64 =
          '${frontExt.split('.')[1]};base64,${base64Encode(imageBytes)}';
      var imageData = jsonEncode({'image': base64});
      var headers = {'Content-type': 'application/json'};
      final response = await http.post(Uri.parse(url), headers: headers, body: imageData);


      print(response);
      if (response.statusCode == 200) {
        dynamic responseJson = jsonDecode(response.body);
        print(responseJson);

        return responseJson;
      }
    } catch (e) {
      print(e);
    }
  }
  File? _image;

  Future _pickFrontImage() async {
    final ImagePicker picker = ImagePicker();
    File? _image;
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage == null) {
        if (kDebugMode) {
          print("No photo Selected");
        }
      } else {
        _image = File(pickedImage.path);
        _sendImageToServer(_image);
      }
    });
  }

  // Future<void> _sendImageToServer() async {
  //
  //   setState(() {
  //     showSpinner = true;
  //   });
  //
  //   const url = "https://backend-major-2tai.onrender.com/predict"; // Replace with your Flask server IP
  //
  //
  //   try {
  //     var stream = new http.ByteStream(image!.openRead());
  //     stream.cast();
  //
  //     var length =  image!.length;
  //     print(length);
  //     var uri = Uri.parse(url);
  //
  //     var request = http.MultipartRequest('POST', uri);
  //       // ..headers['Content-Type'] = 'multipart/form-data'
  //       // ..files.add(await http.MultipartFile.fromPath('image', _image?.path ?? ''));
  //     var multiport = http.MultipartFile('image', stream, length);
  //     request.files.add(multiport);
  //     var response = await request.send();
  //     print("request send");
  //
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         showSpinner = false;
  //       });
  //       var responseBody = await response.stream.bytesToString();
  //       final Map<String, dynamic> data = json.decode(responseBody);
  //       if (data['success']) {
  //         // Process the results
  //         setState(() {
  //           _predictionResults = data['results'];
  //            print(responseBody);
  //
  //         });
  //       } else {
  //         print('Error: ${data['error']}');
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Error: ${data['error']}'),
  //             duration: Duration(seconds: 7),
  //           ),
  //         );
  //       }
  //     } else {
  //       print('Server error: ${response.statusCode}');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Server error: ${response.statusCode}'),
  //           duration: Duration(seconds: 7),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error: $e'),
  //         duration: Duration(seconds: 7),
  //       ),
  //     );
  //   }
  // }

  @override
  // Widget build(BuildContext context) {
  //   return ModalProgressHUD(
  //     inAsyncCall: showSpinner,
  //     child: Scaffold(
  //       body: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Container(
  //             child: image ==null ? Center(child: Text('pick Image'),)
  //                 :
  //             Container(
  //               child: Center(
  //                 child: Image.file(File(image!.path).absolute,
  //                 height: 100,
  //                 width: 100,
  //                 ),
  //               )
  //             )
  //           ),
  //           SizedBox(height: 16,),
  //           GestureDetector(
  //             onTap: ,
  //             child: Container(
  //               height: 5,
  //               color: Colors.blue,
  //               child: Text('Upload'),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    bool isPressed = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('NSL', style: TextStyle(fontSize: 16),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 18,),
            showImage(_image),
            ElevatedButton(onPressed: () async{
             await  _pickFrontImage();
            }, child: Text('Select From Gallary'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple)
              ),),
            SizedBox(height: 18,),
            ElevatedButton(onPressed: (){
              _sendImageToServer(_image);
            }, child: Text('get'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple)
            ),),
            SizedBox(height: 20,),
            Divider(
              thickness: 2,
            ),
            Text('Result',style: TextStyle(color: Colors.amberAccent, fontSize: 24),),
            // Container(
            //   height: 50,
            //   width: 100,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(8)
            //   ),
            //   child: Center(child: Text('क',style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),)),
            // ),
            // SizedBox(height: 8,),
            // Container(
            //   height: 50,
            //   width: 100,
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(8)
            //   ),
            //   child: Center(child: Text('0.96',style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),)),
            // )
          ],
        ),
      ),
    );
  }
  showImage(File? img) {
    if (img != null) {
      return Padding(
        padding: const EdgeInsets.only(left:10.0, right: 10.0),
        child: Card(

            child: Container(
              height: 450,
              padding: const EdgeInsets.all(10.0),
              width: 400,
              child: Image.file(img),
            )),
      );
    } else {
      return Card(
          child: Container(
            color: Colors.grey,
            height: 200,
            padding: const EdgeInsets.all(10.0),
            width: 200,
            child: Center(child: Text('No Photo Selected', style: TextStyle(color: Colors.blue, fontSize: 20),)),
          ));
    }
  }
}
