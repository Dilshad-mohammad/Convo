import 'package:convo/utils/helper_function.dart';
import 'package:flutter/material.dart';

import '../../utils/spacing.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.context,
  });

  final dynamic context;

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Let\'s Sign you in!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25,
            color: dark ? Colors.white : Colors.black
            )),
        Text('Welcome back, You\'ve been missed!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,
            color: dark ? Colors.white : Colors.black)),
        verticalSpecing(24),
        Container(
          height: 240,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(
                      "assets/auth/Mobile login.png")),
              borderRadius: BorderRadius.circular(24)),
        ),
        verticalSpecing(24),
      ],
    );
  }
}