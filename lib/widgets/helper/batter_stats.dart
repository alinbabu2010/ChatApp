import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget class to show battery status by running native code.
/// To explore sending a method call from Flutter to native code.
class BatteryStatus extends StatefulWidget {
  const BatteryStatus({super.key});

  @override
  State<BatteryStatus> createState() => _BatteryStatusState();
}

class _BatteryStatusState extends State<BatteryStatus> {
  int? _batteryLevel;

  Future<void> _getBatteryLevel() async {
    const platform = MethodChannel(Constants.channelId);
    try {
      final batteryLevel =
          await platform.invokeMethod(Constants.getBatteryLevel);
      _setBatteryLevel(batteryLevel);
    } on Exception catch (error) {
      debugPrint(error.toString());
      _setBatteryLevel(null);
    }
  }

  void _setBatteryLevel(int? level) {
    setState(() {
      _batteryLevel = level;
    });
  }

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimen.statsPadding),
        child: Text("${Constants.labelBatteryLevel} : $_batteryLevel%"),
      ),
    );
  }
}
