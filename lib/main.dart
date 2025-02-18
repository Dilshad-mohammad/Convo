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
