import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:plantetazone/components/actionButton.dart';
import 'package:plantetazone/components/simpleInput.dart';
import 'package:plantetazone/controler/messagingController.dart';
import 'package:plantetazone/controler/profilController.dart';
import 'package:plantetazone/models/channelModel.dart';
import 'package:plantetazone/models/messageModel.dart';
import 'package:plantetazone/models/postModel.dart';
import 'package:plantetazone/models/userProfileModel.dart';

class PostPage extends StatefulWidget {
  const PostPage({
    Key? key,
    required this.post,
  }) : super(key: key);
  final PostModel post;
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with TickerProviderStateMixin{
  PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();
  //profile controller (get the profile of the user which post the annonce)
  ProfileController _profileController = ProfileController();
  UserProfileModel? _userProfile;
  double _index = 0; 
  //Color _appBarColor = Colors.transparent;
  bool _isAppBarTransparent = true;
  //animation
  Animation <Color?>? _animation;
  AnimationController? _animationController;
  //send message to the seller control
  String _message = '';
  
  List<Widget> _imagePageViewOrganizer() {
    List<Widget> images = [];
    for(var img in widget.post.getImageFiles??[]) {
      images.add(
        Container(
           
            decoration: BoxDecoration(
              
              image:  DecorationImage(
                image: FileImage(img),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        
      );
    }
    return images;
  }

  /***
   * Image Indexer - create the indexer for the images
   */
  Widget _imageIndexer() {
   
   List<Widget> indexerList = [];
   int i = 0;
  
   for(var img in widget.post.getImageFiles??[]) {
     double indexerSize = 15;
     indexerList.add(
       Padding(
         padding: EdgeInsets.all(4),
         child: Container (
           height: indexerSize,
           width: indexerSize,
           decoration: BoxDecoration(
             //if the index of the image is equal to i -> highlight the circle
             color: _index == i ? Theme.of(context).accentColor : Theme.of(context).backgroundColor,
             borderRadius: BorderRadius.circular(indexerSize/2), 
           ),
         ),
       ),
     );
     i++;
   }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: indexerList,
      ),
    );
  }

  Widget _likesBloc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
          child: Text(widget.post.getPostLikesNum.toString(), 
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 25,
            ),
          ),
        ),
        InkWell(
          
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 8, 10, 8),
              child: Icon(Icons.favorite_outlined, color: Theme.of(context).accentColor, size: 28,),
            )
        )
      ],
    );
  }
  
  @override
  void initState() {
    super.initState();
    
    
    // ------ ------ Page view controller
    _pageController = PageController();
    _pageController.addListener(() {
      if (_pageController.page! % 1 == 0) {
        setState(() {
          _index = _pageController.page??0;
        });
      }
      
    });

    () async {
      //async function to call the context 
      await Future.delayed(Duration.zero);
      Color primary = Theme.of(context).primaryColor;
    
    // ------- ------ scroll anitanimation
      _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
      _animation = ColorTween(begin: Colors.transparent, end: primary).animate(_animationController!)
        ..addListener(() {
          setState(() {
            
          });
        });
   
    }();

    // ------- -------- Scroll controller
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if(_scrollController.offset < 400) {
        //log('transparent');
        if(!_isAppBarTransparent)
        setState(() {
            //_appBarColor = Colors.transparent;
            _animationController!.reverse();
            _isAppBarTransparent = true;
          });
      }else {
        //log('non transparent');
        if(_isAppBarTransparent){
          setState(() {
            //_appBarColor = Theme.of(context).primaryColor;
            _animationController!.forward();
            _isAppBarTransparent = false;
          });
      }
    }
    });

    // ------ -------- ---- get user profile 
    _profileController.getUserProfileById(widget.post.getPostUserId).then((value) {
      setState(() {
        _userProfile = value;
      });
    });
    
  }
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar( 
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.post.getPostPrice.toString() + ' €', 
                style: TextStyle(
                  fontSize: 25,
                  shadows: [Shadow(color: Color.fromARGB(135, 0, 0, 0), blurRadius: 15)]
                ),
              ),
            ],
          ),
        ),
      ],
      
      systemOverlayStyle: SystemUiOverlayStyle(
                // Status bar color
                statusBarColor:Colors.transparent,
          ),
      backgroundColor: _animation!= null?_animation!.value:Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
    ),
    bottomNavigationBar: BottomAppBar(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ActionButton(
                      text: 'Acheter',/* - ${widget.post.getPostPrice.toString()} €', */
                      color: Theme.of(context).primaryColor, 
                      filled: true,
                      action: () {
                        
                        
                      },
                    ),
                    SizedBox(width: 30,),
                    ActionButton(
                      text: 'Envoyer un message', 
                      color: Theme.of(context).accentColor, 
                      filled: true,
                      action: () {
                        //Navigator.pushNamed(context, '/channel', arguments: ChannelModel());
                        //Navigator.pushNamed(context, '/newPost/confirmation' );
                        //dialog box to send you first message
                        return showDialog(
                          context: context, 
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Envoyer un message"),
                              
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SimpleInput(
                                    type: 'multiline',
                                    placeholder: 'Votre message ...',
                                    onChange: (value) {
                                      _message = value;
                                    },
                                  )
                                ],
                              ),
                              actions: [
                                
                                ActionButton(
                                    text: 'ANNULER',
                                    color: Theme.of(context).accentColor,
                                    filled: false,
                                    hasBorder: false,
                                    action: () {
                                      Navigator.pop(context);
                                    },
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: InkWell(
                                    
                                    onTap: () async {
                                      //create a new channel
                                      MessagingController messagingController = MessagingController();
                                      ChannelModel newChannel = await messagingController.newChannel(widget.post);
                                      //don't forget to send the message ! 
                                      MessageModel message = MessageModel();
                                      message.setMessageType = "text";
                                      message.setMessageValue = _message;
                                      messagingController.sendMessage(message, newChannel);
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, '/channel', arguments: newChannel);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.send,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          );

                        
                      },
                    ),
                  ],
                ),
              ),
            ),
    body: ListView(
      controller: _scrollController,
      padding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          height: 500,
          child: Stack(
            fit: StackFit.expand,
            children: [
              
              Hero(
                tag: widget.post.getPostId+'_image',
                child: PageView(
                  children: _imagePageViewOrganizer(),
                  controller: _pageController,
                ),
              ),
              _imageIndexer(),
              _likesBloc()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(widget.post.getPostTitle, 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).primaryColorDark,
              
             ),
          ),
        ),
        InkWell(
          onTap: (){
            // TODO userProfil page
          },
          child:  Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 40,
                          backgroundImage:  _userProfile != null ? NetworkImage(_userProfile?.getUserProfileImageURL) : null,
                        ),
                        SizedBox(width: 15,),
                        Column(
                          children: [
                            Text(_userProfile != null ?
                                 _userProfile?.getUserName : '', 
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            RatingBarIndicator(itemBuilder: (context, index)=>Icon(
                                Icons.star, 
                                color: Theme.of(context).primaryColor
                              ),
                              itemCount: 5,
                              rating: _userProfile != null ? _userProfile?.getUserRate : 0,
                              itemSize: 25,
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColorDark),
                  ]
                ),
              ),
        ),
             
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 500),
          child: Column(
            children: [
              Text(widget.post.getPostDescription!),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10,10,0),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Theme.of(context).primaryColorDark, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Frais de port', 
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 18,
                        ),
                      ),
                      Text(widget.post.getPostShippingFees!.toString() + ' €', 
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            
            ],
          ),
        ),
      ],
    ),
    );
  }
}