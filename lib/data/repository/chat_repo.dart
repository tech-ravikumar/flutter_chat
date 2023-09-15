
import 'dart:convert';

import 'package:chat/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/chat.dart';
import '../network/api_exception.dart';
import '../network/api_service.dart';

class ChatRepository{
  final SharedPreferences prefs;
  final ApiService _api;
  ChatRepository(this.prefs, this._api);

  Future<List<User>> userList() async {
    var res = await _api.getRequest("fetchAllUsers");
    // print("object ${res['data']}");
    // var resData = jsonDecode(res['data']);
    return List.from(res['data'].map((e) => User.fromJson(e)));
  }

  Future<List<Chat>> fetchChats(String senderId) async{
    Map<String,dynamic>
    res= await _api.postRequest("chats/fetch_chats", {
      "sender_id":senderId,
      "user_id": "${prefs.getString("uid")}"
    });
    if(res==null){
      throw ApiException.fromString("response null");
    }
    // List<dynamic> list2 = (res['data']??[]);
    // print("fetch_chats $res");
    // List<Chat> resp = list2.map<Chat>((item)=>Chat.fromJson(item)).toList();
    return List.from(res['data'].map((e) => Chat.fromJson(e)));
  }

  Future<Chat> sendChat(String message,String senderId,String type) async{
    Map<String,dynamic> map={
      "sender_id":senderId,
      "user_id":prefs.getString("uid"),
      "type":type,
      "message":message
    };
    var res= await _api.postRequest("chats/send_chat", map);

    if(res==null){
      throw ApiException.fromString("response null");
    }
    print("sendChat $res");
    return Chat.fromJson(res['data']);
  }

}