import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:plantetazone/components/actionButton.dart';
import 'package:plantetazone/view/mainScreen.dart';

import '../../controler/userConnection.dart';
import '../../models/userModel.dart';
/*import 'package:legend_app/models/userModel.dart';
import 'package:legend_app/server/userConnection.dart';
import 'package:legend_app/vues/Client.dart';*/

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _password = '';
  String _email = '';

  Widget _passwordEntry() {
    return TextFormField(
      obscureText: true,
       style: const TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key, color: Theme.of(context).accentColor),
        hintText: 'Mot de passe',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide.none
        ),
        fillColor: Theme.of(context).backgroundColor,
        filled: true,
        contentPadding: const EdgeInsets.all(15),
      ),
      onChanged: (value) => setState(() {
        _password = value;
      }),
    );
  }

  Widget _emailEntry() {
    return TextFormField(
      
      style: TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, color: Theme.of(context).accentColor),
        hintText: 'Adresse e-mail',
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide.none
        ),
        fillColor: Theme.of(context).backgroundColor,
        filled: true,
        contentPadding: EdgeInsets.all(15)
        
      ),
      onChanged: (value) => setState(() {
        _email = value;
      }),
    );
  }

  Widget _submitButton() {
    return Row(children: 
      [
        TextButton(
          onPressed: () {
            
          }, 
          child: Text('Mot de passe oublier', style: TextStyle(color: Theme.of(context).backgroundColor,fontSize: 12, fontWeight: FontWeight.w300))),
        VerticalDivider(color: Theme.of(context).backgroundColor,thickness: 2,indent: 0,endIndent: 5,width:5),
        
        TextButton(
          onPressed: ()  {
            Navigator.pushNamed(context, '/signup');
          }, 
          child: Text('Je n\'ai pas de compte', style: TextStyle(color: Theme.of(context).backgroundColor,fontSize: 12, fontWeight: FontWeight.w300))),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () async {
              UserConnection userConnection = UserConnection();
              UserModel newUser;
              userConnection.authentification(_email, _password).then((value) {
                newUser = value;
                //if the user is connected
                if (newUser.isConnected()) {
                  //page des utilisateurs connecté
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return MainScreen();
                    },
                  ));
                } else {
                  return showDialog(context: context, builder: (context){
                    return  AlertDialog(
                      title: const Text("Erreur de connexion"),
                      content: const Text("L'adresse e-mail ou le mot de passe est incorrecte"),
                      actions: [
                        ActionButton(
                          text: 'OK',
                          filled: false,
                          hasBorder: false,
                          action: ()=>Navigator.pop(context),
                        )
                      ],
                    );
                  });
                  //message d'erreur
                }
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).backgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
            
            child: Container(
              height: 60,
              width: 60,
              child: Icon(
                Icons.arrow_forward_rounded,
                color: Theme.of(context).accentColor,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _socialConnection(String name, Widget icon, Function() action) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: action(), 
        icon: icon, 
        label: Text('Se connecter avec '+name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),),
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
          backgroundColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),
          maximumSize: MaterialStateProperty.all(Size.fromHeight(48)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ))
        
        ),
        ),
      );
  }
  Widget _connectionWithGoogle() {
    return _socialConnection('Google', Image.asset('assets/icons/google.ico'), () => null);
  }
  Widget _connectionWithFacebook() {
     return _socialConnection('Facebook', Image.asset('assets/icons/facebook.ico'), () => null);
  }
  Widget _connectionWithApple() {
    return Container();
  }
  
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,

      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          child: Column(
            children: [
              Image.asset('assets/logos/logo_title.png'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: 
                    [
                      SizedBox(height: 10,),
                      Text('Connexion', 
                        style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).backgroundColor)
                      ),
                      SizedBox(height: 15,),
                      _emailEntry(),
                      SizedBox(height: 10,),
                      _passwordEntry(),
                      SizedBox(height: 10,),
                      _submitButton(),
                      SizedBox(height: 30,),
                      _connectionWithGoogle(),
                      SizedBox(height: 10,),
                      _connectionWithFacebook()
                    ]
                  ),
                ),
              ),
            ],
              
          ),
        ),
    ),
    );
  }
}
