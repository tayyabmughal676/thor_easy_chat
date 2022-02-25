import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../local_cache/utils.dart';
import '../Chat_Message_Models/user_model.dart';

class UserProvider extends ChangeNotifier {
  BuildContext? context;

  static UserModel? existingUser;

  CollectionReference db = FirebaseFirestore.instance.collection('Users');

  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
  }

  addUser(UserModel user) async {
    bool isExisting = await _isUserAlreadyExisting(user.id!);
    if (!isExisting) {
      await db.add(user.toJson());
      debugPrint("UserAdded: ${await db.add(user.toJson())}");
    }
  }

  Future<UserModel> getUserWithId(String uid) async {
    QuerySnapshot userQuery = await db.where('id', isEqualTo: uid).get();
    DocumentSnapshot documentSnapshot = userQuery.docs.first;
    UserModel user = UserModel();
    user.fromJson(documentSnapshot.data());
    return user;
  }

  String? getCurrentUserId() {
    return PreferenceUtils.getString("firebase_id", "");
  }

  Future<bool> _isUserAlreadyExisting(String userId) async {
    bool isExisting = false;
    QuerySnapshot documents = await db.where('id', isEqualTo: userId).get();
    if (documents.docs.isEmpty) {
      return false;
    } else {
      UserModel user = UserModel();
      user.fromJson(documents.docs.first.data());
      existingUser = user;
      return true;
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> list = [];
    QuerySnapshot userQuery = await db.get();
    for (DocumentSnapshot documentSnapshot in userQuery.docs) {
      UserModel user = UserModel();
      user.fromJson(documentSnapshot.data());
      list.add(user);
    }
    return list;
  }

  Future<UserModel?> getUserWithEmail({@required String? email}) async {
    QuerySnapshot documents = await db.where('email', isEqualTo: email).get();
    if (documents.docs.isEmpty) {
      return null;
    }
    UserModel user = UserModel();
    user.fromJson(documents.docs.first.data());
    return user;
  }
}
