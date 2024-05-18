import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  static final storageRef = FirebaseStorage.instance.ref();

  static Future<String> getFlagUrl(String countryCode) async {
    return await storageRef.child("Flaggs/$countryCode.png").getDownloadURL();
  }
}
