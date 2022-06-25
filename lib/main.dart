import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantetazone/components/loaderPage.dart';
import 'package:plantetazone/models/channelModel.dart';
import 'package:plantetazone/models/postModel.dart';
import 'package:plantetazone/view/home/postPage.dart';
import 'package:plantetazone/view/mainScreen.dart';
import 'package:plantetazone/view/messages/channelPage.dart';
import 'package:plantetazone/view/newPost/newPost.dart';
import 'package:plantetazone/view/newPost/newPostConfirmation.dart';
import 'package:plantetazone/view/signin/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plantetazone/view/signin/signup.dart';
import './themes/mainTheme.dart';
import 'controler/userConnection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      title: 'PlanteTaZone',
      theme: mainTheme.defaultTheme,
    );
  }
}

// Route class
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    UserConnection userConnection = UserConnection();
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => StreamBuilder(
                  stream: userConnection.userStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        //if a user is connected show the client page
                        return MainScreen();
                      } else {
                        //if not showing sign in page
                        return SignInPage();
                      }
                    }
                    return Container();
                  },
                ));
      case '/newPost':
        return MaterialPageRoute(builder: (context) => const NewPostPage());
      case '/newPost/confirmation':
        return MaterialPageRoute(
            builder: (context) => const NewPostConfirmationPage());
      case '/post':
        return MaterialPageRoute(
            builder: (context) =>
                PostPage(post: settings.arguments as PostModel));
      case '/channel':
        return MaterialPageRoute(
            builder: (context) =>
                ChannelPage(channel: settings.arguments as ChannelModel));
      case '/signup':
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case '/loading':
        if (settings.arguments != null) {
          Map<String, dynamic>? args =
              settings.arguments as Map<String, dynamic>;
          String? text = args.containsKey('text') ? args['text'] : null;
          Duration timeOffset = args.containsKey('timeOffset')
              ? args['timeOffset']
              : Duration.zero;
          Function()? callBack =
              args.containsKey('callBack') ? args['callBack'] : null;
          return MaterialPageRoute(
              builder: (context) => LoaderPage(
                    text: text,
                    timeOffset: timeOffset,
                    callBack: callBack,
                  ));
        } else {
          return MaterialPageRoute(
              builder: (context) => LoaderPage(
                    timeOffset: Duration(seconds: 1),
                  ));
        }

      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
