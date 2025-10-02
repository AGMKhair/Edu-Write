import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadOrderFile(String orderId, String filename, Uint8List bytes) async {
    final ref = _storage.ref().child('orders/$orderId/$filename');
    await ref.putData(bytes);
    return ref.getDownloadURL();
  }

  Future<String> uploadPaperFile(String paperId, String filename, Uint8List bytes) async {
    final ref = _storage.ref().child('papers/$paperId/$filename');
    await ref.putData(bytes);
    return ref.getDownloadURL();
  }
}
