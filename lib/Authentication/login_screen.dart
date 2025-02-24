import 'package:convo/Authentication/widgets/footer.dart';
import 'package:convo/Authentication/widgets/header.dart';
import 'package:convo/utils/brand_color.dart';
import 'package:convo/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../chat/widgets/login_textfield.dart';
import '../services/auth_service.dart';
import '../utils/helper_function.dart';

class AppState {static String userName = '';}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formkey = GlobalKey<FormState>();
  Future<void> loginUser(BuildContext context) async {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      AppState.userName = usernameController.text;
      await context.read<AuthService>().loginUser(usernameController.text);
      Navigator.pushReplacementNamed(context, '/chatlist',
          arguments: usernameController.text);
    }
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
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
                hintText: 'Username',
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
                hintText: 'Password',
              ),
              verticalSpecing(24),
            ],
          ),
        ),
        SizedBox(
          height: 42,
          child: ElevatedButton(onPressed: () async {
                await loginUser(context);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(BrandColor.primaryColor), // Correct way
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white), // Text color
              ),
              child: Text(
                'Sign In',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? BrandColor.dark : BrandColor.light,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(12),
          child: LayoutBuilder(
            builder: (context, BoxConstraints constraints){
              if(constraints.maxWidth > 900){
                // web Layout
                return Row(
                  children: [
                    Spacer(flex: 1),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Header(context: context),
                          Footer(),
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
                Header(context: context),
                _buildForm(context),
                Footer()

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


