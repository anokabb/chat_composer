import 'package:chat_composer/chat_composer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            const Expanded(child: Text('Running on: ')),
            ChatComposer(
              onRecordEnd: (dddd) {},
              onReceiveText: (str) {},
            ),
          ],
        ),
      ),
    );
  }
}

// CupertinoButton(
          //   child: const Icon(
          //     Icons.insert_emoticon_outlined,
          //     size: 25,
          //     color: Colors.grey,
          //   ),
          //   onPressed: () {},
          // ),


           // [
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 4),
                  //       child: InkWell(
                  //         child: const Icon(
                  //           Icons.camera_alt_outlined,
                  //           size: 25,
                  //           color: Colors.grey,
                  //         ),
                  //         onTap: () => sendImage(ImageType.Camera, context),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 4),
                  //       child: InkWell(
                  //         child: const Icon(
                  //           Icons.image_outlined,
                  //           size: 25,
                  //           color: Colors.grey,
                  //         ),
                  //         onTap: () => sendImage(ImageType.Gallery, context),
                  //       ),
                  //     ),
                  //   ]
