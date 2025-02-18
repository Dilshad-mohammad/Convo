import 'dart:convert';
import 'package:convo/Authentication/login_screen.dart';
import 'package:convo/chat/widgets/chat_bubbles.dart';
import 'package:convo/chat/widgets/chat_input.dart';
import 'package:convo/models/chat_message_entity.dart';
import 'package:convo/models/image_model.dart';
import 'package:convo/repo/image_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

      final List<ChatMessageEntity> _chatMessages = decodedList.map((listItem) {
        return ChatMessageEntity.fromJson(listItem);
      }).toList();

      // final state of the messages
      setState(() {
        _messages = _chatMessages;
      });
    });
  }


  onMessageSent(ChatMessageEntity entity) {
    _messages.add(entity);
    setState(() {});
  }
  final ImageRepository _imageRepository = ImageRepository();
  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userName = ModalRoute.of(context)!.settings.arguments as String? ??
        AppState.userName;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hi! $userName!'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            },
          )
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<List<PixelFormImage>>(
              future: _imageRepository.getNetworkImages(),
              builder: (BuildContext context, AsyncSnapshot<List<PixelFormImage>> snapshot){
                if (snapshot.hasData) {
                  return Image.network(snapshot.data![0].downloadUrl);
                }

                return CircularProgressIndicator();
              }),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                    entity: _messages[index],
                    alignment: _messages[index].author.userName == 'Dilshad'
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
