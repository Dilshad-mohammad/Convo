import 'dart:convert';
import 'package:convo/chat/widgets/chat_bubbles.dart';
import 'package:convo/chat/widgets/chat_input.dart';
import 'package:convo/models/chat_message_entity.dart';
import 'package:convo/services/auth_service.dart';
import 'package:convo/utils/brand_color.dart';
import 'package:convo/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/contact_list_model.dart';

class ChatScreen extends StatefulWidget {
  final Contact? contact;

  const ChatScreen({super.key, required this.contact});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Initial state of the messages
  List<ChatMessageEntity> _messages = [];
  final ScrollController _scrollController = ScrollController(); // ScrollController added

  _loadInitialMessages() async {
    // Optionally, load messages for the given contact.
    rootBundle.loadString('assets/mock_messages.json').then((response) {
      final List<dynamic> decodedList = jsonDecode(response) as List;

      final List<ChatMessageEntity> chatMessages = decodedList.map((listItem) {
        return ChatMessageEntity.fromJson(listItem);
      }).toList();

      // Set the messages state
      setState(() {
        _messages = chatMessages;
      });
      _scrollToBottom(); // Scroll down after loading messages
    });
  }

  onMessageSent(ChatMessageEntity entity) {

    setState(() {
      _messages.add(entity);
    });
    _scrollToBottom();
  }

  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DHelperFunctions.isDarkMode(context)
          ? BrandColor.darkerGrey
          : BrandColor.light,
      endDrawer: Drawer(
        surfaceTintColor: BrandColor.primaryColor,
        child: ListView(
          padding: const EdgeInsets.only(top: 70),
          children: [
            ListTile(
              title: const Text('Reset Username'),
              onTap: () {
                context.read<AuthService>().updateUserName('New Name');
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                context.read<AuthService>().logoutUser();
                Navigator.popAndPushNamed(context, '/');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        // Display the contact's name in the app bar
        title: Text(widget.contact!.name),
        backgroundColor: BrandColor.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(24),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isMe = _messages[index].author.userName ==
                    context.read<AuthService>().getUsername();
                return ChatBubble(
                  entity: _messages[index],
                  alignment:
                  isMe ? Alignment.topRight : Alignment.topLeft,
                );
              },
            ),
          ),
          ChatInputField(onSubmit: onMessageSent),
        ],
      ),
    );
  }
}
