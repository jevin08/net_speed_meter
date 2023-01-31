import 'package:data_usage/data_usage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:net_speed_meter/screens/SettingScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DataUsageModel>? _dataUsage;
  DataUsageType dataUsageType = DataUsageType.mobile;
  bool isLoading = true;
  String status='Not connected';
  @override
  void initState() {
    super.initState();
    updateData();
  }

  Future<void> updateData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status = 'Connected';
      }
    } on SocketException catch (_) {
        status = 'Not connected';
    }
    List<DataUsageModel> dataUsage = await DataUsage.dataUsageAndroid(
      withAppIcon: true,
      dataUsageType: dataUsageType,
    );
    dataUsage.sort(
        (a, b) => a.appName!.compareTo(b.appName!),
    );
    dataUsage.sort(
      (a, b) => (b.received! + b.sent!).compareTo(a.received! + a.sent!),
    );
    // dataUsage = dataUsage.take(30).toList();
    if (!mounted) return;
    setState(() {
      isLoading = false;
      _dataUsage = dataUsage;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color usageColor = Colors.indigoAccent;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Net Speed Meter'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        title: const Text('Settings'),
                        content: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    ListTile(
                                      title: const Text('Preference'),
                                      onTap: () async {
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SettingScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                    ListTile(
                                      title: Row(
                                        children: [
                                          const Icon(Icons.swap_horiz_rounded),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          DropdownButton<String>(
                                            value: (DataUsageType.mobile ==
                                                    dataUsageType)
                                                ? 'Mobile'
                                                : 'Wifi',
                                            items: <String>['Mobile', 'Wifi']
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dataUsageType =
                                                    (newValue == 'Wifi')
                                                        ? DataUsageType.wifi
                                                        : DataUsageType.mobile;
                                              });
                                              Navigator.pop(context);
                                              updateData();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  });
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Column(
        children: [
          Text('Network Status : $status', style: const TextStyle(height: 1.5)),
          Expanded(
            child: Center(
              child: (isLoading)
                  ? (const CircularProgressIndicator())
                  : ListView(
                      children: [
                        if (_dataUsage != null)
                          for (var item in _dataUsage!) ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 10),
                                  if (item.appIconBytes != null)
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: MemoryImage(item.appIconBytes!),
                                        ),
                                      ),
                                    ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size.width * 0.7,
                                        child: Text(
                                          '${item.appName}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: size.width * 0.7,
                                        child: Text(
                                          '${item.packageName}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 11),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Text(
                                            'Received: ${item.received}   ',
                                            style: TextStyle(
                                                color: usageColor,
                                                fontSize: 13),
                                          ),
                                          Text(
                                            'Sent: ${item.sent}',
                                            style: TextStyle(
                                                color: usageColor,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider()
                          ]
                      ],
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: updateData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
