// To parse this JSON data, do
//
//     final genericResponseModel = genericResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GenericResponseModel genericResponseModelFromJson(String str) => GenericResponseModel.fromJson(json.decode(str));

String genericResponseModelToJson(GenericResponseModel data) => json.encode(data.toJson());

class GenericResponseModel {
  dynamic code;
  String message;

  GenericResponseModel({
    this.code,
    required this.message,
  });

  factory GenericResponseModel.fromJson(Map<String, dynamic> json) => GenericResponseModel(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
