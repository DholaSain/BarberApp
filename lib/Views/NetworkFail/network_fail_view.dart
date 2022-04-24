import 'package:flutter/material.dart';

class NetworkFailed extends StatelessWidget {
  const NetworkFailed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NetworkFailed'),
      ),
      body: Center(child: Text('No internet')),
    );
  }
}
