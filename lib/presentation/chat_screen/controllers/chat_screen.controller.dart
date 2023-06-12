import 'package:bubble/bubble.dart';
import 'package:chatting_app/common/common.dart';
import 'package:chatting_app/common/widgets/custom_card.dart';
import 'package:chatting_app/domain/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class ChatScreenController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  var emojiShowing = false.obs;

  String groupChatId({required String currentId, required String peerId}) {
    if (currentId.hashCode <= peerId.hashCode) {
      return '$currentId-$peerId';
    } else {
      return '$peerId-$currentId';
    }
  }

  Future<void> sendMessage(
      {required String groupChatId, required UsersModel user}) async {
    if (textEditingController.text.trim() != "") {
      var documentReference = FirebaseFirestore.instance
          .collection("messages")
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(documentReference, {
          'idFrom': FirebaseAuth.instance.currentUser!.uid,
          'idTo': user.uid,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'group': DateFormat("dd-MM-yyyy").format(DateTime.now()),
          'content': textEditingController.text.trim(),
          'type': '0'
        });
      });
      textEditingController.clear();
    } else {
      showToast(context: Get.context!, message: "Nothing to send");
    }
  }

  buildGroupedItem(
      Map<dynamic, List<QueryDocumentSnapshot<Map<String, dynamic>>>> map) {
    map.forEach((key, value) {
      StickyGroupedListView<dynamic, String>(
        elements: value,
        groupBy: (dynamic element) => key,
        groupSeparatorBuilder: (element) => Text(key),
        itemBuilder: (context, element) => buildItem(value.first),
      );
    });
  }

  buildItem(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return uid == doc['idFrom']
        ? Bubble(
            margin: BubbleEdges.only(top: 10),
            alignment: Alignment.topRight,
            nip: BubbleNip.rightTop,
            color: Color.fromRGBO(255, 255, 199, 1.0),
            child: CustomCard(
              msg: doc['content'],
              additionalInfo: DateFormat("hh:mm a").format(
                DateTime.fromMillisecondsSinceEpoch(
                  int.parse(
                    doc['timestamp'],
                  ),
                ),
              ),
            ),
          )
        : Bubble(
            margin: BubbleEdges.only(top: 10),
            alignment: Alignment.topRight,
            nip: BubbleNip.leftTop,
            child: CustomCard(
              msg: doc['content'],
              additionalInfo: DateFormat("hh:mm a").format(
                DateTime.fromMillisecondsSinceEpoch(
                  int.parse(
                    doc['timestamp'],
                  ),
                ),
              ),
            ),
          );
  }

  String getDate({required String data}) {
    String today = DateFormat("dd-MM-yyyy").format(DateTime.now());
    String yesterday = DateFormat("dd-MM-yyyy")
        .format(DateTime.now().subtract(Duration(days: 1)));
    if (data.contains(today)) {
      return "Today";
    }

    if (data.contains(yesterday)) {
      return "Yesterday";
    }
    return data;
  }
}
