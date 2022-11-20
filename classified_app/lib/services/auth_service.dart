import "dart:convert";
import 'package:classified_app/models/log_model.dart';
import 'package:classified_app/models/reg_model.dart';
import 'package:classified_app/navigation/const_routes.dart';
import 'package:classified_app/utilities/alert.dart';
import 'package:classified_app/utilities/constants.dart';
import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:http/http.dart" as http;
import "package:http/http.dart";

class AuthService {
  Future register(context, RegisterModel model) async {
    Uri url = Uri.https(Constants().server, Constants().endpointRegister);
    Map<String, dynamic> modelObj = model.toJson();
    try {
      Response response =
          await http.post(url, body: jsonEncode(modelObj), headers: {
        "Content-Type": "application/json",
      });
      modelObj = jsonDecode(response.body);
      if (modelObj["status"] == true) {
        AlertManager().displaySnackBar(context, "User successfully created");
        Navigator.pushReplacementNamed(context, homePage);
      }
      if (modelObj["status"] == false) {
        AlertManager().displaySnackBar(context, modelObj["message"]);
      }
      return modelObj;
    } catch (e) {
      print(e);
      return modelObj;
    }
  }

  Future login(context, LoginModel model) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    Uri url = Uri.https(Constants().server, Constants().endpointLogin);
    var modelObj = model.toJson();
    try {
      Response response =
          await http.post(url, body: jsonEncode(modelObj), headers: {
        "Content-Type": "application/json",
      });
      modelObj = jsonDecode(response.body);
      if (modelObj["status"] == true) {
        AlertManager().displaySnackBar(context, modelObj["message"]);
        storage.write(key: "token", value: modelObj["data"]["token"]);
        Navigator.pushReplacementNamed(context, homePage, arguments: {
          "name": modelObj["data"]["user"]["name"],
          "email": modelObj["data"]["user"]["email"],
          "mobile": modelObj["data"]["user"]["mobile"],
          "imgUrl": modelObj["data"]["user"]["imgURL"],
        });
      }
      if (modelObj["status"] == false) {
        AlertManager().displaySnackBar(context, modelObj["message"]);
      }
      return modelObj;
    } catch (e) {
      print(e);
      return modelObj;
    }
  }
}
