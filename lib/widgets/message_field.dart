import '../consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/recordaudio_cubit.dart';

class MessageField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Widget? leading;
  final List<Widget>? actions;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final InputDecoration? decoration;
  final EdgeInsetsGeometry? textPadding;

  const MessageField({
    Key? key,
    this.actions,
    this.focusNode,
    this.controller,
    this.leading,
    this.textCapitalization,
    this.textInputAction,
    this.keyboardType,
    this.textStyle,
    this.decoration,
    this.textPadding,
  }) : super(key: key);

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  @override
  void initState() {
    localController.addListener(() {
      context
          .read<RecordAudioCubit>()
          .toggleRecord(canRecord: localController.text.isEmpty);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: composerHeight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (widget.leading != null) widget.leading!,
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 160),
              child: Padding(
                padding: widget.textPadding ??
                    const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  focusNode: widget.focusNode,
                  controller: widget.controller,
                  textCapitalization:
                      widget.textCapitalization ?? TextCapitalization.sentences,
                  textInputAction:
                      widget.textInputAction ?? TextInputAction.newline,
                  keyboardType: widget.keyboardType ?? TextInputType.multiline,
                  style:
                      widget.textStyle ?? const TextStyle(color: Colors.black),
                  autofocus: false,
                  maxLines: null,
                  onChanged: (s) {
                    context
                        .read<RecordAudioCubit>()
                        .toggleRecord(canRecord: s.isEmpty);
                  },
                  decoration: widget.decoration ??
                      const InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                ),
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
