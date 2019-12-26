import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'user_model.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    loadUserData();
  }
  final String _dataPath = "assets/data/users.json";
  List<User> _users;
  bool _isLoading = true;

  get users => _users;
  get isLoading => _isLoading;

  Future loadUserData() async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    _users = UserList.fromJson(jsonUserData['users']).users;
    print('done loading user!' + jsonEncode(_users));
    _isLoading = false;
    notifyListeners();
  }

  Future<String> loadAsset() async {
    return await Future.delayed(Duration(seconds: 10), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }
}
