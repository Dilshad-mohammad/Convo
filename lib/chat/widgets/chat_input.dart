import 'package:convo/chat/widgets/image_picker_body.dart';
import 'package:convo/models/chat_message_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  final Function(ChatMessageEntity) onSubmit;

  ChatInputField({super.key, required this.onSubmit});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  String _selectedImageUrl = '';

  final chatMessageController = TextEditingController();

  void sendButtonPressed() {
    if (kDebugMode) {
      print('ChatMessages: ${chatMessageController.text}');

      final newChatMessages = ChatMessageEntity(
          text: chatMessageController.text,
          id: '243',
          createdAt: DateTime
              .now()
              .millisecondsSinceEpoch,
          author: Author(userName: 'Dilshad'));

      if (_selectedImageUrl.isNotEmpty){
        newChatMessages.imageUrl = _selectedImageUrl;
      }
      widget.onSubmit(newChatMessages);

      chatMessageController.clear();
      _selectedImageUrl = '';
      setState(() {});
    }
  }

  void onImagePicked(String newImageUrl) {
    setState(() {
      _selectedImageUrl = newImageUrl;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {
            showModalBottomSheet(context: context,
                builder: (BuildContext context){
              return NetworkImagePickerBody(onImageSelected: onImagePicked,);

            });

          }, icon: Icon(Icons.add)),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 4,
                      minLines: 1,
                      controller: chatMessageController,
                      decoration: InputDecoration(
                          hintText: 'Enter your message',
                          helperStyle: TextStyle(color: Colors.blueGrey),
                          border: InputBorder.none),
                  ),

                  if(_selectedImageUrl.isNotEmpty)
                    Image.network(_selectedImageUrl, height: 50),
                ],
              ),
            ),
          ),
          IconButton(onPressed: sendButtonPressed, icon: Icon(Icons.send_outlined)),
        ],
      ),
    );
  }
}
