import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BatteryLevelPage(),
    );
  }
}

class BatteryLevelPage extends StatefulWidget {
  const BatteryLevelPage({super.key});

  @override
  BatteryLevelPageState createState() => BatteryLevelPageState();
}

class BatteryLevelPageState extends State<BatteryLevelPage> {
  static const platform =
      MethodChannel('com.example.web_view_package/native_code');
  String _batteryLevel = 'Unknown battery level';
  @override
  void initState() {
    super.initState();
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result%';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Level'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_batteryLevel),
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: Text('Get Battery Level'),
            ),
          ],
        ),
      ),
    );
  }
}
