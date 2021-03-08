import 'package:fishapp/entities/chat/messagebody.dart';
import 'package:fishapp/pages/chat/conversation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendChatMessageForm extends StatefulWidget {
  @override
  _SendChatMessageFormState createState() => _SendChatMessageFormState();
}

class _SendChatMessageFormState extends State<SendChatMessageForm> {
  final textEditController = TextEditingController();
  bool isMessageValid = false;

  @override
  void initState() {
    super.initState();
    textEditController.addListener(_validateMessageInput);
  }

  _validateMessageInput() {
    setState(() {
      if (textEditController.text.isNotEmpty) {
        isMessageValid = true;
      } else {
        isMessageValid = false;
      }
    });
  }

  void sendMessage() {
    MessageBody mbody =
        MessageBody(messageText: textEditController.text.toString());
    textEditController.clear();
    Provider.of<ConversationModel>(context, listen: false).sendMessage(mbody);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          IconButton(icon: Icon(Icons.add_a_photo), onPressed: null),
          // FIXME: få til row her for å lage boksen frå designet (viss viktig?)
          //Row(
          //  children: [
          //
          //  ],
          //),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // avoid overlap with circle
                      SizedBox(
                        width: 3,
                      ),
                      Flexible(
                        child: TextField(
                          controller: textEditController,
                          //TODO: get decoration to works
                          //decoration: Theme.of(context).inputDecorationTheme
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.send),
                          onPressed: isMessageValid ? sendMessage : null)
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
          )
          // Flexible(
          //   child: TextField(
          //     controller: textEditController,
          //     //TODO: get decoration to works
          //     //decoration: Theme.of(context).inputDecorationTheme
          //   ),
          //
          // ),
          // Align(
          //     alignment: Alignment.centerRight,
          //     child: IconButton(
          //         icon: Icon(Icons.send),
          //         onPressed: isMessageValid ? sendMessage : null)),
        ],
      ),
    );
  }
}
