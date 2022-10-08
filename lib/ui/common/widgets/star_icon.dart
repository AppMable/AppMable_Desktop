import 'package:flutter/material.dart';

class StarIcon extends StatelessWidget {
  final bool isActive;

  const StarIcon({
    Key? key,
    this.isActive = false,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
        color: const Color(0xFFF0F0F0),
      ),
      child: Icon(
        Icons.star,
        color: isActive ? const Color(0xFFEEBA00) : const Color(0xFFB9B9B9),
        size: 32,
      ),
    );
  }
}
