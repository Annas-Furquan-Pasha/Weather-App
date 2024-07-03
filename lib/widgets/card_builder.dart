import 'package:flutter/material.dart';

class CardBuilder extends StatelessWidget {
  const CardBuilder({super.key, required this.data, required this.color, required this.icon});

  final String data;
  final Color color;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.5),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
          leading: icon,
          title: Text(data, style: Theme.of(context).textTheme.bodyLarge,),
        ),
      ),
    );
  }
}
