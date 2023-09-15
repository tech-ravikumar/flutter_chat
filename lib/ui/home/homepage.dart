import 'package:chat/bloc/chat_bloc.dart';
import 'package:chat/data/repository/chat_repo.dart';
import 'package:chat/ui/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/user.dart';
import '../../utils/message_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ChatBloc chatBloc;

  @override
  void initState() {
    chatBloc = ChatBloc(context.read<ChatRepository>());
    super.initState();
    chatBloc.msgController?.stream.listen((event) {
      AppMessageHandler().showSnackBar(context, event);
    });
    chatBloc.userList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text(
          "Users List"
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: chatBloc.isLoading,
        builder: (context, bool loading,__) {
          if(loading){
            return Center(
              child: const CircularProgressIndicator(),
            );
          }
          return ValueListenableBuilder(
            valueListenable:chatBloc.userLists,
            builder: (context, List<User?>user,__) {
              if(user== null){
                return const Center(
                  child: Text("No data Found"),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        shrinkWrap: true,
                        itemCount: user.length,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(user[index])));
                            },
                            child: Container(
                              // padding:const EdgeInsets.symmetric(horizontal: 10),
                              margin: const EdgeInsets.only(top: 20,bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                                    child: FadeInImage.assetNetwork(
                                      image: "http://192.168.1.19:8000/${user[index]?.image}"??"",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      placeholder: "assets/images/loading_shimmer.gif",
                                      imageErrorBuilder: (context, error, stack) => Image.asset(
                                        "assets/images/image_not_found.png",
                                        height: 50,
                                        fit: BoxFit.cover,
                                        width: 50,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                   Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                user[index]?.name??"",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: "outfit2",
                                                ),),
                                            ),
                                            Text(
                                              "9.32 AM",
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.black45,
                                                fontFamily: "outfit2",
                                              ),),
                                          ],
                                        ),
                                        SizedBox(height: 2,),
                                        Text(
                                          "Neque Porro Quisquam Est Qui Dolorem Lpsam Quia Dolor Sit Amet, Consectetur, Adipi",
                                          maxLines:2,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black45,
                                            fontFamily: "outfit2",
                                          ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  )
                ],
              );
            }
          );
        }
      ),
    );
  }
}
