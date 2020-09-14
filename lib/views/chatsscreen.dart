import 'package:chatsapp/helper/authenticate.dart';
import 'package:chatsapp/helper/constant.dart';
import 'package:chatsapp/helper/sharedFunction.dart';
import 'package:chatsapp/services/auth.dart';
import 'package:chatsapp/services/database.dart';
import 'package:chatsapp/views/convo.dart';
import 'package:chatsapp/widgets/styles.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  static const routeName = '/chatRoom' ;
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
DatabaseMethods dbm = DatabaseMethods();
Stream chatRooms ;
Widget chatRoomList(){
  return StreamBuilder
  (
    stream: chatRooms,
    builder: (context,snapshot){
      return snapshot.hasData ? ListView.builder(
        itemCount: snapshot.data.documents.length,      
        itemBuilder: (context,index){
       return ChatRoomTile(
         snapshot.data.documents[index].data["chatroomId"]
         .toString().replaceAll("_", "").replaceAll(Constants.myName,
          ""),
          snapshot.data.documents[index].data["chatroomId"]
          );
      }) : Container();
    }
  );
}

@override
void initState() { 
  getUserInfo();
  super.initState();  
}

getUserInfo() async {
  Constants.myName = await SharedFunctions.getUserNameSP();
  dbm.getChatRoom(Constants.myName).then((snapshots){
setState(() {
  chatRooms = snapshots;
});
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 60, 94, 0.61),
        title:Image.asset("assets/images/logo.png",height: 50),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(icon: Icon(Icons.exit_to_app,color: Colors.white,),
             onPressed: (){
               Auth auth = Auth();
               auth.signout();
               Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>Authenticate()));
             }, 
            ),
          ),
        ],
      ),
      body: chatRoomList(),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Color.fromRGBO(41, 60, 94, 0.61),
      onPressed: (){
        Auth auth = Auth();
        auth.signout();
      Navigator.pushNamed(context, '/search')  ;
      },
      child: Icon(Icons.search),),
    );
  }
}
class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoom;
  ChatRoomTile(this.userName,this.chatRoom);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
        Conversation(chatRoomId:chatRoom,)));
      },
          child: Container(
            color: Colors.black87,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Row(
          children: <Widget>[
            Container(
              height: 40, width: 40,
              alignment:  Alignment.center,
              child: Text("${userName.substring(0,1).toUpperCase()}",
              style: styleText()),
             decoration: BoxDecoration(
            color:Color.fromRGBO(41, 60, 94, 2),
            borderRadius: BorderRadius.circular(40),
             ), 
           ),
            SizedBox(width: 8,),
            Text(userName,style: styleText(),),
          ],
        )
      ),
    );
  }
} 