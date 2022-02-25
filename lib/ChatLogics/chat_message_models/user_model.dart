import 'package:uuid/uuid.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? imageUrl;

  UserModel({this.name, this.imageUrl, this.email}) {
    id = id ??= const Uuid().v1();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'email': email,
      };

  fromJson(dynamic parsedJson) {
    id = parsedJson['id'] ?? '';
    name = parsedJson['name'] ?? '';
    email = parsedJson['email'] ?? '';
    imageUrl = parsedJson['imageUrl'] ?? '';
  }
}
