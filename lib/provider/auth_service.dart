import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eekie/components/constance.dart';
import 'package:eekie/local/cache_helper.dart';
import 'package:eekie/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
  creating,
  created,
  uncreated
}

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth;
  final FirebaseFirestore store = FirebaseFirestore.instance;

  User? _user;
  Status _status = Status.uninitialized;

  Status get status => _status;

  User? get user => _user;
  String? errorMessage;

  String? get error => errorMessage;

  UserModel? get userModel => _userModel;
  AuthService.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen((event) => _onAuthStateChanged);
  }

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _status = Status.authenticating;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value){
        CacheHelper.saveData(key: "id", value: _auth.currentUser!.uid);
      });
      _status = Status.authenticated;

      notifyListeners();
      return true;
    } catch (e) {
      _status = Status.unauthenticated;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String phone,
    required String address,
  }) async {
    try {
      _status = Status.creating;
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        createUser(
            address: address,
            phone: phone,
            id: value.user!.uid,
            username: username,
            email: email,
            password: password);
      });
      notifyListeners();
      return true;
    } catch (e) {
      _status = Status.uncreated;
      notifyListeners();
      return false;
    }
  }
  void createUser({
    required String id,
    required String username,
    required String email,
    required String phone,
    required String address,
    required String password,
  }) {
    UserModel user = UserModel(
      id: id,
      username: username,
      email: email,
      phone: phone,
      address: address,
      password: password,
    );
    store.collection('users').doc(id).set(user.toMap());
    notifyListeners();
  }



  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.authenticated;
    }
    notifyListeners();
  }

  UserModel? _userModel;

  Future getUserData() async{
   store
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((value) {
      _userModel = UserModel.fromJson(value.data());
      uId = _userModel!.id.toString();
      notifyListeners();
    });
  }
}
