import 'package:flutter/cupertino.dart';
import 'package:plantetazone/components/channelBloc.dart';
import 'package:plantetazone/controler/messagingController.dart';
import 'package:plantetazone/models/channelModel.dart';

class ChannelsListProvider extends ChangeNotifier {
  List<ChannelBloc>? _channels;
  MessagingController _messagingController = MessagingController();
  get getChannels => _channels ?? [];
  void fetchChannels() {
    _messagingController.getUserChannels().listen((event) 
    {
      _channels = event.map((channel) {
        return ChannelBloc(channel: channel);
      }).toList();
      notifyListeners();
      
    });
  }

}