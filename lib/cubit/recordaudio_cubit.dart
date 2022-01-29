// ignore_for_file: empty_catches
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'recordaudio_state.dart';

class RecordAudioCubit extends Cubit<RecordaudioState> {
  final FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  final Function()? onRecordStart;
  final Function(String?) onRecordEnd;
  final Function()? onRecordCancel;
  Duration? maxRecordLength;

  ValueNotifier<Duration?> currentDuration = ValueNotifier(Duration.zero);
  StreamSubscription? recorderStream;

  RecordAudioCubit({
    required this.onRecordEnd,
    required this.onRecordStart,
    required this.onRecordCancel,
    required this.maxRecordLength,
  }) : super(RecordAudioReady()) {
    _myRecorder.openAudioSession().then((value) {
      _myRecorder.setSubscriptionDuration(const Duration(milliseconds: 200));
      recorderStream = _myRecorder.onProgress!.listen((event) {
        Duration current = event.duration;
        currentDuration.value = current;
        if (maxRecordLength != null) {
          if (current.inMilliseconds >= maxRecordLength!.inMilliseconds) {
            print('[chat_composer] 🔴 Audio passed max length');
            stopRecord();
          }
        }
      });
    });
  }

  void toggleRecord({required bool canRecord}) {
    emit(canRecord ? RecordAudioReady() : RecordAudioClosed());
  }

  void startRecord() async {
    try {
      _myRecorder.stopRecorder();
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
      String path = dir.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.aac';

      await _myRecorder.startRecorder(
        toFile: path,
        codec: Codec.aacADTS,
      );

      emit(RecordAudioStarted());
    } catch (e) {
      emit(RecordAudioReady());
    }
  }

  void stopRecord() async {
    // timer.cancel();
    try {
      String? result = await _myRecorder.stopRecorder();
      if (result != null) {
        print('[chat_composer] 🟢 Audio path:  "$result');
        onRecordEnd(result);
      }
    } finally {
      currentDuration.value = Duration.zero;
    }
    emit(RecordAudioReady());
  }

  void cancelRecord() async {
    try {
      _myRecorder.stopRecorder();
    } catch (e) {}
    emit(RecordAudioReady());
    if (onRecordCancel != null) onRecordCancel!();
    currentDuration.value = Duration.zero;
  }

  @override
  Future<void> close() {
    try {
      _myRecorder.closeAudioSession();
    } catch (e) {}
    try {
      // _myRecorder = null;
      // timer.cancel();
    } catch (e) {}
    return super.close();
  }
}
