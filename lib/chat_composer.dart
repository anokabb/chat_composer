import 'package:chat_composer/consts/consts.dart';
import 'package:chat_composer/cubit/recordaudio_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/message_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_composer/widgets/send_button.dart';

class ChatComposer extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final InputDecoration? textFieldDecoration;
  final EdgeInsetsGeometry? textPadding;

  /// A widget to display before the [TextField].
  final Widget? leading;

  /// A list of Widgets to display in a row after the [TextField] widget.
  final List<Widget>? actions;

  /// A callback when submit Text Message.
  final Function(String?) onReceiveText;

  /// A callback when start recording.
  final Function()? onRecordStart;

  /// A callback when end recording, return the recorder audio path.
  final Function(String?) onRecordEnd;

  /// A callback when cancel recording.
  final Function()? onRecordCancel;

  /// A callback when the user does not lock the recording or does not hold.
  final Function()? onPanCancel;

  /// Audio max duration should record then return recorder audio path.
  final Duration? maxRecordLength;

  //Consts
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadow;
  final Color? backgroundColor;
  final Color? composerColor;
  final Color? sendButtonColor;
  final Color? sendButtonBackgroundColor;
  final Color? lockColor;
  final Color? lockBackgroundColor;
  final Color? recordIconColor;
  final Color? deleteButtonColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final IconData? sendIcon;
  final IconData? recordIcon;

  ChatComposer({
    Key? key,
    required this.onReceiveText,
    required this.onRecordEnd,
    this.onRecordStart,
    this.onRecordCancel,
    this.focusNode,
    this.controller,
    this.leading,
    this.actions,
    this.textCapitalization,
    this.textInputAction,
    this.keyboardType,
    this.textStyle,
    this.textFieldDecoration,
    this.textPadding,
    this.backgroundColor,
    this.composerColor,
    this.sendButtonColor,
    this.sendButtonBackgroundColor,
    this.lockColor,
    this.lockBackgroundColor,
    this.recordIconColor,
    this.deleteButtonColor,
    this.textColor,
    this.padding,
    this.sendIcon,
    this.recordIcon,
    this.borderRadius,
    this.shadow,
    this.maxRecordLength,
    this.onPanCancel,
  }) : super(key: key) {
    localBackgroundColor = backgroundColor ?? localBackgroundColor;
    localComposerColor = composerColor ?? localComposerColor;
    localSendButtonColor = sendButtonColor ?? localSendButtonColor;
    localSendButtonBackgroundColor =
        sendButtonBackgroundColor ?? localSendButtonBackgroundColor;
    localLockColor = lockColor ?? localLockColor;
    localLockBackgroundColor = lockBackgroundColor ?? localLockBackgroundColor;
    localRecordIconColor = recordIconColor ?? localRecordIconColor;
    localDeleteButtonColor = deleteButtonColor ?? localDeleteButtonColor;
    localTextColor = textColor ?? localTextColor;
    localPadding = padding ?? localPadding;
    localSendIcon = sendIcon ?? localSendIcon;
    localRecordIcon = recordIcon ?? localRecordIcon;
    localborderRadius = borderRadius ?? localborderRadius;
    localController = controller ?? localController;
  }

  @override
  _ChatComposerState createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecordAudioCubit(
        onRecordEnd: widget.onRecordEnd,
        onRecordCancel: widget.onRecordCancel,
        onRecordStart: widget.onRecordStart,
        maxRecordLength: widget.maxRecordLength,
      ),
      child: Container(
        color: localBackgroundColor,
        child: Padding(
          padding: localPadding,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: composerHeight),
                      child: Container(
                        child: MessageField(
                          controller: localController,
                          focusNode: widget.focusNode,
                          keyboardType: widget.keyboardType,
                          textCapitalization: widget.textCapitalization,
                          textInputAction: widget.textInputAction,
                          textPadding: widget.textPadding,
                          textStyle: widget.textStyle,
                          decoration: widget.textFieldDecoration,
                          leading: widget.leading,
                          actions: widget.actions,
                        ),
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: localComposerColor,
                            borderRadius: localborderRadius,
                            boxShadow: widget.shadow),
                      ),
                    ),
                  ),
                  const SizedBox(width: composerHeight),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SendButton(
                  composerHeight: composerHeight,
                  onReceiveText: widget.onReceiveText,
                  onPanCancel: widget.onPanCancel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
