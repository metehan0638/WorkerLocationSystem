import 'package:flutter/material.dart';
import 'package:worker_location_system/constants/const.dart';

class MyRow extends StatelessWidget {
  final String feature;
  final String value;
  const MyRow({super.key, required this.feature, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 5, right: 8.0, left: 8, bottom: 5),
          child: Text(
            feature,
            style: Constants.googleTextFeatureStyle,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 5, right: 8.0, left: 8, bottom: 5),
          child: Text(value, style: Constants.googleTextValueStyle),
        ),
      ],
    );
  }
}
