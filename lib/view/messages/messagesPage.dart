import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:plantetazone/components/channelBloc.dart';
import 'package:plantetazone/controler/messagingController.dart';
import 'package:plantetazone/models/channelModel.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  MessagingController _messagingController = MessagingController();
  List<ChannelModel> _channels = [];

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("called!");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messagingController.getUserChannels().listen((event) {
      if (mounted) {
        setState(() {
          print(_channels);
          _channels = [];
        });

        setState(() {
          print(_channels);
          _channels = event;
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    

    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: _channels.length,
                itemBuilder: (context, index) {
                  print(_channels[index].channelPostId);
                  return Column(
                    children: [
                      //Text(_channels[index].getChannelPostId),
                      ChannelBloc(
                        channel: _channels[index],
                      ),
                    ],
                  );
                })),
      ],
    );
  }
}
