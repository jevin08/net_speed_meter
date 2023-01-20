import 'package:data_usage/data_usage.dart';
import 'package:flutter/material.dart';

class AndroidHomeScreen extends StatelessWidget {
  final List<DataUsageModel> _dataUsage;
  final Size size;
  const AndroidHomeScreen(
      {Key? key, required List<DataUsageModel> dataUsage, required this.size})
      : _dataUsage = dataUsage,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (_dataUsage.isNotEmpty)
          for (var item in _dataUsage) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
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
                  SizedBox(width: 10),
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
                      SizedBox(height: 10),
                      Container(
                        width: size.width * 0.7,
                        child: Text(
                          '${item.packageName}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            'Received: ${(item.received! / 1048576).toStringAsFixed(4)}MB',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 13),
                          ),
                          Text(
                            'Sent:${(item.sent! / 1048576).toStringAsFixed(4)}MB',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 13),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const Divider()
          ]
      ],
    );
  }
}
