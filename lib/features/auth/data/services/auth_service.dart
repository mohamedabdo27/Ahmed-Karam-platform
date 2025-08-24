import 'dart:developer';

import 'package:ahmed_karam/core/utils/function/cach_user.dart';
import 'package:ahmed_karam/features/auth/data/models/user_model.dart';
import 'package:ahmed_karam/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class AuthService {
  Future<Either<Failure, User?>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel? myUsererModel;
      CollectionReference users = FirebaseFirestore.instance.collection(
        'users',
      );
      final doc = await users.doc(credential.user!.uid).get();
      var data = doc.data() as Map<String, dynamic>;
      if (doc.exists) {
        myUsererModel = UserModel();
        myUsererModel.email = data['email'];
        myUsererModel.id = data['id'];
        myUsererModel.name = data['name'];
        await cachUserModel(userModel: myUsererModel);
      }
      userModel = myUsererModel;

      return Right(credential.user);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      log(e.code);

      return Left(Failure.fromFirebaseLogin(e.code));
    } catch (e) {
      log(e.toString());
      return Left(Failure());
    }
  }

  Future<Either<Failure, User?>> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      CollectionReference users = FirebaseFirestore.instance.collection(
        'users',
      );
      await users.doc(credential.user!.uid).set({
        'name': name,
        'id': credential.user!.uid,
        'email': email,
      });
      UserModel myUsererModel = UserModel(
        id: credential.user!.uid,
        name: name,
        email: email,
      );
      await cachUserModel(userModel: myUsererModel);

      userModel = myUsererModel;
      return Right(credential.user);
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return Left(Failure.fromFirebaseSignup(e.code));
    } catch (e) {
      log(e.toString());
      return Left(Failure());
    }
  }
}

class Failure {
  final String message;
  Failure({this.message = "there was a problem ,try again later"});
  factory Failure.fromFirebaseLogin(String code) {
    if (code == 'user-not-found') {
      return Failure(message: 'No user found for that email.');
    } else if (code == 'wrong-password') {
      return Failure(message: 'Wrong password provided for that user.');
    } else if (code == "invalid-email") {
      return Failure(message: 'Invalid email address.');
    } else if (code == "user-disabled") {
      return Failure(message: 'user is disabled');
    } else if (code == 'invalid-credential') {
      return Failure(message: "Invalid email or password.");
    } else {
      return Failure();
    }
  }
  factory Failure.fromFirebaseSignup(String code) {
    if (code == 'email-already-in-use') {
      return Failure(message: 'email already exists');
    } else if (code == 'weak-password') {
      return Failure(message: 'Weak password.');
    } else if (code == "invalid-email") {
      return Failure(message: 'Invalid email address.');
    } else {
      return Failure();
    }
  }
}
