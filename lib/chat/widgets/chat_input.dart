import 'package:convo/chat/widgets/image_picker_body.dart';
import 'package:convo/models/chat_message_entity.dart';
import 'package:convo/utils/brand_color.dart';
import 'package:convo/utils/helper_function.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class ChatInputField extends StatefulWidget {
  final Function(ChatMessageEntity) onSubmit;

  const ChatInputField({super.key, required this.onSubmit});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  String _selectedImageUrl = '';

  final chatMessageController = TextEditingController();

  void sendButtonPressed() async {
    String? userNameFromCache = await context.read<AuthService>().getUsername();
    if (kDebugMode) {
      print('ChatMessages: ${chatMessageController.text}');

      final newChatMessages = ChatMessageEntity(
          text: chatMessageController.text,
          id: '243',
          createdAt: DateTime
              .now()
              .millisecondsSinceEpoch,
          author: Author(userName: userNameFromCache!));

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
    final dark = DHelperFunctions.isDarkMode(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BrandColor.primaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
      ),
      child: Container(
        color: BrandColor.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 12),
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
                      border: InputBorder.none, // Removes all borders
                      enabledBorder: InputBorder.none, // Removes enabled state border
                      focusedBorder: InputBorder.none, // Removes focus border
                      disabledBorder: InputBorder.none, // Removes disabled state border
                      hintText: 'Enter your message',
                      hintStyle: TextStyle(color: dark ? BrandColor.light : BrandColor.dark), // Ensures hint visibility
                      contentPadding: EdgeInsets.zero, // Removes extra padding
                    ),
                  ),
                  if (_selectedImageUrl.isNotEmpty)
                    Image.network(_selectedImageUrl, height: 50),
                ],
              ),
            ),
            IconButton(onPressed: sendButtonPressed, icon: Icon(Icons.send_outlined)),
          ],
        ),
      ),
    );
  }
}
