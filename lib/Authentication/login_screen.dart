import 'package:convo/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../chat/widgets/login_textfield.dart';
import '../services/auth_service.dart';

class AppState {
  static String userName = '';
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formkey = GlobalKey<FormState>();

  Future<void> loginUser(BuildContext context) async {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      AppState.userName = usernameController.text;

      await context.read<AuthService>().loginUser(usernameController.text);
      Navigator.pushReplacementNamed(context, '/chat',
          arguments: usernameController.text);
    }
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _mainurl = 'https://portfolio-six-tawny-60.vercel.app/';

  Widget _buildHeader(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Let\'s Sign you in!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
        Text('Welcome back, You\'ve been missed!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        verticalSpecing(24),
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                      "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif")),
              borderRadius: BorderRadius.circular(24)),
        ),
        verticalSpecing(24),
      ],
    );
  }

  Widget _buildForm(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                    return 'Enter Username';
                  }
                  return null;
                },
              ),
              verticalSpecing(18),
              LoginTextField(
                asteriks: true,
                controller: passwordController,
                hintText: 'Enter your Password',
              ),
              verticalSpecing(24),
            ],
          ),
        ),
        OutlinedButton(
            onPressed: () async {
              await loginUser(context);
            },
            child: Text(
              'Login In',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            )),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        verticalSpecing(36),
        InkWell(
          onTap: () async {
            if (!await launchUrlString(_mainurl)) {
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
        verticalSpecing(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialMediaButton.github(
                size: 30,
                color: Colors.black,
                url: 'https://github.com/Dilshad-mohammad'),
            SocialMediaButton.linkedin(
                size: 30,
                color: Colors.blue,
                url: 'https://www.linkedin.com/in/dilshad-alam3748/'),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(12),
          child: LayoutBuilder(
            builder: (context, BoxConstraints constraints){
              if(constraints.maxWidth > 1000){
                // web Layout
                return Row(
                  children: [
                    Spacer(flex: 1),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHeader(context),
                          _buildFooter(),
                        ],
                      ),
                    ),
                    Spacer(flex: 1),
                    Expanded(child: _buildForm(context)),
                    Spacer(flex: 1),
                  ],
                );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(context),
                _buildForm(context),
                _buildFooter()

              ],
            );
          },
          ),
            ),
        ),
      ),
    );
  }
}
