import 'package:flutter/material.dart';

import '../../utils/strings.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(child: Text(StringUtils.noDataAvailable)),
    );
  }
}
