import 'package:flutter/material.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

typedef DateTimeCallback = void Function(DateTime val);

class DateTimePickerInput extends StatefulWidget {
  final String label;
  final String? placeholder;
  final DateTime? value;
  final DateTimeCallback callback;
  final bool isLabelCaption;
  final MainAxisSize mainAxisSize;
  final bool withExpanded;
  final Function()? onTap;

  const DateTimePickerInput({
    required this.label,
    required this.callback,
    this.value,
    this.placeholder,
    this.isLabelCaption = false,
    this.mainAxisSize = MainAxisSize.max,
    this.withExpanded = true,
    this.onTap,
    super.key,
  });

  @override
  State<DateTimePickerInput> createState() => _TextInputState();
}

class _TextInputState extends State<DateTimePickerInput> {
  final FocusNode _focus = FocusNode();
  final TextEditingController _textController = TextEditingController();
  bool _isFocus = false;

  @override
  void initState() {
    super.initState();
    _textController.text = widget.value != null ? DateFormat('dd-MM-yyyy HH:mm').format(widget.value!) : '';
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
              widget.mainAxisSize,
              _textController,
              _focus,
              widget.onTap,
            ))
          : _Field(
              _isFocus,
              widget.label,
              widget.placeholder,
              widget.value,
              widget.callback,
              widget.isLabelCaption,
              widget.mainAxisSize,
              _textController,
              _focus,
              widget.onTap,
            );
    });
  }
}

class _Field extends StatelessWidget {
  final bool isFocus;
  final String label;
  final String? placeholder;
  final DateTime? value;
  final DateTimeCallback callback;
  final bool isLabelCaption;
  final MainAxisSize mainAxisSize;
  final TextEditingController textController;
  final FocusNode focus;
  final Function()? onTap;

  const _Field(
    this.isFocus,
    this.label,
    this.placeholder,
    this.value,
    this.callback,
    this.isLabelCaption,
    this.mainAxisSize,
    this.textController,
    this.focus,
    this.onTap,
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
          onTap: () {

            DateTime currentTime = value == null ? DateTime.now() : value!;

            DatePicker.showDateTimePicker(
              context,
              showTitleActions: true,
              currentTime: currentTime,
              minTime: DateTime(currentTime.year - 2, currentTime.month, currentTime.day, currentTime.hour, currentTime.minute),
              maxTime: DateTime(currentTime.year + 2, currentTime.month, currentTime.day, currentTime.hour, currentTime.minute),
              onConfirm: (DateTime date) {
                String dateFormatted = DateFormat('dd-MM-yyyy HH:mm').format(date);

                callback(date);
                textController.text = dateFormatted;
              },
              locale: LocaleType.es,
            );
          },
          readOnly: true,
          autocorrect: false,
          controller: textController,
          focusNode: focus,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: Colors.black),
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
