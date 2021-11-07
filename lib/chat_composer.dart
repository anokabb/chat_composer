import 'package:chat_composer/consts/consts.dart';
import 'package:chat_composer/cubit/recordaudio_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'message_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_composer/send_button.dart';

class ChatComposer extends StatefulWidget {
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
  //Consts
  final double? borderRadius;
  final List<BoxShadow>? shadow;
  final Color? backgroundColor;
  final Color? composerColor;
  final Color? actionsColor;
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

  ChatComposer(
      {Key? key,
      this.focusNode,
      this.controller,
      this.leading,
      this.actions,
      this.textCapitalization,
      this.textInputAction,
      this.keyboardType,
      this.textStyle,
      this.decoration,
      this.textPadding,
      this.backgroundColor,
      this.composerColor,
      this.actionsColor,
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
      this.shadow})
      : super(key: key) {
    localBackgroundColor = backgroundColor ?? localBackgroundColor;
    localComposerColor = composerColor ?? localComposerColor;
    localActionsColor = actionsColor ?? localActionsColor;
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
  }

  @override
  _ChatComposerState createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecordAudioCubit(),
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
                          controller: widget.controller,
                          focusNode: widget.focusNode,
                          keyboardType: widget.keyboardType,
                          textCapitalization: widget.textCapitalization,
                          textInputAction: widget.textInputAction,
                          textPadding: widget.textPadding,
                          textStyle: widget.textStyle,
                          decoration: widget.decoration,
                          leading: widget.leading,
                          actions: widget.actions,
                        ),
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: localComposerColor,
                            borderRadius:
                                BorderRadius.circular(localborderRadius),
                            boxShadow: widget.shadow),
                      ),
                    ),
                  ),
                  const SizedBox(width: composerHeight),
                ],
              ),
              const Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SendButton(composerHeight: composerHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
