import 'package:uuid/uuid.dart';

class ChatRoomModel {
  List<dynamic> userIds = [];
  String? lastmessage;
  String? timeStampOfLastMessage;
  String? id;

  Map<String, dynamic> toJson() => {
        'userIds': userIds,
        'id': id,
        'lastmessage': lastmessage,
        'timeStampOfLastMessage': timeStampOfLastMessage
      };

  ChatRoomModel({String? usersOneId, String? userTwoId}) {
    //if id is null then assign it to UniqueKey otherwise leave as it is
    id = id ??= const Uuid().v1();
    userIds.add(usersOneId);
    userIds.add(userTwoId);
    lastmessage = "";
    timeStampOfLastMessage = "";
  }

  fromJson(dynamic parsedJson) {
    userIds = parsedJson['userIds'] ?? '';
    id = parsedJson['id'] ?? '';
    lastmessage = parsedJson['lastmessage'] ?? '';
    timeStampOfLastMessage = parsedJson['timeStampOfLastMessage'] ?? '';
  }
}
