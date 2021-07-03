import 'dart:io';

import 'package:e_trans/data/models/api_response.dart';
import 'package:e_trans/data/models/usermodel.dart';
import 'package:e_trans/data/service/local_service.dart';
import 'package:e_trans/data/service/network_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider._internal();
  static final _singleton = AuthProvider._internal();
  factory AuthProvider() => _singleton;

  final NetworkService networkService = NetworkService();
  final LocalService localService = LocalService();
  bool _islogin = false;
  bool get isLogin => _islogin;
  String _email = '';
  String get email => _email;
  int? _uid = -1;
  int? get uid => _uid;
  bool _isLoading = false;
  bool get isloading => _isLoading;
  Usermodel _userProfile = Usermodel();
  Usermodel get userProfile => _userProfile;

  // Future<ApiResponse> updateProfile(
  //     String email, String password, String name) async {
  //   try {
  //     return networkService.updateProfile(email, password, name);
  //   } on SocketException {
  //     return ApiResponse(message: "cannot connect to server");
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return ApiResponse(message: "internal error");
  //   }
  // }

  loadUsermodel() async {
    if (isLogin) {
      var _userdetail = await networkService.getProfile();
      _userProfile = _userdetail;
      notifyListeners();
    }
  }

  loadAuthDetails() async {
    var _result = await localService.getLoginStatus();
    if (_result) {
      var _details = await localService.getLoginDetails();
      _islogin = true;
      _email = "${_details['email']}";
      _uid = _details['idUser'];
      loadUsermodel();
    } else {
      _islogin = false;
      _email = '';
      _uid = -1;
    }
    notifyListeners();
  }

  update() {
    notifyListeners();
  }

  Future<ApiResponse> login(String mail, String password) async {
    try {
      var _result = await networkService.login(mail, password);
      if (_result.result ?? false) {
        localService.saveLoginDetails(_result.data!.email!, _result.data!.uid!);
        loadAuthDetails();
      }
      return _result;
    } on SocketException {
      return ApiResponse(message: "cannot connect to server");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(message: "internal error");
    }
  }

  Future<ApiResponse> register(
      String email, String password, String name) async {
    try {
      var _result = await networkService
          .register(Usermodel(name: name, email: email, password: password));
      if (_result.result ?? false) {
        localService.saveLoginDetails(_result.data!.email!, _result.data!.uid!);
        loadAuthDetails();
      }
      return _result;
    } on SocketException {
      return ApiResponse(message: "cannot connect to server");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(message: "internal error");
    }
  }

  void logout() async {
    await localService.removeLoginDetails();
    loadAuthDetails();
  }

  Future<ApiResponse> changePassword(String newPassword) async {
    try {
      var _result = await networkService.changePassword(newPassword);
      return _result;
    } on SocketException {
      return ApiResponse(message: "cannot connect to server");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(message: "internal error");
    }
  }

  Future<ApiResponse> changePasswordForget(
      String newPassword, int idUser) async {
    try {
      var _result =
          await networkService.changePasswordForget(newPassword, idUser);
      return _result;
    } on SocketException {
      return ApiResponse(message: "cannot connect to server");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(message: "internal error");
    }
  }

  Future<ApiResponse> sendVerificationCode(String email) async {
    try {
      var _result = await networkService.sendVerificationCode(email);
      return _result;
    } on SocketException {
      return ApiResponse(message: "cannot connect to server");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(message: "internal error");
    }
  }
}
