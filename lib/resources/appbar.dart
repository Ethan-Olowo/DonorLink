import 'package:flutter/material.dart';

class Bar extends AppBar{
  @override
  final double toolbarHeight = 50;
  @override
  final Widget title = const Image(
    image: AssetImage('assets/images/NamedLogo.png'),
    height: 48,
  );

  Bar({super.key, super.leading,
    super.actions,
  });

    
}
