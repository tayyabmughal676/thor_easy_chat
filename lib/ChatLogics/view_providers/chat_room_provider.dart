import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Chat_Message_Models/chat_room_model.dart';
import 'user_provider.dart';

class ChatRoomProvider extends ChangeNotifier {
  BuildContext? context;

  ChatRoomModel? _existingChatRoom;
  CollectionReference db = FirebaseFirestore.instance.collection('ChatRooms');

  getExistingChatRoom() => _existingChatRoom;

  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
  }

  Future<ChatRoomModel> createNewRoomBetween(
      String userOneId, String userTwoId) async {
    bool isExisting = await _isRoomAlreadyExisting(userOneId, userTwoId);
    if (isExisting) {
      return _existingChatRoom!;
    }
    ChatRoomModel chatRoom =
        ChatRoomModel(usersOneId: userOneId, userTwoId: userTwoId);
    await FirebaseFirestore.instance.runTransaction((tx) async {
      await db.doc(chatRoom.id).set(chatRoom.toJson()).whenComplete(() {});
    });
    return chatRoom;
  }

  Future<bool> _isRoomAlreadyExisting(
      String userOneId, String userTwoId) async {
    bool isExisting = false;
    QuerySnapshot documents =
        await db.where('userIds', arrayContains: userOneId).get();
    if (documents == null) {
      return false;
    }
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      for (DocumentSnapshot element in documents.docs) {
        ChatRoomModel chatRoom = ChatRoomModel();
        chatRoom.fromJson(element.data());
        if (chatRoom.userIds.contains(userOneId) &&
            chatRoom.userIds.contains(userTwoId)) {
          _existingChatRoom = chatRoom;
          isExisting = true;
          break;
        }
      }
    }).catchError((error) {
      debugPrint("Error while checking duplicate chat rooms : " + error);
      return isExisting;
    });
    return isExisting;
  }

  Future<List<ChatRoomModel>> getAllChatRoomsOfCurrentUser() async {
    List<ChatRoomModel> list = [];
    QuerySnapshot query =
        await db.orderBy("timeStampOfLastMessage", descending: true).get();
    if (query.docs.isEmpty) return list;
    var currUser =
        await UserProvider().getUserWithId(UserProvider().getCurrentUserId()!);
    for (DocumentSnapshot documentSnapshot in query.docs) {
      ChatRoomModel chatRoom = ChatRoomModel();
      chatRoom.fromJson(documentSnapshot.data());
      if (chatRoom.userIds.contains(currUser.id)) {
        ChatRoomModel chatRoom = ChatRoomModel();
        chatRoom.fromJson(documentSnapshot.data());
        list.add(chatRoom);
      }
    }
    notifyListeners();
    return list;
  }
}
