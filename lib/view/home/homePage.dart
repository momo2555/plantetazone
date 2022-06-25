
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:plantetazone/components/postTile.dart';
import 'package:plantetazone/controler/postController.dart';
import 'package:plantetazone/models/postModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostController postControler = PostController();

  @override
  Widget build(BuildContext context) {
    
    return Center(
              child: StreamBuilder(
                stream: postControler.getAllposts(),
                builder: (context, snapshot) {

                  
                  if(snapshot.hasData) {
                    return GridView.count(
                      
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: snapshot.data as List<PostTile>,
                    );
                     //
                  }else {
                    return Container();
                  }
                  
                },
              )
    );
            
  }
}