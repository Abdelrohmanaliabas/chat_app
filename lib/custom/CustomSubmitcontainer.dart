import 'package:flutter/material.dart';

class CustomSubmitcontainer extends StatelessWidget {
  CustomSubmitcontainer({required this.sumbitText});
  String? sumbitText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: double.infinity,
      height: 60,
      child: Center(
        child: Text(
          sumbitText!,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
