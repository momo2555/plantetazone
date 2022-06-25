import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoaderPage extends StatefulWidget {
  const LoaderPage({
    Key? key,
    this.text,
    this.callBack,
    this.timeOffset = Duration.zero,
    }) : super(key: key);
  final String? text;
  final Function()? callBack;
  final Duration timeOffset;
  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  @override
  void initState() {
    
    super.initState();
    Future.delayed(widget.timeOffset, () {
      if (widget.callBack!=null)widget.callBack!();
      Navigator.pop(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
                // Status bar color
                statusBarColor:Theme.of(context).primaryColor
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 120, width: 120,
                decoration: BoxDecoration (

                  image: DecorationImage(
                    image: AssetImage('assets/icons/loading.gif'), fit: BoxFit.cover),
                    color: Colors.transparent,
                    
                ),
              ),
              Text(widget.text ?? 'Chargement ...', 
                style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                  fontSize: 18,
                ),
              ),

            ]

            
          
        ),
      ),
    );
    
  }
}