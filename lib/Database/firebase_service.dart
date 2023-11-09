import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'firebase_options.dart';

class FirebaseService {
  static init() async {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  static FirebaseApp getAppInstance() {
    return Firebase.app();
  }

  static Future<void> deleteAppInstance() async {
    await Firebase.app().delete();
  }
}

class FireStoreService {
  late FirebaseFirestore firestore;

  late CollectionReference col;

  FireStoreService(String collectionName) {
    firestore = FirebaseFirestore.instance;
    col = firestore.collection(collectionName);
  }
  Stream<QuerySnapshot> retriveData() {
    return col.snapshots();
  }

  insertData(Map<String, dynamic> value) async {
    try {
      await col.add(value);
      debugPrint("Data added value ");
    } catch (e) {
      rethrow;
    }
  }

  deleteData(String docId) async {
    try {
      await col.doc(docId).delete();
    } catch (e) {
      rethrow;
    }
  }

  updateData(String docId, Map<String, dynamic> newVal) async {
    try {
      await col.doc(docId).update(newVal);
    } catch (e) {
      rethrow;
    }
  }
}

class FireStorageService {
  late FirebaseStorage fstorage;

  FireStorageService() {
    fstorage = FirebaseStorage.instance;
  }
  Future<String?> uploadImage(String imgpath) async {
    try {
      String? imgUrl;
      File imgfile = File(imgpath);
      String imgName = DateTime.now().microsecond.toString();
      Reference ref = fstorage.ref().child("images/$imgName");

      UploadTask task = ref.putFile(imgfile);

      await task;

      task.whenComplete(() async {
        debugPrint("Image Upload complete");
      });

      imgUrl = await ref.getDownloadURL();

      return imgUrl;
    } on Exception catch (e) {
      debugPrint("Image Upload Error: $e");
      return e.toString();
    }
  }
}
