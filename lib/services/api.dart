

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


String id,vname;
const baseUrl = "http://localhost:5000/api";

class Api {
  static Future<bool> signIn(String name, String address, String phone,
      String purpose, String who) async {
        bool b;
    try {
      var url = "https://secret-savannah-28994.herokuapp.com/api/visitors";
      
      final res = await Dio().post(
        url,
        data: {
          "name": name,
          "address": address,
          "phone": phone,
          "purpose": purpose,
          "who": who
        },
        options: Options(
          headers: {"Content-type": "application/json; charset=utf-8"},
        ),
      );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('id', res.data['_id']);
          prefs.setString('name', res.data['_id']);
     
      print("Res ${res.data}");
      if (res.statusCode == 200) {
        print(res.statusCode.toString());
        b = true;
      } else {
        b = false;
        throw new Exception('Something failed');
      }
     return b;
    } catch (ex) {
      print(ex);
    }
     return b;
    
  }

    static Future getUsers() async {
    // var url;
    var client = http.Client();
    try {
       var url = "https://secret-savannah-28994.herokuapp.com/api/users";
      return client.get(Uri.encodeFull(url)).whenComplete(client.close);
     
    } catch (ex) {
      print(ex);
    }
  }

 static Future getVisitor() async {
    // var url;
    var client = http.Client();
    try {
       var url = "https://secret-savannah-28994.herokuapp.com/api/visitors";
      return client.get(Uri.encodeFull(url)).whenComplete(client.close);
     
    } catch (ex) {
      print(ex);
    }
  }

  static Future<bool>signOut() async{
    String visitorId,visitorName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    visitorId = prefs.getString('id');
    visitorName =prefs.getString('name');
    bool b;
     try{
        var url = "https://secret-savannah-28994.herokuapp.com/api/signout";
      
      final res = await Dio().post(
        url,
        data: {
          "visitorId": visitorId,
          "visitorName": visitorName
        },
        options: Options(
          headers: {"Content-type": "application/json; charset=utf-8"},
        ),
      );

        print("Res ${res.data}");
      if (res.statusCode == 200) {
        print(res.statusCode.toString());
        b = true;
      } else {
        b = false;
        throw new Exception('Something failed');
      }
      
     }catch (ex){
       print(ex);
     }
     return b;
  }
}
