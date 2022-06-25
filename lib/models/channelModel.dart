import 'package:plantetazone/controler/userConnection.dart';
import 'package:plantetazone/models/userModel.dart';

class ChannelModel {
  String? channelId;
  String? channelPostId;
  String? channelBuyerId;
  String? channelSellerId;
  int? channelLastActivity;
  

  ChannelModel() : super();

  get getChannelId {
    return channelId;
  }
  get getChannelPostId {
    return channelPostId;
  }
  get getChannelBuyerId {
    return channelBuyerId;
  }
  get getChannelSellerId{
    return channelSellerId;
  }
  get getChannelLastActivity{
    return channelLastActivity;
  }
  Future<String> get getChannelContactUesrId async {
    UserConnection userConnection = UserConnection();
    UserModel currentUser = await userConnection.UserConnected;
    if (currentUser.getUid == channelBuyerId ){
      return channelSellerId??"";
    }else {
      return channelBuyerId??"";
    }
  }


  set setChannelId(value) {
    channelId = value;
  }
  set setChannelPostId(value) {
    channelPostId = value;
  }
  set setChannelBuyerId(value) {
    channelBuyerId = value;
  }
  set setChannelSellerId(value) {
    channelSellerId = value;
  }
  set setChannelLastActivity(value) {
    channelLastActivity = value;
  }
  void setLastAvtivityNow() {
    channelLastActivity = DateTime.now().millisecondsSinceEpoch;
  }
   
  Map<String, dynamic> toObject() {
    return {
      "channelId" : channelId,
      "channelPostId" : channelPostId,
      "channelUsersId" : [channelBuyerId,channelSellerId],
      "channelLastActivity":channelLastActivity,
    };
  }
}