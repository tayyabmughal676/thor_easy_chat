import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Chat_Message_Models/message_model.dart';

class MessageProvider extends ChangeNotifier {
  BuildContext? context;

  CollectionReference db = FirebaseFirestore.instance.collection('Messages');
  CollectionReference chatRooms =
      FirebaseFirestore.instance.collection('ChatRooms');

  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
  }

  Future<void> sendMsg(@required MessagesModel message) async {
    FirebaseFirestore.instance.runTransaction((tx) async {
      await db.add(message.toJson());
    });

    FirebaseFirestore.instance
        .collection('ChatRooms')
        .where('id', isEqualTo: message.roomId)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection('ChatRooms')
            .doc(element.id)
            .update({
          'lastmessage': message.message,
          'timeStampOfLastMessage': message.timeStamp
        });
      });

      notifyListeners();
    });
  }

  Future<List<MessagesModel>> getAllMessagesOfRoom(
      @required String roomId) async {
    QuerySnapshot msgQuery = await db
        .where('roomId', isEqualTo: roomId)
        .orderBy('timeStamp', descending: true)
        .get();

    List<MessagesModel> allMessages = [];
    for (DocumentSnapshot documentSnapshot in msgQuery.docs) {
      MessagesModel msg = MessagesModel();
      msg.fromJson(documentSnapshot.data());
      allMessages.add(msg);
    }
    debugPrint("allMessages: ${allMessages.length}");
    notifyListeners();
    return allMessages;
  }
}
