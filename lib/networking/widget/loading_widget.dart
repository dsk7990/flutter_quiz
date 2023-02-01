import 'package:flutter/material.dart';

class NetworkLoading extends StatelessWidget {
  final String? loadingMessage;

  const NetworkLoading({Key? key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text(
                'Please wait...',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
