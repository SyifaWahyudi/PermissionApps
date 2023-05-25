import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_apps/data_api.dart';
import 'package:permission_apps/take_a_photo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  height: Get.height * 0.5,
                  width: Get.width * 0.5,
                  child: Image.asset('assets/images/image001.png')),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TakeaPhoto()));
                },
                child: Container(
                  width: 200.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Center(
                    child: Text('Take a Photo', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.to(const DataApi());
                },
                child: Container(
                  width: 200.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Center(
                    child: Text('Data Api', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _launchURL();
                },
                child: Container(
                  width: 200.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Center(
                    child: Text('open flutter homepage',
                        style: TextStyle(fontSize: 15)),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    final info2 = [Permission.camera].toString();
                    _requestPermission();
                    _toastinfo(info2);
                  },
                  child: const Text('data'))
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async {
      final url = Uri.parse('https://flutter.dev') ;

    if (await canLaunchUrl(url)) {
      await launchUrl(url);//, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage, Permission.camera].request();

    final info = statuses[Permission.storage].toString();
    final info2 = statuses[Permission.camera].toString();
    _toastinfo(info);
    _toastinfo(info2);
  }

  _toastinfo(String info) {
    Fluttertoast.showToast(
        msg: info,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.deepOrange,
        textColor: Colors.black);
  }
}
