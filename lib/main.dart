import 'package:convo/chat/chat_screen.dart';
import 'package:convo/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Authentication/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AuthService(), child: Convo()));
}

class Convo extends StatelessWidget {
  const Convo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: Colors.transparent,
          // removes all background colors, to give bgColor manually to all pages.
          primarySwatch: Colors.deepPurple,
          //BrandColor.primaryColor,
          textTheme: Typography.blackHelsinki,
          appBarTheme: AppBarTheme(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blueAccent)),
      home: FutureBuilder<bool>(
          future: context.read<AuthService>().isLoggedIn(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!) {
                return ChatScreen();
              } else {
                return LoginScreen();
              }
            }
            return CircularProgressIndicator();
          }),
      routes: {
        '/chat': (context) => ChatScreen(),
      },
    );
  }
}
