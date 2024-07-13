
// ignore_for_file: must_be_immutable

import 'package:donorlink/Models/User.dart';
import 'package:flutter/material.dart';

class ViewElement extends StatelessWidget{
  String title;
  final Object element;
  final User user;
  final Widget? leading;
  final List<Widget>? actions;
  final List<Widget>? extensions;
  ViewElement({super.key, required this.element, required this.user, required this.title, this.leading, this.actions, this.extensions});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
        leading: leading,
        actions: actions,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [ 
          Text(title, style: Theme.of(context).textTheme.headlineSmall,),
          Text(element.toString()),
          for(Widget widget in extensions!)widget,
      ])
    );
  }

}