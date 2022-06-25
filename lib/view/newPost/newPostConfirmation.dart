import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantetazone/components/actionButton.dart';

// TODO implement when an error occure
class NewPostConfirmationPage extends StatefulWidget {
  const NewPostConfirmationPage({Key? key}) : super(key: key);

  @override
  State<NewPostConfirmationPage> createState() => _NewPostConfirmationPageState();
}

class _NewPostConfirmationPageState extends State<NewPostConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
          statusBarColor:Theme.of(context).backgroundColor,
          systemStatusBarContrastEnforced: true,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/images/successful.jpg'),),
                Text('Votre annonce à bien été publiée !', 
                textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                   
                  ),  
                ),
                const SizedBox(height: 40,),
                ActionButton(
                  text: "Retourner à l'accueil",
                  filled: true,
                  color: Theme.of(context).primaryColor,
                  action: () {
                    // TODO go to home page
                    Navigator.pop(context);
                  }
                ),
                ActionButton(
                  text: "Voir mon annonce",
                  filled: false,
                  color: Theme.of(context).accentColor,
                  action: () {
                    // TODO see the post
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}