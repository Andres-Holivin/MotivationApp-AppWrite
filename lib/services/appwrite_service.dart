import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'client_provider.dart';

class AppWriteService extends ChangeNotifier {
  late Client client;
  late Account account;
  late Database database;
  late Storage storage;

  AppWriteService(this.client) {
    account = Account(client);
    database = Database(client);
    storage = Storage(client);
  }
  void getClient() async {
    client = await clientProvider();
  }

  Future<User?> getCurrentUser() async {
    try {
      User? userAccount = await account.get();
      return userAccount;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> login(String email, String password) async {
    bool status = false;
    try {
      print(email + " " + password);
      Session session =
          await account.createSession(password: password, email: email);
      print(session.toString());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> regist(String email, String password, String name) async {
    bool status = false;
    try {
      User user = await account.create(
          email: email, password: password, name: name, userId: 'unique()');
      print(user.toString());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginOauth2(String method) async {
    bool status = false;
    try {
      await account
          .createOAuth2Session(
        provider: method,
      )
          .then((value) {
        print("line 37 " + value.toString());
        status = true;
      }).catchError((error) {
        print("line 44 " + error.response.toString());
        status = false;
      });
      notifyListeners();
      print("Status " + status.toString());
      return status;
    } catch (e) {
      print("line 51 " + e.toString());
      return false;
    }
  }

  Future<void> logOut() async {
    try {
      await account
          .deleteSession(sessionId: 'current')
          .then((value) => print(value));
      notifyListeners();
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  Future<DocumentList?> getCategory() async {
    var collectionId = await dotenv.get('CATEGORY_COLLECTION_ID');
    DocumentList docList =
        await database.listDocuments(collectionId: collectionId);
    return docList;
  }

  Future<Uint8List> getCategoryPicture(String fileId) async {
    var bucketId = await dotenv.get('CATEGORY_BUCKET_ID');

    dynamic picture =
        await storage.getFileView(bucketId: bucketId, fileId: fileId);
    return picture;
  }

  void createCategory() async {
    var bucketId = await dotenv.get('CATEGORY_BUCKET_ID');
    var collectionId = await dotenv.get('CATEGORY_COLLECTION_ID');
    database
        .createDocument(
            collectionId: collectionId,
            data: {'file_id': "1231", 'title': 'test', 'bucket_id': '423432'},
            documentId: 'unique()')
        .then((value) => print(value));
    print(collectionId);
  }
}
