import 'package:flutter/material.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';

typedef StringCallback = void Function(String val);

class TextInput extends StatefulWidget {
  final String label;
  final String? placeholder;
  final String? value;
  final StringCallback callback;
  final bool isLabelCaption;
  final int? maxLimitCharacters;

  const TextInput({
    required this.label,
    required this.callback,
    this.value,
    this.placeholder,
    this.isLabelCaption = false,
    this.maxLimitCharacters,
    super.key,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final FocusNode _focus = FocusNode();
  final TextEditingController _textController = TextEditingController();
  bool _isFocus = false;

  @override
  void initState() {
    super.initState();
    _textController.text = widget.value ?? '';
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focus
      ..removeListener(_onFocusChange)
      ..dispose();
    _textController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _isFocus = !_isFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontWeight: _isFocus ? FontWeight.bold : FontWeight.normal,
              fontSize: !widget.isLabelCaption ? 16 : 12,
              color: !widget.isLabelCaption ? AppTheme.neutral800 : AppTheme.neutral400,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            maxLength: (widget.maxLimitCharacters != null) ? widget.maxLimitCharacters : null,
            controller: _textController,
            focusNode: _focus,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.black),
            onChanged: widget.callback,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primary600, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.neutral400),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              contentPadding: const EdgeInsets.all(10),
              hintText: widget.placeholder,
              hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: AppTheme.neutral200),
            ),
          ),
        ],
      ),
    );
  }
}