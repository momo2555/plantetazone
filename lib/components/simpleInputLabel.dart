import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SimpleInputLabel extends StatefulWidget {
  const SimpleInputLabel({
    Key? key,
    this.text,
  }) : super(key: key);
  final String? text;
  @override
  State<SimpleInputLabel> createState() => _SimpleInputLabelState();
}

class _SimpleInputLabelState extends State<SimpleInputLabel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Text(widget.text ?? ''), 
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 10,
        top: 10),
    );
  }
}