import 'package:convo/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../chat/widgets/login_textfield.dart';

class AppState {
  static String userName = '';
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formkey = GlobalKey<FormState>();

  void loginUser(BuildContext context) {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      AppState.userName = usernameController.text;
      Navigator.pushReplacementNamed(context, '/chat',
          arguments: usernameController.text);
    }
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _mainurl = 'https://portfolio-six-tawny-60.vercel.app/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Let\'s Sign you in!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
            Text('Welcome back, You\'ve been missed!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
            verticalSpecing(12),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.network(
                  "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
                  height: 100),
            ),
            verticalSpecing(12),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  LoginTextField(
                    controller: usernameController,
                    hintText: 'Add your Username',
                    validator: (value) {
            if (value != null && value.isNotEmpty && value.length < 5) {
            return 'Enter More than 5 Characters';
            } else if (value != null && value.isEmpty) {
            return 'Enter Username';}
            return null;},

                  ),
                  verticalSpecing(24),
                  LoginTextField(
                    asteriks: true,
                    controller: passwordController,
                    hintText: 'Enter your Password',
                  ),
                ],
              ),
            ),
            verticalSpecing(24),
            OutlinedButton(
                onPressed: () {
                  loginUser(context);
                },
                child: Text(
                  'Login In',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )),
            InkWell(
              onTap: () async {
                if(!await launchUrlString(_mainurl)) {
                  throw 'could not launch url';
                }
              },
              child: Column(
                children: [
                  Text('Visit my Portfolio'),
                  Text(_mainurl),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMediaButton.github(
                    size: 30,
                    color: Colors.black,
                    url: 'https://github.com/Dilshad-mohammad'),
                SocialMediaButton.linkedin(
                    size: 30, color: Colors.blue,
                    url: 'https://www.linkedin.com/in/dilshad-alam3748/'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
