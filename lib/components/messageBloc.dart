import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

enum MessageBlocType { RECEIVER, SENDER }

class MessageBloc extends StatefulWidget {
  const MessageBloc.receiver({
    Key? key,
    this.content,
  })  : type = MessageBlocType.RECEIVER,
        super(key: key);
  const MessageBloc.sender({
    Key? key,
    this.content,
  })  : type = MessageBlocType.SENDER,
        super(key: key);

  final MessageBlocType type;
  final Widget? content;
  @override
  State<MessageBloc> createState() => _MessageBlocState();
}

class _MessageBlocState extends State<MessageBloc> {
  Widget _receiverBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 25),

        //maxWidth: 100,
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 210, 210, 210),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(12),
              child: widget.content,
            ),
          ),
        ),
      ],
    );
  }

  Widget _senderBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 20,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Theme.of(context).primaryColorDark, width: 1)),
              padding: EdgeInsets.all(12),
              child: widget.content,
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //return Row()
    if (widget.type == MessageBlocType.RECEIVER) {
      return _receiverBuild();
    } else {
      return _senderBuild();
    }
  }
}
