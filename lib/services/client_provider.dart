import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Client> clientProvider() async {
  Client client = Client()
      .setEndpoint(await dotenv.get('URL'))
      .setProject(await dotenv.get('PROJECT_ID'))
      .setSelfSigned();
  return client;
}
