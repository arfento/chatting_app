import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:chatting_app/domain/models/user_model.dart';
import 'package:chatting_app/presentation/chat_screen/controllers/chat_screen.controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class MessageScreenScreen extends StatelessWidget {
  final UsersModel user;
  const MessageScreenScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatScreenController controller = Get.put(ChatScreenController());

    final groupChatId = controller.groupChatId(
        currentId: FirebaseAuth.instance.currentUser!.uid, peerId: user.uid!);

    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      // Keyboard is visible.
      controller.emojiShowing.value = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: const AssetImage("assets/images/chat_doodle.png"),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.25), BlendMode.dstATop),
            )),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .doc(groupChatId)
                .collection(groupChatId)
                .orderBy('timestamp', descending: false)
                .limit(500)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var listMessage = snapshot.data!.docs;
                var newMap =
                    listMessage.groupListsBy((element) => element['group']);
                print(newMap.runtimeType);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: StickyGroupedListView<dynamic, String>(
                        reverse: true,
                        elements: snapshot.data!.docs,
                        groupBy: (element) => element['group'],
                        floatingHeader: true,
                        order: StickyGroupedListOrder.DESC,
                        groupSeparatorBuilder: (element) => SizedBox(
                          height: 30,
                          child: Bubble(
                            alignment: Alignment.center,
                            color: const Color.fromRGBO(212, 234, 244, 1.0),
                            child: Text(
                                controller.getDate(data: element['group']),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 11.0)),
                          ),
                        ),
                        itemBuilder: (context, doc) =>
                            controller.buildItem(doc),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 0),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  controller.emojiShowing.value =
                                      !controller.emojiShowing.value;
                                },
                                icon: const Icon(Icons.emoji_emotions)),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                controller: controller.textEditingController,
                                maxLines: null,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Message"),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  controller.sendMessage(
                                      groupChatId: groupChatId, user: user);
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: Theme.of(context).primaryColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                    Obx(() => Offstage(
                          offstage: !controller.emojiShowing.value,
                          child: SizedBox(
                              height: 250,
                              child: EmojiPicker(
                                textEditingController:
                                    controller.textEditingController,
                                config: Config(
                                  columns: 7,
                                  // Issue: https://github.com/flutter/flutter/issues/28894
                                  emojiSizeMax: 32 *
                                      (!foundation.kIsWeb && Platform.isIOS
                                          ? 1.30
                                          : 1.0),
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  gridPadding: EdgeInsets.zero,
                                  initCategory: Category.RECENT,
                                  bgColor: const Color(0xFFF2F2F2),
                                  indicatorColor: Colors.blue,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.blue,
                                  backspaceColor: Colors.blue,
                                  skinToneDialogBgColor: Colors.white,
                                  skinToneIndicatorColor: Colors.grey,
                                  enableSkinTones: true,
                                  // showRecentsTab: true,
                                  recentsLimit: 28,
                                  replaceEmojiOnLimitExceed: false,
                                  noRecents: const Text(
                                    'No Recents',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black26),
                                    textAlign: TextAlign.center,
                                  ),
                                  loadingIndicator: const SizedBox.shrink(),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons: const CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL,
                                  checkPlatformCompatibility: true,
                                ),
                              )),
                        )),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
