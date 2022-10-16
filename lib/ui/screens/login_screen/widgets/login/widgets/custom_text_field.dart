part of '../../../login_screen.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final bool showError;
  final String errorMessage;

  const CustomTextField({
    required this.textEditingController,
    required this.labelText,
    required this.showError,
    required this.errorMessage,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.textEditingController,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFf0EDED),
            labelStyle: const TextStyle(color: Colors.grey),
            floatingLabelStyle: TextStyle(
                color: widget.showError
                    ? AppTheme.error600
                    : const Color(0xFF2596be)),
            labelText: widget.labelText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.showError ? AppTheme.error600 : Colors.grey,
                  width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.showError ? AppTheme.error600 : Colors.grey,
                  width: 0.0),
            ),
          ),
        ),
        widget.showError
            ? Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    widget.errorMessage,
                    style: const TextStyle(color: AppTheme.error600),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
