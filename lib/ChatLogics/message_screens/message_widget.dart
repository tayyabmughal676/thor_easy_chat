// import 'package:date_time_format/date_time_format.dart';
// import 'package:flutter/material.dart';
// import 'package:quick_tow/res/assets.dart';
// import 'package:quick_tow/res/colors.dart';
// import 'package:quick_tow/res/res.dart';
// import 'package:quick_tow/widgets/text_views.dart';
//
// class MessageWidget {
//   static String getFormattedTime({@required String? date}) {
//     DateTime newDate = DateTime.parse(date!);
//     String formattedTime = DateTimeFormat.format(newDate, format: 'h:i A');
//     return formattedTime;
//   }
//
//   static Widget getAppBarWithTitleBackButtonAndUserIcon({
//     @required BuildContext? context,
//     @required String? title,
//     @required String? icon,
//     @required String? userIcon,
//     @required Function? onPress,
//   }) {
//     return Container(
//       height: sizes!.heightRatio * 60.0,
//       decoration: const BoxDecoration(
//         color: AppColors.whiteTextColor,
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.cardShadowColor,
//             blurRadius: 2,
//             offset: Offset(0, 0),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(left: sizes!.widthRatio * 30.0),
//         child: Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//               height: sizes!.heightRatio * 32,
//               width: sizes!.widthRatio * 32,
//               child: GestureDetector(
//                   onTap: () {
//                     if (onPress != null) {
//                       onPress.call();
//                     }
//                   },
//                   child: Image.asset(icon!)),
//             ),
//             SizedBox(
//               width: sizes!.widthRatio * 10,
//             ),
//             SizedBox(
//                 height: sizes!.heightRatio * 32,
//                 width: sizes!.widthRatio * 32,
//                 child: Image.asset(
//                   userIcon ?? "assets/png/avatar_user_icon@2x.png",
//                   height: sizes!.heightRatio * 40.0,
//                   width: sizes!.widthRatio * 40.0,
//                 )),
//             SizedBox(
//               width: sizes!.widthRatio * 10,
//             ),
//             TextView.getMediumText18(title ?? "", Assets.poppinsMedium,
//                 color: AppColors.blackTextColor, lines: 1),
//           ],
//         ),
//       ),
//     );
//   }
//
//   static Widget getSendMessageInputContainer({
//     @required Function? onSendMessagePress,
//     @required TextEditingController? messageController,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: sizes!.height * 0.07,
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: AppColors.chatBorderColor,
//             width: 1,
//           ),
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//           color: AppColors.whiteTextColor,
//           boxShadow: const [
//             BoxShadow(
//               color: AppColors.cardShadowColor,
//               blurRadius: 2, // 12
//               offset: Offset(0, 0), // 3
//             ),
//           ],
//         ),
//         child: TextFormField(
//           keyboardType: TextInputType.text,
//           controller: messageController,
//           style: const TextStyle(
//             fontFamily: Assets.poppinsRegular,
//           ),
//           decoration: InputDecoration(
//               suffixIcon: GestureDetector(
//                 onTap: () {
//                   if (onSendMessagePress != null) {
//                     onSendMessagePress.call();
//                   }
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.only(right: sizes!.widthRatio * 10),
//                   child: Image.asset(
//                     Assets.icon_send,
//                     height: sizes!.heightRatio * 32.0,
//                     width: sizes!.widthRatio * 32.0,
//                   ),
//                 ),
//               ),
//               enabledBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(6.0)),
//                   borderSide: BorderSide(color: Colors.white)),
//               focusedBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(6.0)),
//                   borderSide: BorderSide(color: Colors.white)),
//               filled: true,
//               fillColor: AppColors.offWhite,
//               hintText: "Type Message Here...",
//               hintStyle: TextStyle(
//                   color: Colors.grey[500],
//                   fontFamily: Assets.poppinsRegular,
//                   fontSize: 14.0)),
//           // controller: controller,
//           cursorColor: AppColors.appBackground,
//           validator: (val) {
//             if (val!.isEmpty) {
//               return "Please type message";
//             } else {
//               return null;
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   static Widget getReceiverMessageContainer(
//       {@required dynamic message, @required dynamic time}) {
//     var formattedTime = MessageWidget.getFormattedTime(date: time);
//
//     return Container(
//       padding: EdgeInsets.only(
//         left: sizes!.widthRatio * 10,
//         right: sizes!.widthRatio * 10,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//               width: sizes!.widthRatio * 30.0,
//               child: const CircleAvatar(
//                 backgroundImage:
//                     AssetImage("assets/png/avatar_user_icon@2x.png"),
//               )),
//           SizedBox(
//             width: sizes!.widthRatio * 10,
//           ),
//           Expanded(
//             child: Container(
//                 padding: EdgeInsets.all(sizes!.heightRatio * 12),
//                 margin: EdgeInsets.only(
//                     top: sizes!.heightRatio * 12.0,
//                     bottom: sizes!.heightRatio * 12.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: AppColors.chatBorderColor,
//                     width: 1,
//                   ),
//                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   color: AppColors.whiteTextColor,
//                   boxShadow: const [
//                     BoxShadow(
//                       color: AppColors.cardShadowColor,
//                       blurRadius: 2, // 12
//                       offset: Offset(0, 0), // 3
//                     ),
//                   ],
//                 ),
//                 child: TextView.getRegularWith13(
//                     message ??
//                         "This is the message received. chatBorderColor, chatBorderColor",
//                     Assets.poppinsRegular,
//                     color: AppColors.blackTextColor,
//                     lines: 5)),
//           ),
//           SizedBox(
//             width: sizes!.widthRatio * 10,
//           ),
//           TextView.getSmallText12(formattedTime, Assets.poppinsMedium,
//               color: AppColors.blackTextColor, lines: 1),
//         ],
//       ),
//     );
//   }
//
//   static Widget getSenderMessageContainer(
//       {@required dynamic time,
//       @required dynamic message,
//       @required dynamic userPhoto}) {
//     var formattedTime = MessageWidget.getFormattedTime(date: time);
//     var isImageUrl = Uri.tryParse(userPhoto)?.hasAbsolutePath ?? false;
//
//     return Container(
//       padding: EdgeInsets.only(
//         left: sizes!.widthRatio * 10,
//         right: sizes!.widthRatio * 10,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextView.getSmallText12(formattedTime, Assets.poppinsMedium,
//               color: AppColors.blackTextColor, lines: 1),
//           SizedBox(
//             width: sizes!.widthRatio * 10,
//           ),
//           Expanded(
//             child: Container(
//                 padding: EdgeInsets.all(sizes!.heightRatio * 12),
//                 margin: EdgeInsets.only(
//                     top: sizes!.heightRatio * 12.0,
//                     bottom: sizes!.heightRatio * 12.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: AppColors.chatBorderColor,
//                     width: 1,
//                   ),
//                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   color: AppColors.getStartedButtonColor,
//                   boxShadow: const [
//                     BoxShadow(
//                       color: AppColors.cardShadowColor,
//                       blurRadius: 2, // 12
//                       offset: Offset(0, 0), // 3
//                     ),
//                   ],
//                 ),
//                 child: TextView.getRegularWith13(
//                     message ??
//                         "This is the message sent. chatBorderColor, chatBorderColor",
//                     Assets.poppinsRegular,
//                     color: AppColors.whiteTextColor,
//                     textAlign: TextAlign.left,
//                     lines: 5)),
//           ),
//           SizedBox(
//             width: sizes!.widthRatio * 10,
//           ),
//           SizedBox(
//             width: sizes!.widthRatio * 30.0,
//             child: CircleAvatar(
//               backgroundImage: isImageUrl
//                   ? NetworkImage(userPhoto)
//                   : const AssetImage(
//                       "assets/png/photo@2x.png",
//                     ) as ImageProvider,
//               backgroundColor: AppColors.transparentColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
