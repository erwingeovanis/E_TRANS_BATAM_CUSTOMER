import 'package:dio/dio.dart';
import 'package:e_trans/data/models/api_response.dart';
import 'package:e_trans/data/models/halte.dart';
import 'package:e_trans/data/models/jurusan.dart';
import 'package:e_trans/data/models/news.dart';
import 'package:e_trans/data/models/usermodel.dart';
import 'package:e_trans/data/service/local_service.dart';
import 'package:flutter/foundation.dart';

abstract class BaseService {
  Future<List<News>> getNews();
  Future<ApiResponse> login(String email, String password);
  Future<ApiResponse> register(Usermodel profil);
  Future<List<Halte>> getHalte();
  Future<ApiResponse> changePassword(String password);
  Future<ApiResponse> changePasswordForget(String password, int idUser);
  Future<List<Jurusan>> getJurusan();
  Future<ApiResponse> sendVerificationCode(String email);
  // Future<ApiResponse> makeOrder(Book newBooking);
  // Future<ApiResponse> updateProfile(String email, String password, String nama);
  Future<Usermodel> getProfile();
  static const newsEndpoint = "/news";
  static const halteEndpoint = "/halte";
  static const jurusanEndpoint = "/jurusan";
  static const loginEndpoint = "/auth/login";
  static const registerEndpoint = "/auth/register";
  static const profileEndpoint = "/profile";
}

class NetworkService extends BaseService {
  NetworkService._internal();
  static final _singleton = NetworkService._internal();
  factory NetworkService() => _singleton;
  static const String BASEURL = "http://192.168.43.39";

  final Dio _dio = Dio(BaseOptions(
    baseUrl: BASEURL,
  ));
  final LocalService _localService = LocalService();

  @override
  Future<List<News>> getNews() async {
    List<News> news = [];
    var response = await _dio.get<List>(BaseService.newsEndpoint);
    if (response.statusCode == 200) {
      print(response.data);
      (response.data ?? [])
          .map<News>((e) => News.fromJson(e))
          .forEach((element) {
        news.add(element);
      });
    }
    return news;
  }

  @override
  Future<List<Jurusan>> getJurusan() async {
    List<Jurusan> jurusan = [];
    var response = await _dio.get<List>(BaseService.jurusanEndpoint);
    if (response.statusCode == 200) {
      (response.data ?? [])
          .map<Jurusan>((e) => Jurusan.fromJson(e))
          .forEach((element) {
        jurusan.add(element);
      });
    }
    return jurusan;
  }

  @override
  Future<List<Halte>> getHalte() async {
    List<Halte> halteList = [];
    var response = await _dio.get<List>(BaseService.halteEndpoint);
    if (response.statusCode == 200) {
      (response.data ?? [])
          .map<Halte>((e) => Halte.fromJson(e))
          .forEach((element) {
        halteList.add(element);
      });
    }
    return halteList;
  }

  @override
  Future<ApiResponse> login(String email, String password) async {
    var response = await _dio.post<Map<String, dynamic>>(
      BaseService.loginEndpoint,
      data: FormData.fromMap({
        "email": email,
        "password": password,
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("${response.data}");
      return ApiResponse.fromJson(
          response.data ?? {"message": "internal error"});
    }
    return ApiResponse(message: "internal error");
  }

  @override
  Future<ApiResponse> register(
    Usermodel profile,
  ) async {
    var data = profile.toJson();
    data.removeWhere((key, value) => value == null);

    var formData = FormData.fromMap(data);
    debugPrint(data.toString());
    var response = await _dio.post<Map<String, dynamic>>(
        BaseService.registerEndpoint,
        data: formData);
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(
          response.data ?? {"message": "internal error"});
    }
    return ApiResponse(message: "internal error");
  }

  @override
  Future<Usermodel> getProfile() async {
    var id = (await _localService.getLoginDetails())['idUser'];
    var res = await _dio.get("/profile/$id/details");
    if (res.statusCode == 200) {
      return Usermodel.fromJson(res.data);
    }
    return Usermodel();
  }

  @override
  Future<ApiResponse> changePassword(String password) async {
    var id = (await _localService.getLoginDetails())['idUser'];

    var res = await _dio.post("/profile/$id/change-password",
        data: FormData.fromMap({"password": password}));
    if (res.statusCode == 200) {
      debugPrint(res.data.toString() + password);
      return ApiResponse.fromJson(res.data);
    }
    return ApiResponse(
        result: false, message: "cannot process you\'re request");
  }

  @override
  Future<ApiResponse> sendVerificationCode(String email) async {
    var res = await _dio.post("/profile/$email/reset",
        data: FormData.fromMap({"email": email}));
    if (res.statusCode == 200) {
      debugPrint(res.data.toString());
      return ApiResponse.fromJson(res.data);
    }
    return ApiResponse(
        result: false, message: "cannot process you\'re request");
  }

  @override
  Future<ApiResponse> changePasswordForget(String password, int idUser) async {
    var res = await _dio.post("/profile/$idUser/change-password",
        data: FormData.fromMap({"password": password}));
    if (res.statusCode == 200) {
      debugPrint(res.data.toString() + password);
      return ApiResponse.fromJson(res.data);
    }
    return ApiResponse(
        result: false, message: "cannot process you\'re request");
  }

  // @override
  // Future<ApiResponse> updateProfile(
  //     String email, String password, String name) async {
  //   int id = (await _localService.getLoginDetails())["idUser"];

  //   var map = {
  //     'email': email,
  //     'password': password,
  //     'name': name,
  //   };
  //   var response = await _dio.post(
  //     BaseService.profileEndpoint + "/$id/update",
  //     data: FormData.fromMap(map),
  //   );
  //   if (response.statusCode == 200) {
  //     return ApiResponse.fromJson(response.data);
  //   }

  //   return ApiResponse(message: "internal error");
  // }
}
