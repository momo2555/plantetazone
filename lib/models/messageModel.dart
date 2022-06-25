class MessageModel {
  DateTime? messageTime;
  String? messageType;
  String? messageValue;
  String? messageSenderId;
  String? messageReceiverId;
  MessageModel():super();

  get getMessageTime {
    return messageTime;
  }
  get getMessageType {
    return messageType;
  }
  get getMessageValue {
    return messageValue;
  }
  get getMessageSenderId {
    return messageSenderId;
  }
  get getMessageReceiverId {
    return messageReceiverId;
  }


  set setMessageTime (value) {
     messageTime = value;
  }
  set setMessageType(value) {
     messageType = value;
  }
  set setMessageValue(value) {
     messageValue = value;
  }
  set setMessageSenderId (value){
     messageSenderId = value;
  }
  set setMessageReceiverId (value){
     messageReceiverId = value;
  }

  Map<String, dynamic> toObject()  {
    return {
      "messageType":messageType,
      "messageValue":messageValue,
      "messageSenderId":messageSenderId,
    };
  }
}