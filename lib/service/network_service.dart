import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:dio/dio.dart';
import '../model/pinterist_model.dart';

class NetworkService {
  static const String BASE_URL = "https://api.unsplash.com";

  // api
  static String API_POST_LIST = "/photos";
  static String API_POST_SEARCH_LIST = "/search/photos";

  static Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8',
    "Authorization": "Client-ID Cd0naz9iDvm4jKx7pIh9N0MjRHcQ0P85JV1wvjR93FM",
    "Accept_Version": "v1"
  };

  static Future<String?> GET(api, Map<String, String> params) async {
    /// Dio da malumotlar object ko'rinishida keladi uni o'zimizga qarab stringga o'tkazishimiz mumkun
    var response = await Dio(BaseOptions(
      baseUrl: BASE_URL,
      headers: headers,
    )).get(api, queryParameters: params);
    print(response);
    print(
        "===============================================================================================================");
    print(response.statusCode);
    if (response.statusCode == 200)

      /// reponse object yani map shaklida keladi va bizga string ko'rishi kerak
      return jsonEncode(response.data);
    return null;
  }

  //
  //
  // ///function
  // static Future<String?>GET(api,Map<String,String>params)async{
  //   var url=Uri.https(BASE_URL, api, params);
  //   var response= await get(url,headers:headers);
  //   if(response.statusCode==200){
  //     return response.body;
  //   }
  //   return null;
  // }

// params
  static Map<String, String> ImptyParams() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> LoadMoreParams(int pageNumber) {
    Map<String, String> params = {};
    params.addAll({"page": pageNumber.toString(), "per_page": "10"});
    return params;
  }

  static Map<String, String> paramsSearch(String search, int pageNumber) {
    Map<String, String> params = {};
    params.addAll({"page": pageNumber.toString(), "query": search});
    return params;
  }

  // parsing
  static PainterisOblectList parseUserList(String body) {
    List json = jsonDecode(body);
    PainterisOblectList list = PainterisOblectList.fromJson(json);
    return list;
  }

  static PainterisOblectList parseSearchPost(String body) {
    Map<String, dynamic> json = jsonDecode(body);
    PainterisOblectList list = PainterisOblectList.fromJson(json["results"]);
    return list;
  }
}
