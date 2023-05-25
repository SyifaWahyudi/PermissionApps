import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver_v3/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TakeaPhoto extends StatefulWidget {
  const TakeaPhoto({super.key});

  @override
  State<TakeaPhoto> createState() => _TakeaPhotoState();
}

class _TakeaPhotoState extends State<TakeaPhoto> {
  File? file;
  ImagePicker image = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Take A Photo',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () async {
                  PermissionStatus cameraStatus =
                      await Permission.camera.request();

                  if (cameraStatus == PermissionStatus.granted) {
                  } else if (cameraStatus == PermissionStatus.denied) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'This Permission is Recommended to access the camera')));
                  } else if (cameraStatus ==
                      PermissionStatus.permanentlyDenied) {
                    openAppSettings();
                  }
                  //   getcam();
                }, //=> captureImage(),
                child: file == null
                    ? const Icon(
                        Icons.camera_alt,
                        size: 300,
                      )
                    : SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.file(
                          file!,
                          fit: BoxFit.scaleDown,
                        ),
                      )),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                PermissionStatus storageStatus =
                    await Permission.storage.request();

                if (storageStatus == PermissionStatus.granted) {
                  getcam();
                } else if (storageStatus == PermissionStatus.denied) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'This Permission is Recommended to access the camera')));
                } else if (storageStatus ==
                    PermissionStatus.permanentlyDenied) {
                  openAppSettings();
                }

                // _saveScreen();
              },
              child: Container(
                width: 200.0,
                height: 60.0,
                decoration:  BoxDecoration(
                   boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: const Center(
                  child: Text('Open Cam', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                getgall();
              },
              color: Colors.white,
              child: const Text('Take from Gallery',
                  style: TextStyle(fontSize: 20)),
            ),
            MaterialButton(
              onPressed: () {
                _getHttp();
              },
              color: Colors.white,
              child:
                  const Text('Take from http', style: TextStyle(fontSize: 20)),
            ),
            ElevatedButton(
              onPressed: () {
                _saveGif();
              },
              child:
                  const Text('Take from GIF', style: TextStyle(fontSize: 20)),
            ),
            MaterialButton(
              onPressed: () {
                _saveVideo();
              },
              color: Colors.white,
              child:
                  const Text('Take from video', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  _saveVideo() async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = "${appDocDir.path}/temp.mp4";
    String fileUrl =
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
    await Dio()
        .download(fileUrl, savePath, onReceiveProgress: (count, total) {});
    final result = await ImageGallerySaver.saveFile(savePath);
    _toastinfo("$result");
  }

  _saveGif() async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = "${appDocDir.path}/temp.gif";
    String fileUrl =
        "https://hyjdoc.oss-cn-beijing.aliyuncs.com/hyj-doc-flutter-demo-run.gif";
    await Dio().download(fileUrl, savePath);
    final result = await ImageGallerySaver.saveFile(savePath);
    _toastinfo("$result");
  }

  _getHttp() async {
    var response = await Dio().get(
        "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");
    _toastinfo("$result");
  }

  getcam() async {
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  getgall() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

  _toastinfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }
}
