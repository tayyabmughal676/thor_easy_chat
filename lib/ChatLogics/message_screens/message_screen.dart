// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'message_widget.dart';
//
// class MessageScreen extends StatefulWidget {
//   final ChatRoomModel? chatRoom;
//   final dynamic profileImage;
//   final dynamic otherUserName;
//
//   const MessageScreen(
//       {Key? key, this.chatRoom, this.profileImage, this.otherUserName})
//       : super(key: key);
//
//   @override
//   _MessageScreenState createState() => _MessageScreenState();
// }
//
// class _MessageScreenState extends State<MessageScreen> {
//   late ChatRoomProvider chatRoomProvider;
//   int selectedChat = 0;
//   int openChat = 0;
//
//   late MessageProvider messagesProvider;
//   late ChatRoomModel currentChatRoom;
//   late Future<UserModel> otherUser;
//   late TextEditingController messageController;
//
//   @override
//   void initState() {
//     super.initState();
//     chatRoomProvider = ChatRoomProvider();
//     chatRoomProvider = Provider.of<ChatRoomProvider>(context, listen: false);
//     chatRoomProvider.init(context: context);
//
//     messagesProvider = MessageProvider();
//     messagesProvider = Provider.of<MessageProvider>(context, listen: false);
//     messagesProvider.init(context: context);
//
//     messageController = TextEditingController();
//     currentChatRoom = widget.chatRoom!;
//
//     debugPrint("CurrentChatRoom: ${currentChatRoom.id}");
//     otherUser = UserProvider().getUserWithId(currentChatRoom.userIds.last);
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Provider.of<ChatRoomProvider>(context, listen: true);
//     Provider.of<MessageProvider>(context, listen: true);
//     return SafeArea(
//         child: Scaffold(
//       body: Container(
//         height: sizes!.height,
//         width: sizes!.width,
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(Assets.mainBgImage), fit: BoxFit.fill)),
//         child: Column(
//           children: [
//             MessageWidget.getAppBarWithTitleBackButtonAndUserIcon(
//                 context: context,
//                 title: "${widget.otherUserName}",
//                 icon: "assets/png/back_btn_icon@2x.png",
//                 userIcon: "assets/png/avatar_user_icon@2x.png",
//                 onPress: () {
//                   Navigator.pop(context);
//                 }),
//             //
//             Expanded(
//                 child: FutureBuilder(
//               future: otherUser,
//               builder: ((context, AsyncSnapshot<UserModel> snapShot) {
//                 if (snapShot.hasData) {
//                   return FutureBuilder(
//                     future: messagesProvider
//                         .getAllMessagesOfRoom(currentChatRoom.id!),
//                     builder: ((context,
//                         AsyncSnapshot<List<MessagesModel>> messageSnap) {
//                       if (messageSnap.hasData) {
//                         return ListView.separated(
//                           shrinkWrap: true,
//                           reverse: true,
//                           separatorBuilder: (BuildContext context, int index) =>
//                               Container(),
//                           itemCount: messageSnap.data!.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             if (messageSnap.data!.elementAt(index).senderId ==
//                                 UserProvider().getCurrentUserId()) {
//                               return MessageWidget.getSenderMessageContainer(
//                                 time: messageSnap.data!
//                                     .elementAt(index)
//                                     .timeStamp
//                                     .toString(),
//                                 message:
//                                     messageSnap.data!.elementAt(index).message!,
//                                 userPhoto: PreferenceUtils.getUserImage(),
//                               );
//                             } else {
//                               return MessageWidget.getReceiverMessageContainer(
//                                   time: messageSnap.data!
//                                           .elementAt(index)
//                                           .timeStamp ??
//                                       "",
//                                   message: messageSnap.data!
//                                           .elementAt(index)
//                                           .message ??
//                                       "");
//
//                               // return _msgComponents.getReceiverMsgContainer(
//                               //     time: messageSnap.data!
//                               //         .elementAt(index)
//                               //         .timeStamp ??
//                               //         "",
//                               //     message: messageSnap.data!
//                               //         .elementAt(index)
//                               //         .message ??
//                               //         "",
//                               //     imageUrl: profileImage);
//
//                             }
//                           },
//                         );
//                       } else {
//                         return const Center(child: Text("No messages"));
//                       }
//                     }),
//                   );
//                 } else {
//                   return Container(
//                       color: Colors.white,
//                       child: const Center(child: Text("LOADING messages...")));
//                 }
//               }),
//             )),
//
//             // MessageWidget.getReceiverMessageContainer(),
//             // MessageWidget.getSenderMessageContainer(),
//             // const Spacer(),
//             SizedBox(
//               height: sizes!.heightRatio * 5.0,
//             ),
//             MessageWidget.getSendMessageInputContainer(
//                 messageController: messageController,
//                 onSendMessagePress: () {
//                   sendMessageToOtherUser();
//                 }),
//           ],
//         ),
//       ),
//     ));
//   }
//
//   void sendMessageToOtherUser() async {
//     var message = messageController.text.toString().trim();
//
//     if (message.isEmpty) {
//       Toasts.getErrorToast(
//         text: "Please enter something to send",
//       );
//       return;
//     }
//
//     debugPrint("Message: $message");
//
//     MessagesModel msg = MessagesModel(
//         senderId: UserProvider().getCurrentUserId(),
//         msg: messageController.text.toString(),
//         roomId: currentChatRoom.id);
//     MessageProvider().sendMsg(msg);
//     messageController.text = "";
//   }
// }
