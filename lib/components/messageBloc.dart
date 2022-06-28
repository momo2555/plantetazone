import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plantetazone/controler/messagingController.dart';
import 'package:plantetazone/models/messageModel.dart';
import 'package:plantetazone/models/userProfileModel.dart';

enum MessageBlocType { RECEIVER, SENDER }

class MessageBloc extends StatefulWidget {
  const MessageBloc({
    Key? key,
    required this.message,
    this.user,
  }) : super(key: key);
  final MessageModel message;
  final UserProfileModel? user;
  @override
  State<MessageBloc> createState() => _MessageBlocState();
}

class _MessageBlocState extends State<MessageBloc> {
  MessagingController _messagingController = MessagingController();
  Widget _receiverBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 25),

        //maxWidth: 100,
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 210, 210, 210),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(12),
              child: _contentBuild(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _senderBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 20,
          backgroundImage: widget.user != null
              ? NetworkImage(widget.user?.getUserProfileImageURL)
              : null,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Theme.of(context).primaryColorDark, width: 1)),
              padding: EdgeInsets.all(12),
              child: _contentBuild(),
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
      ],
    );
  }

  Widget _contentBuild() {
    String type = widget.message.getMessageType;
    if (type == 'text') {
      //simple text message
      return Text(widget.message.getMessageValue);
    } else if (type == "image") {
      //image message
      return FutureBuilder<MessageModel>(
          future: _messagingController.downloadImage(widget.message),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return Image(
                image: FileImage(snapshot.data!.getMessageFileImage),
              );
            else
              return Container();
          });
    } else {
      //nothing
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    //return Row()
    if (widget.message.getMessageSenderId == widget.user?.getUid) {
      return _senderBuild();
    } else {
      return _receiverBuild();
    }
  }
}
