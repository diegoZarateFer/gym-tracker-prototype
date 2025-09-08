import 'package:just_audio/just_audio.dart';

///
/// Singleton para reproducir audio de la app.
///

///
/// TODO: Que reciba cualquier asset de audio.
///

class AppAudioPlayer {
  static final AppAudioPlayer _instance = AppAudioPlayer._internal();
  late AudioPlayer _player;

  AppAudioPlayer._internal() {
    _player = AudioPlayer();
  }

  factory AppAudioPlayer() => _instance;

  Future<void> playSound() async {
    await _player.setAsset(
      "assets/sounds/timer_sounds/timer_alarm_sound_1.mp3",
    );

    _player.setVolume(1.5);
    _player.play();
  }

  Future<void> stopSound() async {
    _player.stop();
  }
}
