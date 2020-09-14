import 'package:chatsapp/helper/constant.dart';
import 'package:chatsapp/services/database.dart';
import 'package:chatsapp/views/convo.dart';
import 'package:chatsapp/widgets/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchC = TextEditingController();
  DatabaseMethods dbm = DatabaseMethods();
  QuerySnapshot searchSnapshot;

  initiateSearch() {
    dbm.getUserByName(searchC.text).then((val) {
      setState(() {//setState main isliye hai kyuki initally koi value nahi hogi
        searchSnapshot = val;
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null ?
    ListView.builder(
        itemCount: searchSnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SearchTile(
              userName: searchSnapshot.documents[index].data['name'],
              userEmail: searchSnapshot.documents[index].data['email']);
        }) : Container() ;
  }

  createChatConvo(String userName){
    print('${Constants.myName}');
    if(userName != Constants.myName){
       String chatroomId = getChatRoomId(userName, Constants.myName);
    List<String> users =[userName, Constants.myName ];
    Map<String,dynamic> chatRoomMap = {
   "users": users,
   "chatroomId": chatroomId,
    };
  dbm.createChatRoom(chatroomId,chatRoomMap);
  Navigator.push(context, MaterialPageRoute(
    builder: (context)=> Conversation(chatRoomId: chatroomId,
      )));
    }
  else print("Can't send msg to yourself");
  }

 Widget SearchTile({String userName,String userEmail}){
  return Container(
      padding: EdgeInsets.symmetric(horizontal:8,vertical:16),
        child: Row(    
      children: <Widget>[
        Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(userName, style: textFieldStyle()),
            Text( userEmail,style: textFieldStyle(),),
          ],
        ),
        Spacer(),
    IconButton(icon:Icon(Icons.message),color:Colors.white, onPressed:(){createChatConvo(userName);} ),
      ],
    ));
  }
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromRGBO(41, 60, 94, 0.61),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: searchC,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Username",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ),
                   IconButton(icon: Icon(Icons.search,color: Colors.grey[300],), onPressed: (){initiateSearch();}),
                  ],
                ),
              ),
              searchList(),
            ],
          ),
        ),
      ),
    );
  }
}

// jab search karenge naam to result main yeh aayega


getChatRoomId( String a, String b ){
  if( a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }
  return "$a\_$b";
}