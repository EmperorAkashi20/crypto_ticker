import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  late FirebaseAuth firebaseInstance;
  late FirebaseStorage firebaseStorage;
  late FirebaseDatabase firebaseDatabase;
  late FirebaseFirestore firebaseFirestore;

  @override
  void onInit() {
    firebaseInstance = FirebaseAuth.instance;
    firebaseStorage = FirebaseStorage.instance;
    firebaseDatabase = FirebaseDatabase.instance;
    firebaseFirestore = FirebaseFirestore.instance;
    super.onInit();
  }
}
