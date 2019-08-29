import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';


class UploadImageData extends StatefulWidget {
  @override
  _UploadImageDataState createState() => _UploadImageDataState();
}

class _UploadImageDataState extends State<UploadImageData> {

  //save the result of gallery file
  File galleryFile;

  //save the result of camera file
  File cameraFile;

  @override
  Widget build(BuildContext context) {

    //display image selected from gallery
    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        //maxHeight: 50.0
        //maxWidth: 50.0
      );
      print("You selected gallery image: " + galleryFile.path);
      setState(() {

      });
    }

    //display image selected from camera
    imageSelectorCamera() async {
      cameraFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        //maxHeight: 50.0
        //maxWidth: 50.0
      );
      print("You selected camera image : " + cameraFile.path);
      setState(() {

      });
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Image and Upload'),
      ),
      body: Builder(
          builder: (BuildContext context) {
            return new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: Text('Select Image from Galeery'),
                  onPressed: imageSelectorGallery,
                ),
                RaisedButton(
                  child: Text('Select Image from Camera'),
                  onPressed: imageSelectorCamera,
                ),
                displaySelectedFile(galleryFile),
                displaySelectedFile(cameraFile)
              ],
            );
          }
      ),
    );
  }

  Widget displaySelectedFile(File file) {
    return new SizedBox(
      height: 200.0,
      width: 300.0,
      //child: new Card(child: new Text(''+galleryFile.toString())),
      //child: new Image.file(galleryFile),
      child: file == null
          ? Text('Sorry nothing selected!')
          : Column(
        children: <Widget>[
          Image.file(
            file,
            width: 150,
            height: 150,
            fit: BoxFit.fill,
          ),
          RaisedButton(
            child: Text("Upload Image"),
            onPressed: () {

              final strURL = "https://api.imgur.com/3/upload";
              uploadImage(file, strURL);

            },
          ),
        ],
      ),
    );
  }

  Future uploadImage(File imageFile, String url) async {

    Map<String, String> headers = {
      "Authorization": "Client-ID 4aed4e7a078ad39",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    final multipartRequest = http.MultipartRequest('POST', Uri.parse(url));
    multipartRequest.headers.addAll(headers);

    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: "image.png");//basename(imageFile.path)

    // add file to multipart
    multipartRequest.files.add(multipartFile);

    // send
    var response = await multipartRequest.send();
    print(response.statusCode);

    //print("\n\n\n JSON Response = ${json.decode(response.body)} \n\n\n");

    ///listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

  }


}
