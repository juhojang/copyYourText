import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:admob_flutter/admob_flutter.dart';

class textScanPage extends StatefulWidget {
  File? textPicture;

  textScanPage(this.textPicture);

  @override
  State<textScanPage> createState() => _textScanPageState();
}

class _textScanPageState extends State<textScanPage> {

  late AdmobInterstitial interstitialAd;

  String scannedText="";

  @override
  void initState() {
    getRecognisedText(widget.textPicture!);
    interstitialAd = AdmobInterstitial(
      adUnitId: 'ca-app-pub-1960771232772013/9615440761',
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );
    interstitialAd.load();
    // TODO: implement initState
    super.initState();
  }


  void getRecognisedText(File image) async{
    final inputImage=InputImage.fromFilePath(image.path);
    final textDetector=GoogleMlKit.vision.textRecognizer();
    RecognizedText recognisedText=await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText="";
    for (TextBlock block in recognisedText.blocks){
      for(TextLine line in block.lines){
        scannedText=scannedText+line.text;
      }
    }
    print(scannedText);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Spacer(),
            Expanded(child: ListView(children: [Text(scannedText,style: TextStyle(fontFamily: 'Galmuri14',fontSize: 20),)])),
            CupertinoButton(
              child: Text("COPY", style: TextStyle(fontFamily: 'Galmuri14',fontSize: 12)),
              padding: EdgeInsets.zero,
              color: Colors.black,
              onPressed: () {
                interstitialAd.show();
                Clipboard.setData(ClipboardData(text: scannedText));
              },
            ),
            Spacer(),
          ],
        )
    );
  }
}
