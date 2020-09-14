import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

// fetching the details of user while searching
  getUserByName(String userName) async {
 return await Firestore.instance.collection("users").where
  ("name",isEqualTo : userName).getDocuments();
  }

getUserByEmail(String userEmail) async {
 return await Firestore.instance.collection("users").where
  ("email",isEqualTo : userEmail).getDocuments();
  }
// adding details in database while signup
  uploadUserInfo(userMap){
    Firestore.instance.collection("users").add(userMap).catchError((e){
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId,dynamic chatRoomMap){
  Firestore.instance.collection("ChatRoom")
  .document(chatRoomId).setData(chatRoomMap).catchError((e){
    print(e.toString());
  });
}

addConversationMessages(String chatRoomId, dynamic messageMap){
 Firestore.instance.collection("ChatRoom")
.document(chatRoomId).collection("chats").add(messageMap).catchError((e){
    print(e.toString());
  });
}
getConversationMessages(String chatRoomId) async {
return await Firestore.instance.collection("ChatRoom")
.document(chatRoomId).collection("chats").orderBy(
  "time",descending: false).snapshots();
}

getChatRoom(String userName) async {
  return await Firestore.instance.collection("ChatRoom")
  .where("users",arrayContains: userName).snapshots();
}
}