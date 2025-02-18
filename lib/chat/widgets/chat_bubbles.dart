import 'package:convo/models/chat_message_entity.dart';
import 'package:flutter/material.dart';


class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key, required this.alignment, required this.entity,
  });

  final ChatMessageEntity entity;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Colors.grey,
        ),
        child: Column(
          children: [
            Text(entity.text),
            if(entity.imageUrl != null)
            Image.network('${entity.imageUrl}',
              loadingBuilder: (context, child, loadingProgress){
                if(loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 50, color: Colors.red);
              },
            ),
          ],
        ),
      ),
    );
  }
}