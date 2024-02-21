import 'package:chat_app/custom/CustomTextChat.dart';
import 'package:chat_app/models/massageModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatAppScreen extends StatelessWidget {
  ChatAppScreen({super.key});
  String id = 'ChatScreen';
  CollectionReference massages =
      FirebaseFirestore.instance.collection('Massages');
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: massages.orderBy('createdAt').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Massage> massageslist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              massageslist.add(
                Massage.fromJson(snapshot.data!.docs[i]),
              );
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Color(0xff2B475E),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 60,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              body: Column(children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: massageslist.length,
                    itemBuilder: (context, index) {
                      return CustomTextChat(
                        massage: massageslist[index],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      massages.add({
                        'massage': data,
                        'createdAt': DateTime.now(),
                      });
                      controller.clear();
                      _controller.animateTo(
                          _controller.position.maxScrollExtent,
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn);
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Massage',
                      suffixIcon: Icon(
                        Icons.send,
                        color: Color(0xff2B475E),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ]),
            );
          } else {
            return Text('loading');
          }
        });
  }
}
