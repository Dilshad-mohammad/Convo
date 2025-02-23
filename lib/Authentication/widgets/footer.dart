import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/spacing.dart';

final _mainurl = 'https://portfolio-six-tawny-60.vercel.app/';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpecing(36),

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
        ),
        verticalSpecing(18),
        InkWell(
          onTap: () async {
            if (!await launchUrlString(_mainurl)) {
              throw 'could not launch url';
            }
          },
          child: Text('Visit my Portfolio',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        ),

      ],
    );
  }
}