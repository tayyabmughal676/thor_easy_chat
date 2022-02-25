import 'package:flutter/material.dart';

class MessagesModel {
  String? message;
  String? senderId;
  String? roomId;
  String? timeStamp;

  MessagesModel(
      {@required String? senderId,
      @required String? msg,
      @required String? roomId}) {
    message = msg;
    senderId = senderId;
    roomId = roomId;
    timeStamp = DateTime.now().toString();
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'senderId': senderId,
        'roomId': roomId,
        'timeStamp': timeStamp
      };

  fromJson(dynamic parsedJson) {
    message = parsedJson['message'] ?? '';
    senderId = parsedJson['senderId'] ?? '';
    roomId = parsedJson['roomId'] ?? '';
    timeStamp = parsedJson['timeStamp'] ?? '';
  }
}
