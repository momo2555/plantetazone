import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantetazone/controler/postController.dart';
import 'package:plantetazone/controler/profilController.dart';
import 'package:plantetazone/models/channelModel.dart';
import 'package:plantetazone/models/postModel.dart';
import 'package:plantetazone/models/userProfileModel.dart';

class ChannelBloc extends StatefulWidget {
  const ChannelBloc({
    Key? key,
    required this.channel,
  }) : super(key: key);
  final ChannelModel channel;

  @override
  State<ChannelBloc> createState() => _ChannelBlocState();
}

class _ChannelBlocState extends State<ChannelBloc> {
  ProfileController _profileController = ProfileController();
  PostController _postController = PostController();
  UserProfileModel? _contactUser;
  PostModel? _post;

  @override
  void initState() {
    int time = DateTime.now().millisecondsSinceEpoch;
    // TODO: implement initState
    super.initState();
    // ----------------- get User data

    widget.channel.getChannelContactUesrId.then((contactId) {
      _profileController
          .getUserProfileById(contactId)
          .then((userProfile) => setState(() {
                _contactUser = userProfile;
                print(time.toString() + userProfile.getUserName);
              }));
    });

    // ----------------- get the post data
    _postController
        .getPostById(widget.channel.getChannelPostId)
        .then((post) => setState(() {
              _post = post;
            }));
    // ----------------- get last message data
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print('coucou');
  }

  @override
  void didUpdateWidget(covariant ChannelBloc oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('ya it changes');
    // ----------------- get User data

    widget.channel.getChannelContactUesrId.then((contactId) {
      _profileController
          .getUserProfileById(contactId)
          .then((userProfile) => setState(() {
                _contactUser = userProfile;
              }));
    });

    // ----------------- get the post data
    _postController
        .getPostById(widget.channel.getChannelPostId)
        .then((post) => setState(() {
              _post = post;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/channel', arguments: widget.channel);
          /* .then((value) {
            widget.channel.getChannelContactUesrId.then((contactId) {
              _profileController
                  .getUserProfileById(contactId)
                  .then((userProfile) => setState(() {
                        _contactUser = userProfile;
                        
                      }));
            });

            // ----------------- get the post data
            _postController
                .getPostById(widget.channel.getChannelPostId)
                .then((post) => setState(() {
                      _post = post;
                    }));
          });*/
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  image: _post != null
                      ? DecorationImage(
                          //TODO control any possible errors
                          image: FileImage(_post!.getImageFiles!.first),
                          fit: BoxFit.cover)
                      : null,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${_post != null ? _post!.getPostTitle ?? '' : ''} - ${_contactUser != null ? _contactUser!.getUserName ?? '' : ''}"),
                        Text("Bonjour je voudrais avoir des infos ..."),
                      ]),
                ),
              ),
            ],
          ),
        ));
  }
}
