import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantetazone/components/messageBloc.dart';
import 'package:plantetazone/components/simpleInput.dart';
import 'package:plantetazone/controler/messagingController.dart';
import 'package:plantetazone/controler/profilController.dart';
import 'package:plantetazone/models/channelModel.dart';
import 'package:plantetazone/models/messageModel.dart';
import 'package:plantetazone/models/userProfileModel.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({
    Key? key,
    required this.channel,
  }) : super(key: key);
  final ChannelModel channel;
  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  ProfileController _profileController = ProfileController();
  MessagingController _messagingController = MessagingController();
  final ScrollController _listScrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  UserProfileModel? _userProfile;
  int _messagesLimit = 20;
  static const int PAGINATION_INCREMENT = 20;
  String _message = "";

  void _scrollListener() {
    if (_listScrollController.offset >=
            _listScrollController.position.maxScrollExtent &&
        !_listScrollController.position.outOfRange) {
      setState(() {
        _messagesLimit += PAGINATION_INCREMENT;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ------ ---- ------ get seller user
    _profileController
        .getUserProfileById(widget.channel.getChannelSellerId)
        .then((value) {
      setState(() {
        _userProfile = value;
      });
    });
    // --------- ------- init pagination
    _listScrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          //the user name of the seller
          title: Text(_userProfile != null ? _userProfile?.getUserName : ''),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Theme.of(context).primaryColor),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),

              //profile image of the seller
              child: CircleAvatar(
                backgroundColor: Theme.of(context).backgroundColor,
                radius: 20,
                backgroundImage: _userProfile != null
                    ? NetworkImage(_userProfile?.getUserProfileImageURL)
                    : null,
              ),
            )
          ],
        ), //name + photo
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).backgroundColor,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(children: [
              InkWell(
                child: Icon(Icons.photo,
                    color: Theme.of(context).primaryColor, size: 34),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: SimpleInput(
                    placeholder: 'Message ...',
                    type: 'text',
                    onChange: (value) {
                      _message = value;
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  MessageModel message = MessageModel();
                  message.setMessageType = 'text';
                  message.setMessageValue = _message;
                  _messagingController.sendMessage(message, widget.channel);
                },
                child: Icon(Icons.send,
                    color: Theme.of(context).primaryColorDark, size: 34),
              ),
            ]),
          ),
        ),
        body: Container(
            child: Column(
          children: [
            Row(
              children: [
                //data of the post
              ],
            ),
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                  stream: _messagingController.getMessages(
                      widget.channel, _messagesLimit),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && _userProfile != null) {
                      List<MessageBloc> messages = [];
                      snapshot.data!.removeAt(0);
                      messages = snapshot.data!.map((e) {
                        //create the correcte messagebloc
                        if (e.getMessageSenderId == _userProfile!.getUid) {
                          return MessageBloc.sender(
                            content: Text(e.getMessageValue),
                          );
                        } else {
                          return MessageBloc.receiver(
                            content: Text(e.getMessageValue),
                          );
                        }
                      }).toList();
                      return ListView(
                        controller: _listScrollController,
                        reverse: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: messages,
                            ),
                          )
                        ],
                      );
                    } else
                      return Container();
                  }),
            )
          ],
        )));
  }
}
