import 'package:chattingapp/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../pages/chatPage.dart';

class groupStyle extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;

  const groupStyle(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<groupStyle> createState() => _groupStyleState();
}

class _groupStyleState extends State<groupStyle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        nextScreen(context, ChatPage(
          groupId: widget.groupId,
          groupName: widget.groupName ,
          userName: widget.userName,
        ));
      },
      child:Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            widget.groupName.substring(0, 1).toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        title: Text(widget.groupName,
          style:TextStyle(fontWeight: FontWeight.w500),),
        subtitle: Text("Join the Conversation as ${widget.userName}",style: TextStyle(fontSize: 13),),

      ),
    ));
  }
}
