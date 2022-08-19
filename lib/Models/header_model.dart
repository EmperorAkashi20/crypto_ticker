// To parse this JSON data, do
//
// final onBoardUserModel = onBoardUserModelFromJson(jsonString);

import 'dart:convert';

HeaderModel onBoardUserModelFromJson(String str) =>
    HeaderModel.fromJson(json.decode(str));

String onBoardUserModelToJson(HeaderModel data) => json.encode(data.toJson());

class HeaderModel {
  String? authorization;

  HeaderModel({
    required this.authorization,
  });

  factory HeaderModel.fromJson(Map<String, dynamic> json) => HeaderModel(
        authorization: json["Authorization"],
      );

  Map<String, dynamic> toJson() => {
        "Authorization": authorization,
      };
  Map<String, String> toHeader() => {
        "Authorization": authorization ?? " ",
        "Content-Type": "application/json"
      };

  Map<String, String> toHeaderFileUpload() => {
        "Authorization": authorization ?? " ",
        "Content-Type": "multipart/form-data"
      };
}

class HeaderModelDrawer {
  String? documentDrawerToken;

  HeaderModelDrawer({
    required this.documentDrawerToken,
  });

  factory HeaderModelDrawer.fromJson(Map<String, dynamic> json) =>
      HeaderModelDrawer(
        documentDrawerToken: json["DocumentDrawerToken"],
      );

  Map<String, String> toHeader() => {
        "DocumentDrawerToken": documentDrawerToken ?? " ",
        'Accept': 'application/json',
        "Content-Type": "application/json"
      };

  Map<String, String> toHeaderFileUpload() => {
        "DocumentDrawerToken": documentDrawerToken ?? " ",
        "Media-Type": "application/json"
      };
}
