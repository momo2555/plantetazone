import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileListElement extends StatefulWidget {
  const ProfileListElement({
    Key? key,
    this.icon,
    this.title ,
    this.description ,
    @required this.action,
  }) : super(key: key);
  final IconData? icon;
  final String? title;
  final String? description;
  final Function()? action;
  @override
  State<ProfileListElement> createState() => _ProfileListElementState();
}

class _ProfileListElementState extends State<ProfileListElement> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
                  onTap:widget.action,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(widget.icon ?? Icons.close, 
                            color: Theme.of(context).primaryColor,
                            size: 40,
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.title ?? '',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(widget.description ?? '', 
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )
                        ]
                      ),
                      Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColorDark),
                    ]
                  ),
                );
  }
}