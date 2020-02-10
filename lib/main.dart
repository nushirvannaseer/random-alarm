import 'package:flutter/material.dart';
import 'package:random_alarm/screens/home_screen/home_screen.dart';
import 'package:random_alarm/services/alarm_scheduler.dart';
import 'package:random_alarm/services/file_proxy.dart';
import 'package:random_alarm/services/life_cycle_listener.dart';
import 'package:random_alarm/stores/alarm_list/alarm_list.dart';

AlarmList list = AlarmList();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final alarms = await new JsonFileStorage().readList();
  list.setAlarms(alarms);
  list.alarms.forEach((alarm) => alarm.loadTracks());

  WidgetsBinding.instance.addObserver(LifeCycleListener(list));

  runApp(MyApp());
  AlarmScheduler().testAlarm();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color.fromRGBO(25, 12, 38, 1),
        ),
        home: HomeScreen(alarms: list));
  }
}
