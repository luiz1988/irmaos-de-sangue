import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:irmaos_de_sangue/pages/_models/register_user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({
    String name,
    String email,
    String password,
    String companyId,
    String numeroCelular,
    String sexoId,
    String peso,
    String estadoCivilId,
    String dataNascimento,
    String tipoSanguineoId,
    String dataDoacao,
    String estadoId,
    String cidadeId,
    String photoUrl,
  }) async {
    var user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final CollectionReference postsRef =
        Firestore.instance.collection('/users');

    var postID = user.user.uid;

    RegisterUser post = new RegisterUser(
        name,
        email,
        companyId,
        numeroCelular,
        sexoId,
        peso,
        estadoCivilId,
        dataNascimento,
        tipoSanguineoId,
        dataDoacao,
        estadoId,
        cidadeId,
        photoUrl,
        '',
        '',
        1,
        'https://firebasestorage.googleapis.com/v0/b/irmao-de-sangue.appspot.com/o/doe_sangue.jpg?alt=media&token=e68f85e9-a159-476b-9c53-4d987ba0690d');
    Map<String, dynamic> postData = post.toJson();
    await postsRef.document(postID).setData(postData);
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  Future<String> getUserUid() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<Object> getUserInfo() async {
    var userId = await _firebaseAuth.currentUser();
    if (userId != null) {
      var code = userId.uid.toString();
      var document =
          await Firestore.instance.collection("users").document(code).get();
      document.data["email"] = userId.email;
      return document.data;
    }
    return null;
  }

   Future<dynamic> getUserInfoDynamic() async {
    var userId = await _firebaseAuth.currentUser();
    if (userId != null) {
      var code = userId.uid.toString();
      var document =
          await Firestore.instance.collection("users").document(code).get();
      document.data["email"] = userId.email;
      return document.data;
    }
    return null;
  }
}
