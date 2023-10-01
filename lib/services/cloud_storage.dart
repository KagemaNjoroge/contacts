import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ContactCloudStorageService {
  Future<String> uploadImage(String path, String name) async {
    final storage = FirebaseStorage.instance;
    final image = storage.ref().child('images/$name');
    final img = File(path);
    final uploadTask = await image.putFile(img);
    final url = await uploadTask.ref.getDownloadURL();
    return url;
  }
}
