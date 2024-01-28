import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatTextFieldBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatTextFieldBar({
    Key? key,
    required this.controller,
    required this.onSend,
  }) : super(key: key);

  @override
  State<ChatTextFieldBar> createState() => _ChatTextFieldBarState();
}

class _ChatTextFieldBarState extends State<ChatTextFieldBar> {
  bool showSendButton = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            offset: const Offset(-2, 0),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 15),
          ),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              onChanged: (val) {
                setState(() {
                  showSendButton = val.trim().isNotEmpty;
                });
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Enter Message',
                border: InputBorder.none,
              ),
            ),
          ),
          if (showSendButton)
            IconButton(
              onPressed: () {
                widget.onSend();
              },
              icon: const Icon(
                Icons.send,
              ),
            ),
        ],
      ),
    );
  }
}