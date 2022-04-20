import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:uuid/uuid.dart';

void CallWs() async {
  String endPoint = 'http://localhost/v1';
  String projectId = '625e582ed9181d969f1e';
  String apiKey =
      '28af44f4cdc9859c5c94afffd81eb1c022cd1773eec9a4522f577a7a8e08ecfbabd2619a0c8807382411c6851ece0fb7547fcc237bc1fa370aab7c659207596528bbe1b89b1f80a1b3437fc39d6c3952f83e91f20ca452a3e691a4666fd01c77762cc7378078430b46309141a1b06bb28a57094bad76cec7cacba4ad8d0d3fe6';
  Client client = Client();
  client
      .setEndpoint(endPoint)
      .setProject(projectId)
      .setKey(apiKey)
      .setSelfSigned();
  Users users = Users(client);

  try {
    final response = await users.create(
        password: 'andresholivin',
        email: 'andres@gmail.com',
        userId: Uuid().v1());
    print(response);
  } on AppwriteException catch (e) {
    print(e.message);
  }
}
