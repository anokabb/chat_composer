part of 'recordaudio_cubit.dart';

@immutable
abstract class RecordaudioState {}

class RecordAudioReady extends RecordaudioState {
  @override
  String toString() {
    return 'RecordAudioReady';
  }
}

class RecordAudioStarted extends RecordaudioState {
  @override
  String toString() {
    return 'RecordAudioStarted';
  }
}

class RecordAudioClosed extends RecordaudioState {
  @override
  String toString() {
    return 'RecordAudioClosed';
  }
}
