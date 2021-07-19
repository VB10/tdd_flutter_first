import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_flutter_first/home/model/home_model.dart';

abstract class IHomeCache {
  Future<bool> saveModel(ReqProfile model);
  Future<ReqProfile?> getModel();
  Future<bool> removeModel();

  Future<ReqProfile?> getModelWithoutExpriy();

  int durationTime = 5;

  IHomeCache({int? durationTime}) {
    this.durationTime = durationTime ?? 5;
  }
}

class HomeCacheShared extends IHomeCache {
  SharedPreferences? _prefs;

  HomeCacheShared({int? time}) : super(durationTime: time);

  @override
  Future<ReqProfile?> getModel() async {
    _prefs = await SharedPreferences.getInstance();
    final _modelValues = _prefs?.getString(runtimeType.toString());
    if (_modelValues == null) return null;
    final _jsonBody = jsonDecode(_modelValues);
    return ReqProfile.fromJson(_jsonBody);
  }

  @override
  Future<bool> saveModel(ReqProfile model) async {
    _prefs = await SharedPreferences.getInstance();
    model.expiryTime = DateTime.now().add(Duration(milliseconds: durationTime)).toIso8601String();
    final _modelValues = jsonEncode(model);
    return await _prefs?.setString(runtimeType.toString(), _modelValues) ?? false;
  }

  @override
  Future<bool> removeModel() async {
    _prefs = await SharedPreferences.getInstance();
    return await _prefs?.remove(runtimeType.toString()) ?? false;
  }

  @override
  Future<ReqProfile?> getModelWithoutExpriy() async {
    final data = await getModel();
    if (data != null) return data.isExpiry() ? null : data;
    return null;
  }
}
