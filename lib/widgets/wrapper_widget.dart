import 'package:app_example/style/app_colors.dart';
import 'package:flutter/material.dart';

class WrapperWidget extends StatelessWidget {
  final Widget child;
  const WrapperWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              // width: 5,
            ),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        child: child);
  }
}
