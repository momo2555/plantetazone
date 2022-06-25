import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plantetazone/controler/postController.dart';
import 'package:plantetazone/models/postModel.dart';

class PostTile extends StatefulWidget {
  const PostTile({
    Key? key,
    required this.post,
  }) : super(key: key);
  final PostModel post;
  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  PostController _postControler = PostController(); 
  DecorationImage? _decorationImage() {
    if ((widget.post.getImageFiles != null && widget.post.getImageFiles!.length > 0)) {
      return DecorationImage(
                image: FileImage(widget.post.getImageFiles!.first),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            );
    } else {
      return null;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _postControler.getImages(widget.post).then((value) => setState((){}));
  }
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        //go to the post
        Navigator.pushNamed(context, '/post', arguments: widget.post);
      },
      child: LayoutBuilder(builder: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight - 40,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
              image: _decorationImage(),
            ),
            
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    
                    child: Hero(
                      tag: widget.post.getPostId + '_image',
                      child: Container(
                        width: constraints.maxWidth,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(97, 69, 69, 69),
                        ),
                      ),
                    )
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                      
                          child: Text(widget.post.getPostPrice.toString() + ' €', 
                            style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                              fontSize: 20,
                            )
                          ),
                      ),
                  ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child:
                          Padding(
                           padding: const EdgeInsets.fromLTRB(10, 6, 12, 8),
                            child: InkWell(
                              child: Icon(Icons.favorite_outline, color: Theme.of(context).accentColor)
                            ),
                          )
                      )
                  ],
                ),
                    
                  
              
              ),
            
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
            child: Text(widget.post.getPostTitle),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 2, 0, 0),
            child: Text(widget.post.getPostCategory, 
              style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColorDark),
            ),
          )
        ],
      ),
    )
    );
    
  }
}