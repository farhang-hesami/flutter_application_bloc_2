import 'package:dio/dio.dart';
import 'package:flutter_application_bloc_2/models/users.dart';

class ApiServise {
  Dio httpClient = Dio(BaseOptions(baseUrl: 'https://retoolapi.dev/'));
  Future<List<Users>> getusers() async {
    var response = await httpClient.get('ZXX8ev/data');
    List<Users> users = [];
    (response.data as List).forEach((element) {
      users.add(Users.fromJson(element));
    });
    return users;
  }

  Future<Users> addUser(Users user) async {
    var response = await httpClient.post('ZXX8ev/data', data: user.toJson());
    return Users.fromJson(response.data);
  }
}
