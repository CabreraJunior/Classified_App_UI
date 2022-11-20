import 'dart:convert';
import '../utilities/alert.dart';
import '../utilities/constants.dart';
import "package:http/http.dart" as http;
import "package:http/http.dart";

class AdService {
  Future fetchAds(context) async {
    Uri url = Uri.https(Constants().server, Constants().endpointAds);
    var modelObj = {};
    try {
      Response response = await http.get(url);

      modelObj = jsonDecode(response.body);

      if (modelObj["status"] == true) {
        AlertManager().displaySnackBar(context, "Ads Loaded");
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
