import 'dart:async';

import 'package:qr_code/screens/videoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _scanBarcode = 'Unknown';
  Future<void>? _launched;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri.parse(_scanBarcode);
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Center(child: const Text('Barcode scan'))),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () => scanBarcodeNormal(),
                            child: Text('Start Barcode scan')),
                        ElevatedButton(
                            onPressed: () => {
                                  if (_scanBarcode ==
                                      "https://github.com/deskbtm/android-adb-wlan")
                                    {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => VideoScreen())),
                                    }
                                },
                            child: Text('Watch The Video')),
                        Text('Scan result : $_scanBarcode\n',
                            style: TextStyle(fontSize: 20))
                      ]));
            })));
  }
}
