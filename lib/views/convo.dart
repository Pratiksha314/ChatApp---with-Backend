import 'package:chatsapp/helper/constant.dart';
import 'package:chatsapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Conversation extends StatefulWidget {
  final String chatRoomId;
  Conversation({this.chatRoomId});
  static const routeName = '/convo';
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  DatabaseMethods dbm = DatabaseMethods();
  TextEditingController msgC = TextEditingController();
  Stream<QuerySnapshot> chatmsg;

  Widget chatMessageList() {
    return StreamBuilder(
        stream: chatmsg,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                     message: snapshot.data.documents[index].data["message"],
                   sendByMe:  Constants.myName == snapshot.data.documents[index].data["sendBy"],
                          
                    );
                  }): Container();
              
        });
  }

  sendMessage() {
    if (msgC.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": msgC.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      dbm.addConversationMessages(widget.chatRoomId, messageMap);
      setState(() {
        msgC.text = "";
      });
    }
  }

  @override
  void initState() {
    dbm.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatmsg = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 60, 94, 0.61),
      body: Container(
        child: Stack(
          children: <Widget>[
            chatMessageList(),
            Container(
               width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: msgC,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type a Message",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ),
                    IconButton(icon:Icon(Icons.send,color:Colors.white,),onPressed:() {sendMessage();} ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  MessageTile({@required this.message, @required this.sendByMe});
  @override
    Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 4,
          left: sendByMe ? 0 : 10,
          right: sendByMe ? 10 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 12, bottom: 12, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
        topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ] : [
                const Color(0x1AFFFFFF),
                const Color(0x1AFFFFFF)
              ],
            )
        ),
        child: Text( message,
            textAlign: TextAlign.start,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'OverpassRegular',
            fontWeight: FontWeight.w300),),
      ),
    );
  }
}
