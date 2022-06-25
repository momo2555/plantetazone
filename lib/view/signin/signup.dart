import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plantetazone/components/actionButton.dart';
import 'package:plantetazone/components/simpleInput.dart';
import 'package:plantetazone/components/simpleInputLabel.dart';
import 'package:plantetazone/controler/profilController.dart';
import 'package:plantetazone/controler/userConnection.dart';
import 'package:plantetazone/models/userModel.dart';
import 'package:plantetazone/models/userProfileModel.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _step = 0;
  List<Widget>? _stepList;
  bool _firstTimeImageIsPicked = true;
  //keys
  final GlobalKey<FormState> _emailPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _descriptionFormKey = GlobalKey<FormState>();
  //focuse node
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _pass1Focus = FocusNode();
  final FocusNode _pass2Focus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  //validators
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Vous devez absolument entrer un nom";
    }
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return "Votre nom doit se composer que de lettres";
    }
    return null;
  }
  String? _validatePassword1(String? value) {
    
    if (value == null || value.isEmpty) {
      return "Le mot de passe ne peut pas être vide";
    }else if (value.length < 8) {
      return "Le mot de passe doit contenir au moins 8 caractères";
    }
    
    return null;
  }
  String? _validatePassword2(String? value) {
    if (value == null || value.isEmpty) {
      return "Veuillez resaisir le mot de passe";
    }
    if (_password1!=value) {
      return "Les mots de passe sont différents";
    }
    
    return null;
  }
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Veuillez saisir une adresse E-mail";
    }
    final nameExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!nameExp.hasMatch(value)) {
      return "Adresse E-mail incorrecte";
    }
    
    return null;
  }


  //values
  String _email = '';
  String _password1 = '';
  String _password2 = '';
  String _profileImage = "";
  String _name = "";
  String _description = "";
  
  //
  void _emailPassWordvalidator() {
    // TODO create the validators
    //go next:
    setState(() {
      _step = 1;
    });
  }

  //
  void createAccount() async {
    //go to home:
    
    Navigator.pushNamed(context, '/loading', arguments: {
      'text' : 'Création de votre compte ...',
      'timeOffset' : const Duration(seconds: 2),
      'callBack' : () async {
        //the user is created
        UserConnection newUserControler = UserConnection();
        UserModel newUser = await newUserControler.createAccount(_email, _password1);
        //create the profile
        ProfileController newProfileControler = ProfileController();
        UserProfileModel newProfile = await newProfileControler.createProfile(newUser);
        newProfile.setUserProfileImageFile = File(_profileImage);
        newProfile.setUserRate = 0;
        newProfile.setUserDescription = _description;
        newProfile.setUserName = _name;
        newProfileControler.saveUserProfile(newProfile);
        
        Navigator.pop(context);
      }
    });
    
  }




  //first signup page (your email and password)
  Widget _emailPassWord() {
    return  Form(
      key: _emailPasswordFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Créé toi un compte !', 
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w300,
                  
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding:  EdgeInsets.all(20),
                  child: Image(image: AssetImage('assets/images/register.jpg')),
                ),
                const SimpleInputLabel(text: 'Adresse e-mail',),
                SimpleInput(
                  placeholder: 'Adresse e-mail',
                  focusNode: _emailFocus,
                  nextNode: _pass1Focus,
                  textInputAction: TextInputAction.next,
                  value: _email,
                  validator: (val) {return _validateEmail(val);},
                  onChange: (val){
                    _email = val;
                  },
                ),
                const SimpleInputLabel(text: 'Ton mot de passe'),
                SimpleInput(
                  type: 'password',
                  placeholder: 'Mot de passe',
                  focusNode: _pass1Focus,
                  nextNode: _pass2Focus,
                  textInputAction: TextInputAction.next,
                  value: _password1,
                  validator: (val) {return _validatePassword1(val);},
                  onChange: (val){
                    _password1 = val;
                  },
                ),
                const SimpleInputLabel(
                  text: 'Encore une dexième fois',
                  ),
                SimpleInput(
                  type: 'password',
                  placeholder: 'Mot de passe',
                  focusNode: _pass2Focus,
                  value: _password2,
                  validator: (val) {return _validatePassword2(val);},
                  onChange: (val){
                    _password2 = val;
                  },
                  
                ),
                const SizedBox(height: 0,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ActionButton(
                        hasBorder: false,
                        filled: false,
                        color: Theme.of(context).accentColor,
                        text: 'Annuler',
                        action: () {
                          return showDialog(
                            context: context, 
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Annulation"),
                                content: Text("Voulez vous vraiment annuler la création de votre admirable compte?"),
                                actions: [
                                  ActionButton(
                                    text:'OUI',
                                    color: Theme.of(context).accentColor,
                                    filled: false,
                                    hasBorder: false,
                                    action: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ActionButton(
                                    text: 'NON',
                                    color: Theme.of(context).primaryColor,
                                    filled: false,
                                    hasBorder: false,
                                    action: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            }
                          );
                        }
                      ),
                      ActionButton(
                        //hasBorder: false,
                        filled: true,
                        color: Theme.of(context).primaryColor,
                        text: 'Suivant',
                        action: () {
                          final form = _emailPasswordFormKey.currentState!;
                          if (!form.validate()) {
                            /*_autoValidateModeIndex.value =
                                AutovalidateMode.always.index;*/ // Start validating on every change.
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez corriger vos erreurs')));
                          } else {
                            form.save();
                            _emailPassWordvalidator();
                          }
                          
                        },
                      )
                    ],
                  ),
                ),
                
              ],
            ),
    );
  }

  Widget _profileDescription() {
    return  Form(
      key: _descriptionFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: CircleAvatar(
                backgroundImage: _profileImage==''?AssetImage('assets/images/placeholder_profile.jpg') as ImageProvider<Object>?:FileImage(File(_profileImage)),
                backgroundColor: Theme.of(context).primaryColor,
                radius: 100,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionButton(
                text: _firstTimeImageIsPicked?'Choisir une photo':'Changer la photo',
                filled: true,
                color: Theme.of(context).primaryColor,
                action: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    allowMultiple: false,
    
                  );
                  // TODO implement the image cropper - for next version
                  if(result!=null){
                    setState((){
                    print(result.paths.first);
                     _profileImage =  result.paths.first??'';
                     _firstTimeImageIsPicked = false;
                    });
                    
                    
                    //action
                  }
                },
              ),
              (!_firstTimeImageIsPicked ? ActionButton(
                text: 'Supprimer',
                color: Theme.of(context).accentColor,
                filled: false,
                action: () {
                  setState(() {
                    _profileImage = '';
                     _firstTimeImageIsPicked = true;
                  });
                },
              ):Container()),
              
            ],
          ),
          SimpleInputLabel(
            text: 'Choisir un Nom'
          ),
          SimpleInput(
            placeholder: 'Votre Nom',
            value: _name,
            onChange: (val) => _name=val,
            focusNode: _nameFocus,
            nextNode: _descriptionFocus,
            textInputAction: TextInputAction.next,
            validator: (val) {return _validateName(val);},
          ),
          SimpleInputLabel(
            text: 'Décris-toi en quelques phrases'
          ),
          SimpleInput(
            placeholder: 'Ta petite description ...',
            value: _description,
            onChange: (val) => _description=val,
            type: 'multiline',
            focusNode: _descriptionFocus,
    
          ),
          const SizedBox(height: 0,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ActionButton(
                        filled: false,
                        hasBorder: false,
                        color: Theme.of(context).accentColor,
                        text: 'Retour',
                        action: () {
                          setState(() {
                            _step = 0;
                          });
                        }
                      ),
                      ActionButton(
                        filled: true,
                        color: Theme.of(context).primaryColor,
                        text: 'Créer mon Compte!',
                        hasBorder: false,
                        action: () {
                          final form = _descriptionFormKey.currentState!;
                          if (!form.validate()) {
                            /*_autoValidateModeIndex.value =
                                AutovalidateMode.always.index;*/ // Start validating on every change.
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez corriger vos erreurs')));
                          } else {
                            form.save();
                            createAccount(); // and auto connect
                          }
                          
    
                        },
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _stepList = [_emailPassWord(), _profileDescription()];
    });
    

  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    Future.delayed(Duration.zero, () {
      _stepList = [_emailPassWord(), _profileDescription()];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        automaticallyImplyLeading: false,
        
      ),*/
      body: Center(
        child: SingleChildScrollView(

            padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Center(child:_stepList != null ? _stepList![_step] : _emailPassWord()),
          ),
      ),
      );
  
    
  }
}