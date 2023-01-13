import 'dart:io' show Platform, exit;
import 'package:flutter/material.dart';
import 'package:net_speed_meter/utils/theme_changer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextStyle headingStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red);
  Color trailingActiveColor = Colors.redAccent;
  bool lockAppSwitchVal = true;
  bool fingerprintSwitchVal = false;
  bool changePassSwitchVal = true;

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("General",
                    style: headingStyle,
                  ),
                ],
              ),
              ListTile(
                leading: Icon(
                  (themeProvider.getTheme==lightTheme) ? Icons.bedtime_sharp : Icons.light_mode,
                ),
                title: const Text("Dark Mode"),
                trailing: Switch(
                    value: themeProvider.getTheme==darkTheme,
                    activeColor: trailingActiveColor,
                    onChanged: (val) {
                      setState(() {
                        themeProvider.setTheme(themeProvider.getTheme==lightTheme?darkTheme:lightTheme);
                      });
                    }),
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.speed),
                title: const Text("Unit of measurement"),
                subtitle: Text("MB"),
                onTap: () {

                },
              ),

              const Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Stop & Exit Application"),
                onTap: (){
                  if(Platform.isAndroid) {
                    SystemNavigator.pop();
                  }else if(Platform.isIOS){
                    exit(0);
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Security", style: headingStyle),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.phonelink_lock_outlined),
                title: const Text("Lock app in background"),
                trailing: Switch(
                    value: lockAppSwitchVal,
                    activeColor: trailingActiveColor,
                    onChanged: (val) {
                      setState(() {
                        lockAppSwitchVal = val;
                      });
                    }),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Information", style: headingStyle),
                ],
              ),
              const ListTile(
                leading: Icon(Icons.file_open_outlined),
                title: Text("Terms of Service"),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.file_copy_outlined),
                title: Text("Open Source and Licences"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
