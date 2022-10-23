part of '../dashboard_screen.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryBox(
      suffix: Container(),
      title: "User Info",
      children: [
        Expanded(
          child: _userInfo(),
        ),
      ],
    );
  }

  Widget _userInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Styles.defaultLightWhiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Text('Nombre usuario:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text('Amaresma'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Text('Nombre usuario:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text('Amaresma'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Text('Nombre usuario:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text('Amaresma'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Text('Nombre usuario:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text('Amaresma'),
            ],
          ),
          const SizedBox(height: 50),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(AppTheme.primary900),
              overlayColor: MaterialStateProperty.all<Color>(AppTheme.primary200),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: () {
              print('logout');
            },
            child: const Text(
              'Cerrar Sessión',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
