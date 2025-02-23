import 'dart:convert';
import 'package:convo/Authentication/login_screen.dart';
import 'package:convo/chat/widgets/chat_bubbles.dart';
import 'package:convo/chat/widgets/chat_input.dart';
import 'package:convo/models/chat_message_entity.dart';
import 'package:convo/services/auth_service.dart';
import 'package:convo/utils/brand_color.dart';
import 'package:convo/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Initial state of the messages
  List<ChatMessageEntity> _messages = [];

  _loadInitialMessages() async {
    rootBundle.loadString('assets/mock_messages.json').then((response) {
      final List<dynamic> decodedList = jsonDecode(response) as List;

      final List<ChatMessageEntity> chatMessages = decodedList.map((listItem) {
        return ChatMessageEntity.fromJson(listItem);
      }).toList();

      // final state of the messages
      setState(() {
        _messages = chatMessages;
      });
    });
  }

  onMessageSent(ChatMessageEntity entity) {
    _messages.add(entity);
    setState(() {});
  }

  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<AuthService>().getUsername();
    AppState.userName;
    return Scaffold(
      backgroundColor: DHelperFunctions.isDarkMode(context) ? BrandColor.darkerGrey : BrandColor.light,
      endDrawer: Drawer(
        surfaceTintColor: BrandColor.primaryColor,
        child: ListView(
          padding: EdgeInsets.only(top: 70),
          children: [
            ListTile(
              title: Text('reset UserName'),
              onTap: () {
                context.read<AuthService>().updateUserName('New Name');
              },
            ),
            ListTile(
              title: Text('Logout'),
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
        title: Text('Hi! $userName!'),
        backgroundColor: BrandColor.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                    entity: _messages[index],
                    alignment: _messages[index].author.userName ==
                            context.read<AuthService>().getUsername()
                        ? Alignment.topRight
                        : Alignment.topLeft);
              },
              padding: EdgeInsets.all(24),
            ),
          ),
          ChatInputField(onSubmit: onMessageSent),
        ],
      ),
    );
  }
}
