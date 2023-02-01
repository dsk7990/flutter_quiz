import 'package:flutter/material.dart';

class NetworkError extends StatelessWidget {
  final String? errorMessage;
  final String? btnText;

  final Function()? onRetryPressed;

  const NetworkError({Key? key, this.errorMessage, this.btnText, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage ?? '',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            child: Text(
              btnText ?? 'Retry',
            ),
            onPressed: onRetryPressed,
          ),
        ],
      ),
    );
  }
}
