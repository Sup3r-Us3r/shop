import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/util/toast.dart';

class UserBloc extends ChangeNotifier {
  UserModel _userData;
  UserModel get userData => _userData;

  Future<bool> login(String email, String password) async {
    Dio dio = Dio();
    Response response;

    try {
      response = await dio.post(
        'http://192.168.2.8:3333/user/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      _userData = UserModel.fromJson(response.data);

      await _saveUserPrefs(_userData);

      return true;
    } on DioError catch (err) {
      toastError(err.response.data['error']);

      return false;
    } catch (err) {
      toastError('Erro ao fazer login');

      return false;
    }
  }

  Future _saveUserPrefs(UserModel data) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    await _prefs.setString(
      '@shop/userData',
      json.encode(data),
    );
  }

  Future<bool> getUserPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    try {
      var response = _prefs.getString('@shop/userData');
      _userData = UserModel.fromJson(json.decode(response));

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> signOut() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    return _prefs.remove('@shop/userData');
  }
}
