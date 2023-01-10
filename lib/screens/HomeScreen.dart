import 'package:flutter/material.dart';
import 'package:net_speed_meter/screens/SettingScreen.dart';
import 'package:net_speed_meter/utils/theme_changer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _themeProvider=Provider.of<ThemeChanger>(context);
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
      body:  Container(
        child: const Text(''),
      ),
    );
  }
}
