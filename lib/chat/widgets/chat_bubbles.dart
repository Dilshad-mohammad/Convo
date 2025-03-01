import 'package:convo/models/chat_message_entity.dart';
import 'package:convo/services/auth_service.dart';
import 'package:convo/utils/brand_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/helper_function.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.alignment,
    required this.entity,
  });

  final ChatMessageEntity entity;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    bool isAuthor =
        entity.author.userName == context.read<AuthService>().getUsername();
    final dark = DHelperFunctions.isDarkMode(context);
    return Align(
      alignment: alignment,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        padding: EdgeInsets.symmetric(horizontal: 8),
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: isAuthor
                ? Theme.of(context).primaryColor
                : dark
                    ? BrandColor.secondary
                    : BrandColor.primaryAccent,
            borderRadius: isAuthor
                ? BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))
                : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(entity.text,
                  style: TextStyle(
                    fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: dark ? BrandColor.textPrimary : BrandColor.black)),
            ),
            if (entity.imageUrl != null)
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: NetworkImage(entity.imageUrl!))),
                child: Image.network(
                  '${entity.imageUrl}',
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
