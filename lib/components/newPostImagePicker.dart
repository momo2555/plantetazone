import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewPostImagePicker extends StatefulWidget {
  const NewPostImagePicker({
    Key? key,
    this.maxImages = 4,
    this.onChange,
    }) : super(key: key);
    final int maxImages;
    final Function(List<String> imagePaths)? onChange;
  @override
  State<NewPostImagePicker> createState() => _NewPostImagePickerState();
}

class _NewPostImagePickerState extends State<NewPostImagePicker> {
  List<String> imagePaths = [];
  @override
  void setState(VoidCallback fn) {
    
    super.setState(fn);
    //when state change send the image path to the callback function
    if (widget.onChange != null) {
      widget.onChange!(imagePaths);
    }
    
  }
  Widget _addButton() {
    return Expanded(

      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.image,
              allowMultiple: true,

            );
            // TODO implement the image cropper
            if(result!=null){
              List<File> files = result.paths.map((path) => File(path??'')).toList();
              int length = result.paths.length;
              if(length > widget.maxImages) length = widget.maxImages;
              setState(() {
                for (int i = 0;i<length;i++) {
                  imagePaths.add(result.paths[i]??"");
                }
              });
              
              //action
            }
          },
          
            child: Container(
              
              height: 93,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).accentColor, width: 1.5),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(7.5),
              ),
              child:  Icon(Icons.add, size: 35, color: Theme.of(context).accentColor),
            ),
          
        ),
      ),
    );
  }
  Widget _blank () {
    return Expanded(
      child: Container(
        height: 93,
      ),
    );
  }
  Widget _ImageBloc(int index) {
    // TODO : resize the image (to have smaller image for uploading in the server (max 500px ))
    
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          clipBehavior: Clip.antiAlias,
          //
          /*foregroundDecoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.normal,
                spreadRadius: -0.1,
                blurRadius: 0.01,

              )
            ],
          ),*/
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(7.5),
            image: DecorationImage(
              image: FileImage(File(imagePaths[index])),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          height: 93,
          child: Stack(
            children: [
              /*Expanded(
                child: Image.file(File(imagePaths[index]??''), fit: BoxFit.cover, height: double.infinity, width: double.infinity,),
              ),*/
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    //delete the image
                    setState(() {
                      imagePaths.removeAt(index);
                    });
                    
                  }, 
                  icon: Icon(Icons.delete,color:Theme.of(context).backgroundColor, shadows: [Shadow(color: Color.fromARGB(150, 0, 0, 0),blurRadius: 15)]),
                ),
              ),
            ]),
        )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> imagesComp = [];
    int len = imagePaths.length;
    //add the (+) button
    if (len < widget.maxImages) {
      imagesComp.add(_addButton());
    }
    //add images which are picked by user
    for(int i = 0;i<len;i++) {
      imagesComp.add(_ImageBloc(i));
    }
    for(int i = imagesComp.length; i<widget.maxImages;i++){
      imagesComp.add(_blank());
    }

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: imagesComp,
      ),
    );
  }
}