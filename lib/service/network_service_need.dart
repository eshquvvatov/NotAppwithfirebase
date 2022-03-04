import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart';

import '../model/pinterist_model.dart';
class NetworkServiceNedd{
  static const String BASE_URL = "api.unsplash.com";

  // api
  static String  API_POST_LIST="/photos";
  static String API_POST_SEARCH_LIST="/search/photos";

  static Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8',
    "Authorization":"Client-ID Cd0naz9iDvm4jKx7pIh9N0MjRHcQ0P85JV1wvjR93FM",

  };

  /// api bu server apisi filePaht bu biz jo'natmoqchi bo'lgan file yo'li parms da biz parametrlarni beramiz
static Future<String?>MULTIPART(String api,String filePath,Map<String,String>parms)async{
  var uri = Uri.https(BASE_URL, api);

  var request = MultipartRequest("POST",uri);
  request.headers.addAll(headers);
  request.fields.addAll(parms);
  request.files.add(await MultipartFile.fromPath("picture", filePath));

  var res = await request.send();
  return res.reasonPhrase;
}

  ///function
  static Future<String?>GET(api,Map<String,String>params)async{
    var url=Uri.https(BASE_URL, api, params);
    var response= await get(url,headers:headers);
    if(response.statusCode==200){
      return response.body;
    }
    return null;
  }

// params
  static Map<String,String>ImptyParams(){
    Map <String, String>params={};
    return params;
  }
  static Map<String,String>LoadMoreParams(int pageNumber){
    Map <String, String>params={};
    params.addAll({
      "page":pageNumber.toString(),
      "per_page":"10"
    });
    return params;
  }

  static Map<String, String> paramsSearch(String search, int pageNumber) {
    Map<String, String> params = {};
    params.addAll({
      "page":pageNumber.toString(),
      "query":search
    });
    return params;
  }
  // parsing
  static PainterisOblectList parseUserList(String body) {
    List json = jsonDecode(body);
    PainterisOblectList list = PainterisOblectList.fromJson(json);
    return list;
  }
  static PainterisOblectList parseSearchPost(String body) {
    Map<String, dynamic> json =jsonDecode(body);
    PainterisOblectList list = PainterisOblectList.fromJson(json["results"]);
    return list;
  }

}