import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/hope.jpg'), 
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45,BlendMode.darken),
            )
      )
    );
  }
}

