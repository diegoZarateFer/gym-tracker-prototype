import 'dart:async';
import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_ui/core/extensions/context_ext.dart';
import 'package:gym_tracker_ui/core/sound/app_audio_player.dart';
import 'package:gym_tracker_ui/pages/widgets/modal_bottom_handle.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

///
/// TODO: Implementar un bloc o cubit para gestionar este estado a lo largo
/// del resto de pantallas.
///

const timerTickInterval = Duration(seconds: 1);

class RestTimerDialog extends StatefulWidget {
  const RestTimerDialog({super.key, required this.initialTime});

  final Duration initialTime;

  @override
  State<RestTimerDialog> createState() => _RestTimerDialogState();
}

class _RestTimerDialogState extends State<RestTimerDialog> {
  ///
  /// Logger.
  ///
  static final Logger logger = Logger();

  ///
  /// Variables para controlar el temporizador.
  ///

  late Duration _remainningTime;
  Timer? _timer;

  bool _timerIsPaused = false;
  bool _timerIsFinished = false;

  AlarmSettings? _alarmSettings;

  ///
  /// Stream para controlar las alarmas.
  ///
  static StreamSubscription<AlarmSet>? ringSubscription;

  ///
  /// Funcion para obtener el label del tiempo restante.
  ///
  String _getRemainningTimeLabel(Duration remainningTime) {
    final minutes = remainningTime.inMinutes;
    final seconds = remainningTime.inSeconds % 60;

    final labelMinutes = minutes < 10 ? "0$minutes" : "$minutes";
    final labelSeconds = seconds < 10 ? "0$seconds" : "$seconds";

    return "$labelMinutes:$labelSeconds";
  }

  ///
  /// Funciones para controlar el flujo del timer.
  ///

  void _onTimerTick(timer) async {
    if (_timerIsPaused) {
      return;
    }

    if (_remainningTime > Duration.zero) {
      setState(() {
        _remainningTime -= timerTickInterval;
      });
    } else {
      _cancelTimer();
      await _launchTimerAlarm();
    }
  }

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(timerTickInterval, _onTimerTick);
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  ///
  /// Pausado del timer.
  ///

  void _pauseTimerHandler() {
    setState(() {
      _timerIsPaused = true;
    });
  }

  void _resumeTimerHandler() {
    setState(() {
      _timerIsPaused = false;
    });
  }

  ///
  /// Reiniciar el timer.
  ///
  void _restartTimer() {
    _cancelTimer();

    setState(() {
      _remainningTime = widget.initialTime;
      _timerIsPaused = false;
    });

    _startTimer();
  }

  ///
  /// Incrementar timer.
  ///
  void _incrementTimer(Duration increment) {
    setState(() {
      _remainningTime += increment;
    });
  }

  ///
  /// Funcion para lanzar una nueva alarma.
  ///
  Future<void> _launchTimerAlarm() async {
    logger.t("Lanzando alarma al termino de temporizador.");

    final randomId = DateTime.now().millisecondsSinceEpoch % 10000;
    final alarmSettings = AlarmSettings(
      id: randomId,
      dateTime: DateTime.now(),
      assetAudioPath: 'assets/sounds/timer_sounds/timer_alarm_sound_4.mp3',
      volumeSettings: VolumeSettings.fixed(volume: 0.8),
      notificationSettings: NotificationSettings(
        title: 'Time\'s Up!',
        body: 'Let\'s Go For The Next Set! 💪',
        icon: 'notification_icon',
      ),
      warningNotificationOnKill: Platform.isIOS,
    );

    setState(() {
      _alarmSettings = alarmSettings;
    });

    await Alarm.set(alarmSettings: alarmSettings);
  }

  ///
  /// Funcion para detectar cuando se emite una nueva
  /// alarma.
  ///
  Future<void> _alarmsChangedHandler(AlarmSet alarms) async {
    logger.t("Cambio en stream de alarmas detectado.");
    if (alarms.alarms.isNotEmpty) {
      logger.d("Establecer temporizador finalizado.");

      setState(() {
        _timerIsFinished = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    ringSubscription = Alarm.ringing.listen(_alarmsChangedHandler);

    _remainningTime = widget.initialTime;
    _startTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    ringSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.d("_timerIsFinished = $_timerIsFinished");
    double timerPercent =
        (_remainningTime.inSeconds <= widget.initialTime.inSeconds)
        ? _remainningTime.inSeconds / widget.initialTime.inSeconds
        : 1;

    return _timerIsFinished
        ? FinishedRestTimer(alarmSettings: _alarmSettings!)
        : SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(2, 2, 2, context.keyBoardSpace),
                child: Column(
                  children: [
                    const ModalBottomHandle(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                        ),
                        const Spacer(),
                        Text(
                          "Get Ready for Your Next Set! 💪",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.skip_next),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 16),
                    CircularPercentIndicator(
                      radius: 80,
                      circularStrokeCap: CircularStrokeCap.round,
                      lineWidth: 10,
                      percent: timerPercent,
                      center: Text(
                        _getRemainningTimeLabel(_remainningTime),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      progressColor: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _restartTimer,
                          label: Text("Restart"),
                          icon: Icon(Icons.restart_alt),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: _timerIsPaused
                              ? _resumeTimerHandler
                              : _pauseTimerHandler,
                          label: Text(_timerIsPaused ? "Resume" : "Pause"),
                          icon: Icon(
                            _timerIsPaused ? Icons.play_arrow : Icons.pause,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            _incrementTimer(const Duration(seconds: 10));
                          },
                          label: Text("10s"),
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class FinishedRestTimer extends StatefulWidget {
  const FinishedRestTimer({super.key, required this.alarmSettings});

  final AlarmSettings alarmSettings;

  @override
  State<FinishedRestTimer> createState() => _FinishedRestTimerState();
}

class _FinishedRestTimerState extends State<FinishedRestTimer> {
  ///
  /// Logger.
  ///
  static final Logger logger = Logger();

  ///
  /// Stream para el control de las alarmas.
  ///
  StreamSubscription<AlarmSet>? _alarmRingingSubscription;

  Future<void> stopAlarm() async {
    Alarm.stop(widget.alarmSettings.id);
  }

  @override
  void initState() {
    super.initState();
    _alarmRingingSubscription = Alarm.ringing.listen((alarm) {
      if (alarm.containsId(widget.alarmSettings.id)) {
        _alarmRingingSubscription?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _alarmRingingSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.d("En FinishedRestTimer widget.");
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 2, 2, context.keyBoardSpace),
          child: Column(
            children: [
              const ModalBottomHandle(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  const Spacer(),
                  Text(
                    "Here We Go! 💪",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      AppAudioPlayer().stopSound();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 16),
              CircularPercentIndicator(
                radius: 80,
                circularStrokeCap: CircularStrokeCap.round,
                lineWidth: 10,
                percent: 1,
                center: Text("Time's Up!"),
                progressColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Alarm.stopAll();
                      Navigator.of(context).pop();
                    },
                    label: Text("Close"),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
