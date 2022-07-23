import 'package:chat_composer/chat_composer.dart';
import 'package:flutter/cupertino.dart';
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
  List<String> list = [];
  TextEditingController con = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Chat Composer'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, pos) {
                    return ListTile(title: Text(list[pos]));
                  }),
            ),
            ChatComposer(
              controller: con,
              onReceiveText: (str) {
                setState(() {
                  list.add('TEXT : ${str!}');
                  con.text = '';
                });
              },
              onRecordEnd: (path) {
                setState(() {
                  list.add('AUDIO PATH : ${path!}');
                });
              },
              textPadding: EdgeInsets.zero,
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  Icons.insert_emoticon_outlined,
                  size: 25,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
              actions: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.attach_file_rounded,
                    size: 25,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 25,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
