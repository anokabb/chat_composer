import 'consts/consts.dart';
import 'cubit/recordaudio_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/message_field.dart';
import 'package:flutter/material.dart';
import 'widgets/send_button.dart';

class ChatComposer extends StatefulWidget {
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

  /// focusNode
  final FocusNode? focusNode;

  /// controller
  final TextEditingController? controller;

  /// textCapitalization
  final TextCapitalization? textCapitalization;

  /// textInputAction
  final TextInputAction? textInputAction;

  /// keyboardType
  final TextInputType? keyboardType;

  /// textStyle
  final TextStyle? textStyle;

  /// textFieldDecoration
  final InputDecoration? textFieldDecoration;

  /// textPadding
  final EdgeInsetsGeometry? textPadding;

  /// borderRadius
  final BorderRadius? borderRadius;

  /// shadow
  final List<BoxShadow>? shadow;

  /// backgroundColor
  final Color? backgroundColor;

  /// composerColor
  final Color? composerColor;

  /// sendButtonColor
  final Color? sendButtonColor;

  /// sendButtonBackgroundColor
  final Color? sendButtonBackgroundColor;

  /// lockColor
  final Color? lockColor;

  /// lockBackgroundColor
  final Color? lockBackgroundColor;

  /// recordIconColor
  final Color? recordIconColor;

  /// deleteButtonColor
  final Color? deleteButtonColor;

  /// textColor
  final Color? textColor;

  /// padding
  final EdgeInsetsGeometry? padding;

  /// sendIcon
  final IconData? sendIcon;

  /// recordIcon
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
  State<ChatComposer> createState() => _ChatComposerState();
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
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: localComposerColor,
                            borderRadius: localborderRadius,
                            boxShadow: widget.shadow),
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

  @override
  void dispose() {
    localController.dispose();
    if (widget.focusNode != null) widget.focusNode!.dispose();
    super.dispose();
  }
}
