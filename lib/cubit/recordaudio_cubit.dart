import 'dart:async';
import 'dart:developer';
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

  ValueNotifier<Duration?> currentDuration = ValueNotifier(Duration.zero);

  RecordAudioCubit() : super(RecordAudioReady());

  void toggleRecord({required bool canRecord}) {
    log('toggle record');
    emit(canRecord ? RecordAudioReady() : RecordAudioClosed());
  }

  void startRecord(BuildContext context) async {
    log('startRecord');
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
        return;
      }

      // context.read<AudioPlayerCubit>().stop();

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
        if (current.duration != null) {
          if (current.duration!.inMilliseconds >= (90 * 1000)) {
            log('audio max length');
            stopRecord(context);
          }
        }
      });

      emit(RecordAudioStarted());
    } catch (e) {
      emit(RecordAudioReady());
    }
  }

  void stopRecord(BuildContext context) async {
    log('stopRecord');
    timer.cancel();
    try {
      Recording? result = await recorder!.stop();
      if (result != null) {
        Duration? duration = result.duration;
        if (duration != null && result.path!.isNotEmpty) {
          log('audio path : ' + result.path.toString());
          if (duration.inMilliseconds > 300) {
            // context.read<ConversationBloc>().add(MessageAdded(
            //       Message(
            //         text: 'Send Audio',
            //         type: Message_Audio_Type,
            //         temporaryAudioPath: result.path,
            //         audioDuration: duration.inMilliseconds,
            //       ),
            //       context.read<ReplyCubit>().state,
            //     ));
          }
        }
      }
    } catch (e) {
    } finally {
      currentDuration.value = Duration.zero;
      // context.read<ReplyCubit>().closeReply();
    }
    emit(RecordAudioReady());
  }

  void cancelRecord() async {
    log('cancelRecord');
    try {
      timer.cancel();
    } catch (e) {}
    try {
      recorder!.stop();
    } catch (e) {}
    emit(RecordAudioReady());
    currentDuration.value = Duration.zero;
  }

  @override
  Future<void> close() {
    log('Record cubit closed');
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
