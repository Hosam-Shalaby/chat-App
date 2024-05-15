// ignore_for_file: unused_local_variable


import 'package:chat/model/my_user.dart';
import 'package:chat/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/message.dart';

class MyDataBase {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (doc, _) => MyUser.fromFireStore(doc.data()!),
            toFirestore: (user, _) => user.toFireStore());
  }

  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: (doc, _) => Room.fromFireStore(doc.data()!),
            toFirestore: (room, _) => room.toFireStore());
  }

  static Future<MyUser?> insertUser(MyUser user) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    var res = await docRef.set(user);
    return user;
  }

  static Future<MyUser?> getUserById(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }

  static Future<void> createRoom(Room room) {
    var docRef = getRoomsCollection().doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> loadRooms() async {
    var querySnapshot = await getRoomsCollection().get();

    return querySnapshot.docs.map((e) => e.data()).toList();
  }

  static CollectionReference<Message> getMessagesCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter<Message>(
            fromFirestore: (snapshot, options) =>
                Message.fromFirestore(snapshot.data()!),
            toFirestore: (message, options) => message.toFirestore());
  }

  static Future<void> sendMessage(String roomId, Message message) {
    var messageDoc = getMessagesCollection(roomId).doc();
    message.id = messageDoc.id;
    return messageDoc.set(message);
  }
}
