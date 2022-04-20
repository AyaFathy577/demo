class UserModel {
  late int id;
  late String name;
  late String phone;

  UserModel({required this.id, required this.name, required this.phone});

  UserModel.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    phone = data["phone"];
  }

  Map<String, dynamic> toJson(UserModel userModel) => {
        "id": userModel.id,
        "name": userModel.name,
        "phone": userModel.phone,
      };
}
