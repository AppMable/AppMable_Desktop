part of '../main_screen.dart';

class Navigation extends StatefulWidget {
  final VoidCallback onPressedMenuIcon;

  const Navigation({
    required this.onPressedMenuIcon,
    Key? key,
  }) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryButton,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(right: 40, top: 13, bottom: 17),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffB2DF28)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: "Buscar...",
                hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                prefixIcon: Icon(
                  Icons.search,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            onPressed: () {
              if (kDebugMode) {
                print(_textController.text);
              }
            },
            child: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.white,
            iconSize: 28,
            tooltip: 'Seleccionar filtro',
            onPressed: widget.onPressedMenuIcon,
          ),
        ],
      ),
    );
  }
}
