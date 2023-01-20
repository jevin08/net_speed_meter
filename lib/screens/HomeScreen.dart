import 'package:flutter/material.dart';
import 'package:net_speed_meter/screens/SettingScreen.dart';
import 'package:net_speed_meter/utils/theme_changer.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:data_usage/data_usage.dart';
import 'dart:async';

import 'AndroidHomeScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DataUsageModel> _dataUsage = [];
  IOSDataUsageModel? _dataiOSUsage;

  @override
  void initState() {
    super.initState();
    initPlatformState();

  }

  Future<void> initPlatformState() async {
    List<DataUsageModel> dataUsage;
    IOSDataUsageModel dataiOSUsage;
    try {
      print(await DataUsage.init());

      print('''dataUsage''');
      dataUsage = await DataUsage.dataUsageAndroid(
        withAppIcon: true,
        dataUsageType: DataUsageType.wifi,
      );

      dataiOSUsage = await DataUsage.dataUsageIOS();
      setState(() {
        _dataUsage = dataUsage;
        _dataiOSUsage = dataiOSUsage;
      });
      print(dataUsage);
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    var _themeProvider=Provider.of<ThemeChanger>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Net Speed Meter'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                  const SettingScreen(),
                ),
              );
            },
            icon: const   Icon(
              Icons.settings
            ),
          )
        ],
      ),
      body: Center(
        child: Platform.isAndroid
            ? AndroidHomeScreen(dataUsage: _dataUsage, size: size)
            : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _dataiOSUsage
                ?.toJson()
                ?.entries
                ?.map((e) => Text(
              '${e.key}: ${e.value}',
              overflow: TextOverflow.ellipsis,
            ))
                ?.toList() ??
                []),
      ),
    );
  }
}
