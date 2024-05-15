import 'package:chat/base/base.dart';
import 'package:chat/data%20base/my_data_base.dart';
import 'package:chat/model/message.dart';
import 'package:chat/shared_data.dart';

import '../../model/room.dart';

abstract class ChatNavigator extends BaseNavigator {
  void clearMessageText();
}

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  void send(String messageContent) {
    if (messageContent.trim().isEmpty) return;
    var message = Message(
        content: messageContent,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        senderId: SharedData.user?.id,
        senderName: SharedData.user?.fullName,
        roomId: room.id);

    MyDataBase.sendMessage(room.id ?? '', message).then((value) {
      // clear text field
      navigator?.clearMessageText();
    }).onError((error, stackTrace) {
      //  show error message
      navigator?.showMessage('something went wrong',
          posActionTitle: 'Try again', posAction: () {
        send(messageContent);
      }, negActionTitle: 'Cancel');
    });
  }
}
