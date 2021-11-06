import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/recordaudio_cubit.dart';

class MessageField extends StatefulWidget {
  final List<Widget>? actions;
  final double height;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const MessageField(
      {required this.height, this.actions, this.focusNode, this.controller});
  @override
  _MessageFieldState createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: widget.height),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CupertinoButton(
            child: const Icon(
              Icons.insert_emoticon_outlined,
              size: 25,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 160),
              child: TextField(
                focusNode: widget.focusNode,
                controller: widget.controller,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(color: Colors.black),
                autofocus: false,
                maxLines: null,
                onChanged: (s) {
                  context
                      .read<RecordAudioCubit>()
                      .toggleRecord(canRecord: s.isEmpty);
                },
                decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          if (widget.actions != null)
            BlocBuilder<RecordAudioCubit, RecordaudioState>(
              builder: (context, state) {
                if (state is RecordAudioReady) {
                  return Row(
                    children: widget.actions!,
                  );
                  // return Row(
                  //   children: [
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
                  //   ],
                  // );
                }
                return Container();
              },
            ),
          const SizedBox(width: 4)
        ],
      ),
    );
  }
}
