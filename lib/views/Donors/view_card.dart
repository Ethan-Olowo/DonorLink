
import 'package:flutter/material.dart';

class ViewCard extends StatelessWidget {
  const ViewCard({super.key, viewType, });

  @override
  Widget build(BuildContext context) {
    
    return Card(
      child: ListTile(
      title: Text('Organisation Name'),
      subtitle: Text('Reason\nDate\nApproval Status'),
      )
    );
  }
}