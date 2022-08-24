import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  Stars({
    Key? key,
    required this.count,
    this.size,
  }) : super(key: key);
  final int count;
  final double? size;
  List<Icon> starts = [];

  @override
  Widget build(BuildContext context) {
    for (var i = 1; i <= count; i++) {
      starts.add(
        i <= count
            ? Icon(
                Icons.star,
                color: const Color(0xffffd700),
                size: size ?? 15,
              )
            : const Icon(
                Icons.star_border,
                size: 15,
                color: Colors.grey,
              ),
      );
    }
    return Row(
      children: starts,
    );
  }
}
