import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.greenAccent,
      ),
      child: const Align(
        alignment: Alignment.center,
        child: Text(
          'Footer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
