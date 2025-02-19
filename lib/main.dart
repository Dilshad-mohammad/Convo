import 'package:convo/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'Authentication/login_screen.dart';

void main(){
  runApp(Convo());
}

class Convo extends StatelessWidget {
  const Convo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent, // removes all background colors, to give bgColor manually to all pages.
        primarySwatch: Colors.deepPurple,//BrandColor.primaryColor,
        textTheme: Typography.blackHelsinki,
          appBarTheme: AppBarTheme(foregroundColor: Colors.black, backgroundColor: Colors.blueAccent),
      ),

      home: Scaffold(

        body: LoginScreen(),
      ),
      routes: {
        '/chat' : (context) => ChatScreen(),
      },
    );
  }
}
