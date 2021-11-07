import 'dart:async';
import 'dart:io';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
part 'recordaudio_state.dart';

class RecordAudioCubit extends Cubit<RecordaudioState> {
  late FlutterAudioRecorder2? recorder;
  late Timer timer;
  final Function()? onRecordStart;
  final Function(String?) onRecordEnd;
  final Function()? onRecordCancel;
  Duration? maxRecordLength;

  ValueNotifier<Duration?> currentDuration = ValueNotifier(Duration.zero);

  RecordAudioCubit({
    required this.onRecordEnd,
    required this.onRecordStart,
    required this.onRecordCancel,
    required this.maxRecordLength,
  }) : super(RecordAudioReady());

  void toggleRecord({required bool canRecord}) {
    emit(canRecord ? RecordAudioReady() : RecordAudioClosed());
  }

  void startRecord(BuildContext context) async {
    try {
      recorder!.stop();
    } catch (e) {}
    currentDuration.value = Duration.zero;
    try {
      bool hasStorage = await Permission.storage.isGranted;
      bool hasMic = await Permission.microphone.isGranted;

      if (!hasStorage || !hasMic) {
        if (!hasStorage) await Permission.storage.request();
        if (!hasMic) await Permission.microphone.request();
        print('[chat_composer] 🔴 Denied permissions');
        return;
      }
      if (onRecordStart != null) onRecordStart!();

      Directory dir = await getApplicationDocumentsDirectory();
      String path =
          dir.path + '/' + DateTime.now().millisecondsSinceEpoch.toString();

      recorder = FlutterAudioRecorder2(path,
          audioFormat: AudioFormat.AAC); // or AudioFormat.WAV
      await recorder!.initialized;

      await recorder!.start();

      timer = Timer.periodic(const Duration(milliseconds: 200), (t) async {
        Recording? current = await recorder!.current(channel: 0);
        currentDuration.value = current!.duration;
        if (maxRecordLength != null) {
          if (current.duration != null) {
            if (current.duration!.inMilliseconds >=
                maxRecordLength!.inMilliseconds) {
              print('[chat_composer] 🔴 Audio passed max length');
              stopRecord(context);
            }
          }
        }
      });

      emit(RecordAudioStarted());
    } catch (e) {
      emit(RecordAudioReady());
    }
  }

  void stopRecord(BuildContext context) async {
    timer.cancel();
    try {
      Recording? result = await recorder!.stop();
      if (result != null) {
        Duration? duration = result.duration;
        if (duration != null && result.path!.isNotEmpty) {
          if (duration.inMilliseconds > 200) {
            print('[chat_composer] 🟢 Audio path:  "${result.path}"');
            onRecordEnd(result.path);
          } else {
            print('[chat_composer] 🔴 Audio too short');
          }
        }
      }
    } finally {
      currentDuration.value = Duration.zero;
      // context.read<ReplyCubit>().closeReply();
    }
    emit(RecordAudioReady());
  }

  void cancelRecord() async {
    try {
      timer.cancel();
    } catch (e) {}
    try {
      recorder!.stop();
    } catch (e) {}
    emit(RecordAudioReady());
    if (onRecordCancel != null) onRecordCancel!();
    currentDuration.value = Duration.zero;
  }

  @override
  Future<void> close() {
    try {
      recorder!.stop();
    } catch (e) {}
    try {
      recorder = null;
      timer.cancel();
    } catch (e) {}
    return super.close();
  }
}
