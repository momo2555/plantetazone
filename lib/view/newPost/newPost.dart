import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plantetazone/components/actionButton.dart';
import 'package:plantetazone/components/newPostImagePicker.dart';
import 'package:plantetazone/components/simpleDropDown.dart';
import 'package:plantetazone/components/simpleInput.dart';
import 'package:plantetazone/components/simpleInputLabel.dart';
import 'package:plantetazone/controler/postController.dart';
import 'package:plantetazone/models/postModel.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {

  //add focus objects
  FocusNode _titleFocus = FocusNode(); 
  FocusNode _descriptionFocus = FocusNode(); 
  FocusNode _categoryFocus = FocusNode();
  FocusNode _priceFocus = FocusNode(); 
  FocusNode _weightFocus = FocusNode(); 
  //add stored data
  String _title ='';
  String _description = "";
  List<String> _images = [];
  String _category = PostModel.getCategories[0];
  double _price = 0;
  double _weight = 0;
  //key form
  final _formKey = GlobalKey<FormState>();
  // TODO validator functions
  void Validate() {
    PostModel newPost =  PostModel();
    newPost.setPostTitle = _title;
    newPost.setPostDescription = _description;
    newPost.setPostCategory =_category;
    newPost.setPostPrice = _price;
    newPost.setPostWeight = _weight;
    newPost.setPostTempImagePaths = _images;
    PostController postControler = PostController();
    // TODO check error 
    postControler.publishPost(newPost);
    //go to to page confirmation
    Navigator.pop(context);
    Navigator.pushNamed(context, '/newPost/confirmation' ); // TODO add argument (if error or not)
  }
    @override
  void initState() {
    super.initState();
    _titleFocus = FocusNode(); 
    _descriptionFocus = FocusNode(); 
    _categoryFocus = FocusNode();
    _priceFocus = FocusNode(); 
    _weightFocus = FocusNode(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                // Status bar color
                statusBarColor:Theme.of(context).primaryColor
              ),
              backgroundColor: Theme.of(context).primaryColor,
              title: const Text("Nouvelle Annonce"),
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
                      text: 'Publier', 
                      color: Theme.of(context).primaryColor, 
                      filled: true,
                      action: () {
                        if(_formKey.currentState!.validate()) {
                          Validate();
                        }
                        
                      },
                    ),
                    SizedBox(width: 30,),
                    ActionButton(text: 'Annuler', color: Theme.of(context).accentColor, filled: true,),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(0),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    //title of the post
                    SimpleInputLabel(text: 'Titre'),
                    SimpleInput(
                      placeholder: 'Titre',
                      focusNode: _titleFocus,
                      nextNode: _descriptionFocus,
                      textInputAction: TextInputAction.next,
                      onChange: (value) {
                        _title = value;
                      },
                    ),
                    SizedBox(height: 8,),
              
                    //description of the post
                    SimpleInputLabel(text: 'Description'),
                    SimpleInput(
                      placeholder: 'Description', 
                      type: 'multiline',
                      focusNode: _descriptionFocus,
                      nextNode: _categoryFocus,
                      onChange: (value) {
                        _description = value;
                      },
                    ),
                    SizedBox(height: 8,),
              
                    //images of the post
                    SimpleInputLabel(
                      text: 'Images de description'),
                    NewPostImagePicker(
                      onChange: (imagePaths) => _images = imagePaths
                    ),
                    SizedBox(height: 8,),
              
                    //category of the post
                    SimpleInputLabel(text: 'Catégorie de la plante'),
                    SimpleDropDown(
                      items: PostModel.getPostCategories,
                      focusNode: _categoryFocus,
                      nextNode: _priceFocus,
                      onChange: (value) {
                        _category = value;
                        log(value);
                      },
                      
                    ),
              
                    //price of the post
                    SimpleInputLabel(text: 'Prix'),
                    SimpleInput(
                      placeholder: 'Prix en euros', 
                      type: 'numeric',
                      focusNode: _priceFocus,
                      nextNode: _weightFocus,
                      textInputAction: TextInputAction.next,
                      onChange: (value) {
                        if(value == "") {
                          _price = 0;
                        } else {
                          _price = double.parse(value);
                        }
                      },
                    ),
                    SizedBox(height: 8,),
              
                    //weight of the plant
                    SimpleInputLabel(text: 'Poids en grammes'),
                    SimpleInput(
                      placeholder: 'Poids en grammes', 
                      type: 'numeric',
                      focusNode: _weightFocus,
                      textInputAction: TextInputAction.next,
                      onChange: (value) {
                        if(value == "") {
                          _weight = 0;
                        } else {
                          _weight = double.parse(value);
                        }
                      },
                    ),
                    SizedBox(height: 8,),
                    
              
                    
                  ],
                ),
              ),
            ));
  }
}