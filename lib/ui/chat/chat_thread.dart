import 'package:chat/data%20base/my_data_base.dart';
import 'package:chat/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/base.dart';
import '../../model/room.dart';
import 'chat_view_model.dart';
import 'message_widget.dart';

class ChatTread extends StatefulWidget {
  static const String routeName = 'chatScreen';

  const ChatTread({super.key});

  @override
  State<ChatTread> createState() => _ChatTreadState();
}

class _ChatTreadState extends BaseState<ChatTread, ChatViewModel>
    implements ChatNavigator {
  late Room room;
  TextEditingController messageController = TextEditingController();
  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  @override
  void clearMessageText() {
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)?.settings.arguments as Room;
    viewModel.room = room;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text('${room.title}'),
            ),
            body: Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: MyDataBase.getMessagesCollection(room.id ?? '')
                        .orderBy('dateTime', descending: true)
                        .snapshots(),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      } else if (asyncSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var data = asyncSnapshot.data?.docs
                          .map((doc) => doc.data())
                          .toList();
                      return ListView.separated(
                        reverse: true,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 3,
                          );
                        },
                        itemBuilder: (context, index) {
                          return MessageWidget(data![index]);
                        },
                        itemCount: data?.length ?? 0,
                      );
                    },
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  const Border.fromBorderSide(BorderSide())),
                          child: TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Your message here'),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          viewModel.send(messageController.text);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 11),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 77, 151, 211),
                              // color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all()),
                          child: const Row(
                            children: [
                              Text(
                                'Send  ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
