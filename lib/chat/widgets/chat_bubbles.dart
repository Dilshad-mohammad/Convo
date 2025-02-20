import 'package:convo/models/chat_message_entity.dart';
import 'package:convo/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatBubble extends StatelessWidget {
   ChatBubble({
    super.key, required this.alignment, required this.entity,
  });

  final ChatMessageEntity entity;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    bool isAuthor = entity.author.userName == context.read<AuthService>().getUsername();

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isAuthor ? Theme.of(context).primaryColor :  Colors.black54,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          
        ),
        child: Column(
          children: [
            Text(entity.text),
            if(entity.imageUrl != null)
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(entity.imageUrl!))),
              child: Image.network('${entity.imageUrl}',
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 50, color: Colors.red);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}