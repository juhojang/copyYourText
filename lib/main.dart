import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled40/textScan.dart';
import 'barcodeScan.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File? _image;

  final picker = ImagePicker();

  void getImageBarcode() async {
    PickedFile? image =
    await picker.getImage(source: ImageSource.gallery);
    if(image != null) {
      _image = File(image.path);
    }
    setState(() {

    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>barcodeScanPage(_image)));
  }

  void getImageBarcodeCamera() async {
    PickedFile? image =
    await picker.getImage(source: ImageSource.camera);
    if(image != null) {
      _image = File(image.path);
    }
    setState(() {

    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>barcodeScanPage(_image)));
  }

  void getImageText() async {
    PickedFile? image =
    await picker.getImage(source: ImageSource.gallery);
    if(image != null) {
      _image = File(image.path);
    }
    setState(() {

    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>textScanPage(_image)));
  }

  void getImageTextCamera() async {
    PickedFile? image =
    await picker.getImage(source: ImageSource.camera);
    if(image != null) {
      _image = File(image.path);
    }
    setState(() {

    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>textScanPage(_image)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Spacer(),
            Text("Scan",style: TextStyle(fontFamily: 'Silkscreen-Bold',fontSize: 30),),
            Text("Everything",style: TextStyle(fontFamily: 'Silkscreen-Bold',fontSize: 30),),
            Text("QR_TEXT",style: TextStyle(fontFamily: 'Silkscreen-Bold',fontSize: 30),),
            Text("",style: TextStyle(fontFamily: 'Silkscreen-Bold',fontSize: 30),),
            Text("QR_TEXT 인식",style: TextStyle(fontFamily: 'Galmuri11-Bold',fontSize: 25),),
            Spacer(),
            Row(
              children: [
                Spacer(),
                Icon(Icons.qr_code,color: Colors.black,size: 30,),
                Text(" QR_Code",style: TextStyle(fontFamily: 'Galmuri11-Bold',fontSize: 20),),
                Spacer(),
              ],
            ),
            Row(
              children: [
                Spacer(),
                IconButton(onPressed: getImageBarcodeCamera, icon: Icon(Icons.camera_alt_outlined,color: Colors.black,size: 30,)),
                Spacer(),
                IconButton(onPressed: getImageBarcode
                    , icon: Icon(Icons.photo,color: Colors.black,size: 30,)),
                Spacer(),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Spacer(),
                Icon(Icons.text_fields,color: Colors.black,size: 30,),
                Text(" Text",style: TextStyle(fontFamily: 'Galmuri11-Bold',fontSize: 20),),
                Spacer(),
              ],
            ),
            Row(
              children: [
                Spacer(),
                IconButton(onPressed: getImageTextCamera, icon: Icon(Icons.camera_alt_outlined,color: Colors.black,size: 30,)),
                Spacer(),
                IconButton(onPressed: getImageText, icon: Icon(Icons.photo,color: Colors.black,size: 30,)),
                Spacer(),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
