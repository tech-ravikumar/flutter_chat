
import 'package:chat/data/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/chat.dart';
import '../data/repository/chat_repo.dart';
import '../utils/message_handler.dart';
import 'bloc.dart';

class ChatBloc extends Bloc {
  final ChatRepository chatRepository;
  ChatBloc(this.chatRepository);

  ValueNotifier<List<User>> userLists = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  
  Future userList() async {
    try {
      isLoading.value = true;
      SharedPreferences pref = await SharedPreferences.getInstance();
      var res = await chatRepository.userList();
      if(res!=null){
        // userLists.value = [];
        // for(int i =0;i<res.length;i++){
        //   if(res[i].id == pref.getString('uid')){
        //     print("not");
        //   }
        //   else{
        //     print(res[i]);
        //     userLists.value.add(res[i]);
        //   }
        // }
        userLists.value = [];
        userLists.value.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      isLoading.value = false;
    }
  }


  refreshChat(String senderId) async {
    try{
      // isLoading.value = true;
      var res=await chatRepository.fetchChats(senderId);
      if(res!=null){
        userChat.value = [];
        userChat.value.addAll(res);
      }

    }catch(e,s){
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      // showMessage(MessageType.error('$e'));
    }/*finally{
      isLoading.value = false;
    }*/
  }

  ValueNotifier<List<Chat>> userChat = ValueNotifier([]);
  Future fetchChats(String senderId) async{
    try{
      isLoading.value = true;
      var res=await chatRepository.fetchChats(senderId);
      if(res!=null){
        userChat.value = [];
        userChat.value.addAll(res);
      }
      
    }catch(e,s){
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      // showMessage(MessageType.error('$e'));
    }finally{
      isLoading.value = false;
    }
    
  }

  ValueNotifier<List<Chat>> sendChat = ValueNotifier([]);
  TextEditingController sendMessage=TextEditingController();
  Future sendChats(String senderId,String type) async{
    try{
      // isLoading.value = true;
      var res=await chatRepository.sendChat(sendMessage.text,senderId,type);
      print(res);
    }catch(e,s){
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      // isLoading.value = false;
    }

  }

}