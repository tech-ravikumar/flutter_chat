import 'dart:async';

import 'package:chat/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../bloc/chat_bloc.dart';
import '../../data/model/chat.dart';
import '../../data/repository/chat_repo.dart';
import '../../utils/message_handler.dart';
import '../../widget/text.dart';

class ChatPage extends StatefulWidget {
  final User? user;
  const ChatPage(this.user, {Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatBloc chatBloc;
  bool keyboardVisible=false;
  late Timer _timer;

  @override
  void initState() {
    chatBloc = ChatBloc(context.read<ChatRepository>());
    super.initState();
    chatBloc.msgController?.stream.listen((event) {
      AppMessageHandler().showSnackBar(context, event);
    });
     _timer = Timer.periodic(Duration(seconds: 3), (timer) {
       print("object");
     chatBloc.refreshChat(widget.user!.id.toString());
     });
    chatBloc.fetchChats(widget.user!.id.toString());
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        leadingWidth:20,
        title:
        Row(
         children: [
           ClipRRect(
             borderRadius: const BorderRadius.all(Radius.circular(100)),
             child: FadeInImage.assetNetwork(
               image: "http://192.168.1.19:8000/${widget.user?.image}"??"",
               height: 40,
               width: 40,
               fit: BoxFit.cover,
               placeholder: "assets/images/loading_shimmer.gif",
               imageErrorBuilder: (context, error, stack) => Image.asset(
                 "assets/images/image_not_found.png",
                 height: 40,
                 fit: BoxFit.cover,
                 width: 40,
               ),
             ),
           ),
           const SizedBox(width: 5,),
           Expanded(
             child: Text(
               widget.user?.name??"",
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 20,
                 fontFamily: "outfit2",
               ),),
           ),
         ],
        ),
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: chatBloc.isLoading,
              builder: (context,bool loading,__){
                if(loading){
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return ValueListenableBuilder(
                    valueListenable: chatBloc.userChat,
                    builder: (context,List<Chat?>chat,__){
                      if(chat.length==0){
                        return Expanded(
                          child: const Center(
                            child: Text(
                              "No data found",
                            ),
                          ),
                        );
                      }
                      // if(chat.length==0){
                      //   return const Spacer();
                      // }
                      return Expanded(
                          flex: keyboardVisible?10:16,
                          child: ListView.builder(
                            itemCount: chat.length,
                              reverse: true,
                              itemBuilder: (context,index){
                                return Column(
                                  children: [
                                    Container(
                                      // width: 1.sw,
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                                        child: chat[index]?.toUser==widget.user?.id?
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            IntrinsicWidth(
                                              child: Container(
                                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.70),
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          spreadRadius: 1,
                                                          blurRadius: 3,
                                                          color: Colors.black.withOpacity(0.1),
                                                          offset: const Offset(1,2)
                                                      )
                                                    ]
                                                ),
                                                child: TextWidget(content: "${chat[index]?.message}",size: 12,color: const Color(0xff000000),weight: FontWeight.w400,),
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ):
                                        Row(mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            const Spacer(),
                                            IntrinsicWidth(
                                              child: Container(
                                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.70),
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          spreadRadius: 1,
                                                          blurRadius: 3,
                                                          color: Colors.black.withOpacity(0.1),
                                                          offset: const Offset(1,2)
                                                      )
                                                    ]
                                                ),
                                                child: TextWidget(content: "${chat[index]?.message}",size: 12,color: Color(0xffffffff),weight: FontWeight.w400,),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ],
                                );
                              }
                          )
                      );
                    }
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.2),
                    )
                  ]),
              padding: const EdgeInsets.only(
                  bottom: 10, top: 10, left: 10, right: 10),
              child: Row(
                children: [
                  const Icon(PhosphorIcons.link),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: chatBloc.sendMessage,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add a comment",
                      ),
                      onFieldSubmitted: (value) {
                        chatBloc.sendMessage.text=value;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(onTap: () {
                    chatBloc.sendChats(widget.user!.id.toString(), "text");
                    chatBloc.sendMessage.clear();
                  },
                      child: const Icon(PhosphorIcons.paper_plane_tilt)),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
