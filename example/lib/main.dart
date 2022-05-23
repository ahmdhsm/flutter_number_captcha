import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_number_captcha/flutter_number_captcha.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    // try {
    //   platformVersion =
    //       await FlutterTextCaptcha.platformVersion ?? 'Unknown platform version';
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () async {
                final bool test = await FlutterNumberCaptcha.show(
                  context,
                  titleText: 'Enter correct number',
                  placeholderText: 'Enter Number',
                  checkCaption: 'Check',
                  accentColor: Colors.blue,
                  invalidText: 'Invalid code',
                );
                // TODO: Do whatever you want with the result!
                print(test);
              },
              child: const Text('Open Default Captcha'),
            ),
            TextButton(
              onPressed: () async {
                final bool test = await FlutterNumberCaptcha.show(
                  context,
                  titleText: 'Resuelva el captcha',
                  placeholderText: 'Introduzca el número',
                  checkCaption: 'Comprobar',
                  invalidText: "Número inválido",
                  accentColor: Colors.deepPurple,
                );
                // TODO: Do whatever you want with the result!
                print(test);
              },
              child: const Text('Open Captcha - Customized'),
            ),
          ],
        ),
      ),
    );
  }
}
