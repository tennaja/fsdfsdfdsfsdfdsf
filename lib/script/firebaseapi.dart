// ignore_for_file: unused_import
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  static UploadTask? uploadfile(String imagede, File image) {
    try {
      print(imagede);
      final ref = FirebaseStorage.instance.ref(imagede);
      return ref.putFile(image);
    } on FirebaseException catch (e) {
      print("error : $e");
    }
  }
}
