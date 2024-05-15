
class Message {
    static const String collectionName = 'Message';

  String? content;
  String? id;
  String? senderName;
  String? senderId;
  String? roomId;
  int? dateTime;

  Message(
      {this.id,
      this.content,
      this.dateTime,
      this.roomId,
      this.senderId,
      this.senderName});

  Message.fromFirestore(Map<String, dynamic> data) {
    id = data['id'];
    content = data['content'];
    senderName = data['senderName'];
    senderId = data['senderId'];
    roomId = data['roomId'];
    dateTime = data['dateTime'];
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'content': content,
      'senderName': senderName,
      'senderId': senderId,
      'roomId': roomId,
      'dateTime': dateTime
    };
  }
}
