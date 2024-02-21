import 'package:chat_app/models/massageModel.dart';
import 'package:flutter/material.dart';

class CustomTextChat extends StatelessWidget {
  CustomTextChat({super.key, required this.massage});
  final Massage massage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.only(left: 13, top: 15, bottom: 15, right: 13),
          margin: EdgeInsets.only(top: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: Color(0xff2B475E),
          ),
          child: Text(
            massage.massage,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
