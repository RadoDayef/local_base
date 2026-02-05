class User {
  int age;
  String id, gender, lastName, firstName;

  User({required this.id, required this.age, required this.gender, required this.lastName, required this.firstName});

  // Convert User to Map
  Map<String, dynamic> toMap() {
    return {"id": id, "age": age, "gender": gender, "lastName": lastName, "firstName": firstName};
  }

  // Create User from Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map["id"], age: map["age"], gender: map["gender"], lastName: map["lastName"], firstName: map["firstName"]);
  }
}
