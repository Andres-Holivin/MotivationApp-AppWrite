import 'dart:typed_data';

import 'package:MotivationApps/models/user_model.dart';
import 'package:appwrite/appwrite.dart';

class UserService {
  final Client client;
  late Account account;
  late Database database;
  late Storage storage;
  UserService(this.client) {
    account = Account(client);
    database = Database(client);
    storage = Storage(client);
  }
  Future<UserModel> getCurrentUser() async {
    try {
      final user = await account.get();
      final data = await database.getDocument(
          collectionId: 'users', documentId: user.$id);
      final img = await _getProfilePicture(data.data['imgId']);
      return UserModel.fromMap(data.data).copyWith(image: img);
    } catch (_) {
      rethrow;
    }
  }

  Future<Uint8List> _getProfilePicture(String fileId) async {
    try {
      final data = await storage.getFilePreview(fileId: fileId, bucketId: '');
      return data;
    } on AppwriteException {
      rethrow;
    }
  }
}
