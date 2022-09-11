import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class barcodeScanPage extends StatefulWidget {
  File? barcodePicture;



  barcodeScanPage(this.barcodePicture);

  @override
  State<barcodeScanPage> createState() => _barcodeScanPageState();
}

class _barcodeScanPageState extends State<barcodeScanPage> {

  List<Barcode> barcode=[];
  String url="";

  @override
  void initState() {
    getRecognisedBarcode(widget.barcodePicture!);
    // TODO: implement initState
    super.initState();
  }

  void getRecognisedBarcode(File image) async{
    final inputImage=InputImage.fromFilePath(image.path);
    List<BarcodeFormat> barcodelist=[BarcodeFormat.qrCode];
    final barcodeDetector=GoogleMlKit.vision.barcodeScanner(barcodelist);
    barcode = await  barcodeDetector.processImage(inputImage);
    await barcodeDetector.close();
    print("hi");
    print(barcode);
    url=barcode[0].displayValue!;
    setState(() {

    });
  }

  _launchURL() async {
    try{
      await launch(url);
    }catch(e){
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Center(child: Text("스캔한 qr코드 주소\n",style: TextStyle(fontFamily: 'Galmuri14',fontSize: 25),)),
          Center(child: Text(url,style: TextStyle(fontFamily: 'Galmuri14',fontSize: 20),)),
          Center(child: Text("",style: TextStyle(fontFamily: 'Galmuri14',fontSize: 25),)),
          CupertinoButton(
            child: Text("접속", style: TextStyle(fontFamily: 'Galmuri14',fontSize:20)),
            padding: EdgeInsets.zero,
            color: Colors.black,
            onPressed: () {
              _launchURL();
            },
          ),
          Spacer(),
        ],
      )
    );
  }
}



