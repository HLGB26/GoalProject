import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods{

  getUsersByUsername(String username) async{
   return await Firestore.instance.collection('users')
         .where('name', isEqualTo: username)
         .getDocuments();
  }

  getUsersByEmail(String email) async{
    return await Firestore.instance.collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
  }

  uploadUserInfo(userMap){
    Firestore.instance.collection("users")
        .add(userMap).catchError((e){
          print(e);
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap ){
    Firestore.instance.collection("chatRoom")
        .document(chatRoomId).
      setData(chatRoomMap).catchError((e) {
        print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap){
     Firestore.instance.collection("chatRoom").document(chatRoomId)
         .collection("chats")
         .add(messageMap).catchError((e) {print(e.toString()); });
  }

  getConversationMessages(String chatRoomId) async {
    return await Firestore.instance.collection("chatRoom").document(chatRoomId)
                .collection("chats")
                .orderBy("time", descending: true)
                .snapshots();
  }

  getChatRooms(String userName) async{
    return await Firestore.instance.collection("chatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }

}