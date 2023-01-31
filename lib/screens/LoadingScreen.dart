import 'dart:convert';

import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          SizedBox(height: 100,),
          CircularProgressIndicator(),
          Text('Loading...'),
          SizedBox(height: 100,),
        ],
      ),
    );
  }
}

