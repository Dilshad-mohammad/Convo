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
  String? _selectedImageUrl;
  final TextEditingController chatMessageController = TextEditingController();

  /// Sends the message when the send button is pressed
  Future<void> sendButtonPressed() async {
    try {
      final authService = context.read<AuthService>();
      String? userNameFromCache = await authService.getUsername();
      userNameFromCache ??= 'Guest'; // Fallback if username is null

      if (chatMessageController.text.trim().isEmpty && _selectedImageUrl == null) {
        if (kDebugMode) print("Empty message not sent");
        return; // Prevents sending empty messages
      }

      final newChatMessage = ChatMessageEntity(
        text: chatMessageController.text.trim(),
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
        createdAt: DateTime.now().millisecondsSinceEpoch,
        author: Author(userName: userNameFromCache),
        imageUrl: _selectedImageUrl,
      );

      widget.onSubmit(newChatMessage);

      if (mounted) {
        setState(() {
          chatMessageController.clear();
          _selectedImageUrl = null;
        });
      }

      if (kDebugMode) print("Message Sent: ${newChatMessage.text}");
    } catch (e) {
      if (kDebugMode) print('Error in sendButtonPressed: $e');
    }
  }

  /// Handles image selection
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
      decoration: const BoxDecoration(
        color: BrandColor.primaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
      ),
      child: Container(
        color: BrandColor.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            // Image Picker Button
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => NetworkImagePickerBody(onImageSelected: onImagePicked),
                );
              },
              icon: const Icon(Icons.add),
            ),

            // Chat Input Field
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null, // Allows dynamic text expansion
                    controller: chatMessageController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Enter your message...',
                      hintStyle: TextStyle(color: dark ? BrandColor.light : BrandColor.dark),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  if (_selectedImageUrl != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Image.network(_selectedImageUrl!, height: 50),
                    ),
                ],
              ),
            ),

            // Send Button
            IconButton(
              onPressed: sendButtonPressed,
              icon: const Icon(Icons.send_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
