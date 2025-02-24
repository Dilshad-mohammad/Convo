import 'package:convo/chatlist/chatlist.dart';
import 'package:convo/services/auth_service.dart';
import 'package:convo/utils/theme.dart';
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
      title: 'Convo',
      themeMode: ThemeMode.system,
      theme: D_vaultTheme.lightTheme,
      darkTheme: D_vaultTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
          future: context.read<AuthService>().isLoggedIn(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!) {
                return ContactListScreen();
              } else {
                return LoginScreen();
              }
            }
            return CircularProgressIndicator();
          }),
        routes: {
          '/chatlist': (context) => ContactListScreen(),
        }

    );
  }
}
