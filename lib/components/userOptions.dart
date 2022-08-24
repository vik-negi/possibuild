import 'package:flutter/material.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
          // color: Colors.white,
        ),
        title: Text(title,
            style: const TextStyle(
                fontSize: 18,
                // color: Colors.white,
                fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_right_sharp,
            // color: Colors.white,
            size: 30),
      ),
    );
  }
}
