import 'package:chat/model/message.dart';
import 'package:chat/shared_data.dart';
import 'package:chat/ui/utls/datetime.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return message.senderId == SharedData.user?.id
        ? SentMessage(message.content!, message.dateTime!)
        : RecievedMessage(
            message.senderName!, message.content!, message.dateTime!);
  }
}

class SentMessage extends StatelessWidget {
  int dateTime;
  String content;
  SentMessage(this.content, this.dateTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 77, 151, 211),
                // color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                    topLeft: Radius.circular(24),
                    bottomRight: Radius.circular(0))),
            child: Text(
              content,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Text(formatMessageDate(dateTime)),
        ],
      ),
    );
  }
}

class RecievedMessage extends StatelessWidget {
  int dateTime;
  String content;
  String senderName;

  RecievedMessage(this.senderName, this.content, this.dateTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(senderName),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: .5)),
            // decoration: const BoxDecoration(
            //     color: Colors.amber,
            //     borderRadius: BorderRadius.only(
            //         topRight: Radius.circular(24),
            //         bottomLeft: Radius.circular(24),
            //         topLeft: Radius.circular(24),
            //         bottomRight: Radius.circular(0))),
            child: Text(
              content,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Text(formatMessageDate(dateTime)),
        ],
      ),
    );
  }
}
