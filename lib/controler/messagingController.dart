import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plantetazone/controler/userConnection.dart';
import 'package:plantetazone/models/channelModel.dart';
import 'package:plantetazone/models/messageModel.dart';
import 'package:plantetazone/models/postModel.dart';
import 'package:plantetazone/models/userModel.dart';

class MessagingController{
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  UserConnection userConnection = UserConnection();
  FirebaseStorage fireStorage = FirebaseStorage.instance;

  // TODO: To complete
  Stream<List<ChannelModel>> getUserChannels ()  async *{
    UserModel currentUser = await userConnection.UserConnected;
    
    yield* fireStore.collection('channels')
      
      .where('channelUsersId', arrayContainsAny: [currentUser.getUid])
      .orderBy("channelLastActivity", descending: true)
      .snapshots()
      .map(
      (event) { 
        
        return event.docs.map((e) {
          
          return docToChannelModel(e);
        }).toList();
      }
    );
  }
  /*
  *create a new channel between the sender (current user) and the receiver which is the creator of the post
  */
  Future<ChannelModel> newChannel(PostModel post) async {
    //new channel model
    ChannelModel newChannel = ChannelModel();
    UserModel currentUser = await userConnection.UserConnected;
    newChannel.setChannelSellerId = post.getPostUserId;
    newChannel.setChannelPostId = post.getPostId;
    newChannel.setChannelBuyerId = currentUser.getUid;
    //create a new document for the new channel (auto generated uid)
    DocumentReference ref = fireStore.collection('channels').doc();
    newChannel.setChannelId = ref.id;
    newChannel.setLastAvtivityNow();
    //add the element to the new doc
    ref.set(newChannel.toObject());
    //create the new messages collection (empty collection) with a new first message
    MessageModel message = MessageModel();
    message.setMessageSenderId = currentUser.getUid;
    message.setMessageType = "first";
    message.setMessageValue = "";
    ref.collection('messages').doc(DateTime.now().millisecondsSinceEpoch.toString()).set(message.toObject());
    return newChannel;
  }

  Future<void> sendMessage(MessageModel message, ChannelModel channel) async {
    //get the current user
    UserModel currentUser = await userConnection.UserConnected;
    //define the current user as the sender 
    message.setMessageSenderId = currentUser.getUid;
    //get the right channel from firebase
    DocumentReference ref = fireStore.collection('channels').doc(channel.getChannelId);
    //create a new massage with the now timestamp
    DocumentReference messagesRef =  ref.collection('messages').doc(DateTime.now().millisecondsSinceEpoch.toString());
    //update last activity
    channel.setLastAvtivityNow();
    //update channel
    ref.update(channel.toObject());
    messagesRef.set(message.toObject());
  }

  MessageModel docToMessageModel(DocumentSnapshot doc) {
    MessageModel message = MessageModel();
    message.setMessageTime = DateTime.fromMillisecondsSinceEpoch(int.parse(doc.id));
    message.setMessageSenderId = doc.get("messageSenderId");
    message.setMessageType = doc.get("messageType");
    message.setMessageValue = doc.get("messageValue");
    
    return message;
  }
  ChannelModel docToChannelModel(DocumentSnapshot doc) {
    ChannelModel channel = ChannelModel();
    channel.setChannelBuyerId =  doc.get('channelUsersId')[0];
    channel.setChannelId = doc.id;
    channel.setChannelSellerId = doc.get('channelUsersId')[1];
    channel.setChannelPostId = doc.get('channelPostId');
    channel.setChannelLastActivity = doc.get('channelLastActivity');
    return channel;
  }

  Stream<List<MessageModel>> getMessages(ChannelModel channel, int limit) {
    return fireStore.collection('channels/${channel.getChannelId}/messages').limit(limit).snapshots().map(
      (event) { 
        return event.docs.map((e){
         return docToMessageModel(e);
        }).toList();
      }
    );
  }

  
  
}