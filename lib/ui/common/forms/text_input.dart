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
  final bool isPasswordField;
  final MainAxisSize mainAxisSize;
  final bool withExpanded;

  const TextInput({
    required this.label,
    required this.callback,
    this.value,
    this.placeholder,
    this.isLabelCaption = false,
    this.maxLimitCharacters,
    this.isPasswordField = false,
    this.mainAxisSize = MainAxisSize.max,
    this.withExpanded = true,
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
    return Builder(builder: (context) {
      return widget.withExpanded
          ? Expanded(
              child: _Field(
              _isFocus,
              widget.label,
              widget.placeholder,
              widget.value,
              widget.callback,
              widget.isLabelCaption,
              widget.maxLimitCharacters,
              widget.isPasswordField,
              widget.mainAxisSize,
              _textController,
              _focus,
            ))
          : _Field(
              _isFocus,
              widget.label,
              widget.placeholder,
              widget.value,
              widget.callback,
              widget.isLabelCaption,
              widget.maxLimitCharacters,
              widget.isPasswordField,
              widget.mainAxisSize,
              _textController,
              _focus,
            );
    });
  }
}

class _Field extends StatelessWidget {
  final bool isFocus;
  final String label;
  final String? placeholder;
  final String? value;
  final StringCallback callback;
  final bool isLabelCaption;
  final int? maxLimitCharacters;
  final bool isPasswordField;
  final MainAxisSize mainAxisSize;
  final TextEditingController textController;
  final FocusNode focus;

  const _Field(
    this.isFocus,
    this.label,
    this.placeholder,
    this.value,
    this.callback,
    this.isLabelCaption,
    this.maxLimitCharacters,
    this.isPasswordField,
    this.mainAxisSize,
    this.textController,
    this.focus,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isFocus ? FontWeight.bold : FontWeight.normal,
            fontSize: !isLabelCaption ? 16 : 12,
            color: !isLabelCaption ? AppTheme.neutral800 : AppTheme.neutral400,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: isPasswordField,
          enableSuggestions: !isPasswordField,
          autocorrect: !isPasswordField,
          maxLength: (maxLimitCharacters != null) ? maxLimitCharacters : null,
          controller: textController,
          focusNode: focus,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: Colors.black),
          onChanged: callback,
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
            hintText: placeholder,
            hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: AppTheme.neutral200),
          ),
        ),
      ],
    );
  }
}
