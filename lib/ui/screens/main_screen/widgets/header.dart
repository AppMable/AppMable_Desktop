part of '../main_screen.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

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
          'AppMable',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
