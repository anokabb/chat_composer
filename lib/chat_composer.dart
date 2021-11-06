import 'message_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_composer/send_button.dart';

class ChatComposer extends StatefulWidget {
  const ChatComposer({Key? key}) : super(key: key);

  @override
  _ChatComposerState createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer>
    with SingleTickerProviderStateMixin {
  final double composerHeight = 58;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: composerHeight),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MessageField(height: composerHeight),
                          ],
                        ),
                        margin: EdgeInsets.zero,
                        decoration: const BoxDecoration(
                          // color: Color(accentColor2),
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: composerHeight + 8),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SendButton(composerHeight: composerHeight),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
