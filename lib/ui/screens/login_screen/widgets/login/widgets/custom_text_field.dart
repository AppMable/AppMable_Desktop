part of '../../../login_screen.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final bool showError;
  final String errorMessage;
  final bool isPasswordField;

  const CustomTextField({
    required this.textEditingController,
    required this.labelText,
    required this.showError,
    required this.errorMessage,
    this.isPasswordField = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          obscureText: isPasswordField,
          enableSuggestions: !isPasswordField,
          autocorrect: !isPasswordField,
          controller: textEditingController,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFf0EDED),
            labelStyle: const TextStyle(color: Colors.grey),
            floatingLabelStyle: TextStyle(color: showError ? AppTheme.error600 : const Color(0xFF2596be)),
            labelText: labelText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: showError ? AppTheme.error600 : Colors.grey, width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: showError ? AppTheme.error600 : Colors.grey, width: 0.0),
            ),
          ),
        ),
        showError
            ? Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: AppTheme.error600),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
