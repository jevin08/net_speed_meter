import 'dart:math';
import 'dart:typed_data';
import 'package:data_usage/data_usage.dart';

class MyDataUsageModel{
  String? appName;
  String? packageName;
  Uint8List? appIconBytes;
  int? mobileReceived;
  int? mobileSent;
  int? wifiReceived;
  int? wifiSent;


  MyDataUsageModel(this.appName, this.packageName, this.appIconBytes,
      this.mobileReceived, this.mobileSent, this.wifiReceived, this.wifiSent);

  MyDataUsageModel.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    packageName = json['package_name'];
    appIconBytes = json['app_icon'];
    mobileReceived = json['mobile_received'];
    mobileSent = json['mobile_sent'];
    wifiReceived = json['wifi_received'];
    wifiSent = json['wifi_sent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['package_name'] = packageName;
    data['app_icon'] = appIconBytes;
    data['mobile_received']=mobileReceived;
    data['mobile_sent']=mobileSent;
    data['wifi_received']=wifiReceived;
    data['wifi_sent']=wifiSent;
    return data;
  }

  static List<MyDataUsageModel> mergeMobileAndWifiDataUsageModel(List<DataUsageModel> mobile, List<DataUsageModel> wifi){
    List<MyDataUsageModel> list = [];
    int size= mobile.length;
    for(int i=0; i<size; ++i){
      DataUsageModel wifiModel =  wifi.singleWhere((element) => element.packageName==mobile[i].packageName);
      list.add(MyDataUsageModel(
          mobile[i].appName,
          mobile[i].packageName,
          mobile[i].appIconBytes,
          mobile[i].received,
          mobile[i].sent,
          wifiModel.received,
          wifiModel.sent
      ));
    }
    return list;
  }

}