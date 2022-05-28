class UserModel {
  String? id;
  String? username;
  String? email;
  String? phone;
  String? address;
  String? password;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.password,
    this.phone,
    this.address,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address,
    };
  }

  // final FirebaseFirestore store = FirebaseFirestore.instance;
  //
  // void createUser({
  //   required String id,
  //   required String username,
  //   required String email,
  //   required bool isEmailVerified,
  // }) {
  //   UserModel user = UserModel(
  //     id: id,
  //     username: username,
  //     email: email,
  //     phone: phone,
  //     address: address,
  //   );
  //   store.collection('users').doc(id).set(user.toMap()).then((value) {});
  // }
}
