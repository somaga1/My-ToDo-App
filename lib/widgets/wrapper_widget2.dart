import 'package:app_example/style/app_colors.dart';
import 'package:flutter/material.dart';

class WrapperWidget2 extends StatelessWidget {
  final Widget child;
  const WrapperWidget2({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5.0,
                offset: Offset(0, 5), // shadow direction: bottom right
              ),
            ],
            // border: Border.all(
            //   color: Colors.grey,
            //   // width: 5,
            // ),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        child: child);
  }
}
