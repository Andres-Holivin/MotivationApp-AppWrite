import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

User? user;
String userId = "...Login";
String endPoint = 'http://localhost/v1';
String projectId = '625e582ed9181d969f1e';
String apiKey =
    '28af44f4cdc9859c5c94afffd81eb1c022cd1773eec9a4522f577a7a8e08ecfbabd2619a0c8807382411c6851ece0fb7547fcc237bc1fa370aab7c659207596528bbe1b89b1f80a1b3437fc39d6c3952f83e91f20ca452a3e691a4666fd01c77762cc7378078430b46309141a1b06bb28a57094bad76cec7cacba4ad8d0d3fe6';
Client client =
    Client().setEndpoint(endPoint).setProject(projectId).setSelfSigned();
Account account = Account(client);
Storage storage = Storage(client);
Database database = Database(client);
void CallWs() async {
  try {
    final response = await account.create(
        password: 'andresholivin',
        email: 'andres@gmail.com',
        userId: Uuid().v1());
    print(response);
  } on AppwriteException catch (e) {
    print(e.message);
  }
}

void OauthGoogle() async {
  Account account = new Account(client);
  try {
    account
        .createOAuth2Session(provider: 'google')
        .then((value) => print(value));
    user = await account.get();
  } on AppwriteException catch (e) {
    print(e.message);
  }
}

void OauthGithub() async {
  try {
    account
        .createOAuth2Session(provider: 'github')
        .then((value) => print(value));
    user = await account.get();
  } on AppwriteException catch (e) {
    print(e.message);
  }
}

void OauthLogOut() async {
  Account account = new Account(client);
  try {
    await account
        .deleteSession(sessionId: 'current')
        .then((value) => print(value));
  } on AppwriteException catch (e) {
    print(e.message);
  }
}

void OauthSession() async {
  Account account = new Account(client);
  try {
    await account
        .getSession(sessionId: 'current')
        .then((value) => print(value));
    print(account);
  } on AppwriteException catch (e) {
    print(e.message);
  }
}

void GetCategory() async {
  // database.getDocument(collectionId: 6261285d27d1c3e14fcd, documentId: documentId)
}
