import 'dart:typed_data';

import 'package:MotivationApps/models/category_model.dart';
import 'package:MotivationApps/models/enum_scheduler_type.dart';
import 'package:MotivationApps/models/notification_model.dart';
import 'package:MotivationApps/models/user_scheduler_model.dart';
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

  Future<bool> register(String email, String password, String name) async {
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
        status = true;
      }).catchError((error) {
        status = false;
      });
      notifyListeners();
      print(account.get());
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

  Future<List<CategoryModel?>> getCategory() async {
    var collectionId = await dotenv.get('CATEGORY_COLLECTION_ID');
    List<CategoryModel> categoryModel = [];
    DocumentList docList =
        await database.listDocuments(collectionId: collectionId);
    for (Document doc in docList.documents) {
      var fileImage = await getCategoryPicture(doc.data['file_id']);
      var iconImage = await getCategoryPicture(doc.data['icon_id']);
      categoryModel.add(CategoryModel(
          categoryId: doc.$id,
          bucketId: doc.data['bucket_id'],
          file: fileImage,
          icon: iconImage,
          title: doc.data['title'],
          text: doc.data['text']));
    }
    return categoryModel;
  }

  Future<Uint8List> getCategoryPicture(String fileId) async {
    var bucketId = await dotenv.get('CATEGORY_BUCKET_ID');
    dynamic picture =
        await storage.getFileView(bucketId: bucketId, fileId: fileId);
    return picture;
  }

  Future<List<UserSchedulerModel>> getListScheduler() async {
    List<UserSchedulerModel> listScheduler = [];
    User user = await account.get();
    var schedulerCollectionId = await dotenv.get('SCHEDULER_COLLECTION_ID');
    var categoryBucketId = await dotenv.get('CATEGORY_BUCKET_ID');
    var categoryCollectionId = await dotenv.get('CATEGORY_COLLECTION_ID');

    DocumentList? docSchedulerTemp = await database.listDocuments(
      collectionId: "627225989080633c7809",
    );

    List<Document> docScheduler = docSchedulerTemp.documents
        .where((element) => element.data['user_id'] == user.$id)
        .toList();

    for (Document itemScheduler in docScheduler) {
      Document category = await database.getDocument(
          collectionId: categoryCollectionId,
          documentId: itemScheduler.data['category_id']);
      Uint8List iconCategory =
          await getCategoryPicture(category.data['icon_id']);
      listScheduler.add(UserSchedulerModel(
          userId: itemScheduler.data['user_id'],
          categoryTitle: category.data['title'],
          schedulerType: itemScheduler.data['scheduler_type'],
          status: itemScheduler.data['status'],
          categoryIcon: iconCategory,
          categoryId: itemScheduler.data['category_id'],
          id: itemScheduler.data['\$id']));
    }
    return listScheduler;
  }

  Future<CategoryModel?> createScheduler(
      String token, String categoryId, EnumSchedulerType type) async {
    var schedulerCollectionId = await dotenv.get('SCHEDULER_COLLECTION_ID');
    CategoryModel? result = null;
    var user = await account.get();
    try {
      await database.createDocument(
          collectionId: schedulerCollectionId,
          documentId: 'unique()',
          data: {
            'user_id': user.$id,
            'category_id': categoryId,
            'status': true,
            'scheduler_type': type.toString().split('.')[1],
            'device_token': token
          });

      notifyListeners();
      return await getCategoryById(categoryId);
    } catch (e) {
      print(e);
      return null;
    }
  }

  void changeScheduleStatus(bool status, String id) async {
    var schedulerCollectionId = await dotenv.get('SCHEDULER_COLLECTION_ID');
    var user = await account.get();
    Document docSchedulerTemp = await database.updateDocument(
      collectionId: schedulerCollectionId,
      data: {'status': status},
      documentId: id,
    );
    notifyListeners();
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

  Future<List<NotificationModel>> getListNotification() async {
    var notificationCollectionId =
        await dotenv.get('NOTIFICATION_COLLECTION_ID');
    var user = await account.get();
    DocumentList? docTempList =
        await database.listDocuments(collectionId: notificationCollectionId);
    List<Document> listNotification = docTempList.documents
        .where((element) => element.data['user_id'] == user.$id)
        .toList();
    List<NotificationModel> listNotificationModel = [];
    for (Document item in listNotification) {
      var category = await getCategoryById(item.data['category_id']);
      listNotificationModel.add(NotificationModel(
        id: item.$id,
        categoryId: item.data['category_id'],
        timeSend: DateTime.now(),
        userId: item.data['user_id'],
        category: category,
        text: item.data['text'],
      ));
    }
    return listNotificationModel;
  }

  Future<CategoryModel> getCategoryById(String id) async {
    var categoryCollectionId = await dotenv.get('CATEGORY_COLLECTION_ID');
    Document docList = await database.getDocument(
        collectionId: categoryCollectionId, documentId: id);
    var fileImage = await getCategoryPicture(docList.data['file_id']);
    var iconImage = await getCategoryPicture(docList.data['icon_id']);
    return CategoryModel(
        text: docList.data['text'],
        categoryId: id,
        file: fileImage,
        title: docList.data['title'],
        bucketId: docList.data['bucket_id'],
        icon: iconImage);
  }

  Future<bool> deleteSchedule(String id) async {
    bool status = false;
    var schedulerCollectionId = await dotenv.get('SCHEDULER_COLLECTION_ID');
    try {
      database
          .deleteDocument(collectionId: schedulerCollectionId, documentId: id)
          .then((value) => status = true)
          .catchError((e) => status = false);
    } catch (e) {
      print(e);
      status = false;
    }
    notifyListeners();
    return status;
  }
}
