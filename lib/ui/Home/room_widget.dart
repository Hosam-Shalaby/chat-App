import 'package:chat/ui/chat/chat_thread.dart';
import 'package:flutter/material.dart';

import '../../model/room.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  RoomWidget(this.room, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatTread.routeName, arguments: room);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/${room.catId}.png',
              height: 120,
              width: 120,
            ),
            Text(
              '${room.title}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
