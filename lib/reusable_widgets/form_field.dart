import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderCreditFormField extends StatefulWidget {
  const OrderCreditFormField(
      {super.key,
      this.controller,
      required this.label,
      this.isPasswordField = false});
  final TextEditingController? controller;
  final String label;
  final bool isPasswordField;

  @override
  State<OrderCreditFormField> createState() => _OrderCreditFormFieldState();
}

class _OrderCreditFormFieldState extends State<OrderCreditFormField> {
  final _fieldFocus = FocusNode();
  final _focusNotifier = ValueNotifier(false);
  bool _showPassword = false;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _fieldFocus.addListener(() {
      _focusNotifier.value = _fieldFocus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _focusNotifier,
        builder: (_, hasfocus, __) {
          return Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE8E8E8)),
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    obscureText: !_showPassword,
                    obscuringCharacter: '#',
                    decoration: InputDecoration(
                        labelText: widget.label,
                        labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: hasfocus || _controller.text.isNotEmpty
                                ? Colors.black
                                : const Color(0xFF747474)),
                        border: InputBorder.none),
                    style: const TextStyle(
                      color: Color(0xFF747474),
                      fontSize: 14,
                    ),
                    cursorColor: const Color(0xFF747474),
                    focusNode: _fieldFocus,
                    controller: _controller,
                  ),
                ),
                if (widget.isPasswordField)
                  IconButton(
                    color: const Color(0xFFD5D5D5),
                    icon: Icon(_showPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
              ],
            ),
          );
        });
  }
}

class CalendarFormField extends StatefulWidget {
  const CalendarFormField(
      {super.key, this.controller, required this.label, required this.svgIcon});
  final TextEditingController? controller;
  final String label;
  final String svgIcon;

  @override
  State<CalendarFormField> createState() => _CalendarFormFieldState();
}

class _CalendarFormFieldState extends State<CalendarFormField> {
  final _fieldFocus = FocusNode();
  final _focusNotifier = ValueNotifier(false);
  late final TextEditingController _controller;
  DateTime _initialDate = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _fieldFocus.addListener(() {
      _focusNotifier.value = _fieldFocus.hasFocus;
    });
  }

  void _selectDate() {
    var lastDate = DateTime(
        DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
    showDatePicker(
            context: context,
            initialDate: _initialDate,
            firstDate: DateTime(1900),
            lastDate: lastDate)
        .then((date) {
      if (date != null) {
        setState(() {
          _initialDate = date;
        });
        _controller.text = formatedDate();
      }
    });
  }

  String formatedDate() {
    var dd = _initialDate.day.toString().padLeft(2, '0');
    var mm = _initialDate.month.toString().padLeft(2, '0');
    var yyyyy = _initialDate.year.toString().padLeft(4, '0');
    return '$dd/$mm/$yyyyy';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _focusNotifier,
        builder: (_, hasfocus, __) {
          return Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE8E8E8)),
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    onTap: _selectDate,
                    decoration: InputDecoration(
                        labelText: widget.label,
                        labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: hasfocus || _controller.text.isNotEmpty
                                ? Colors.black
                                : const Color(0xFF747474)),
                        border: InputBorder.none),
                    style: const TextStyle(
                      color: Color(0xFF747474),
                      fontSize: 14,
                    ),
                    cursorColor: const Color(0xFF747474),
                    focusNode: _fieldFocus,
                    controller: _controller,
                  ),
                ),
                IconButton(
                  color: const Color(0xFFD5D5D5),
                  icon: SvgPicture.asset(widget.svgIcon),
                  onPressed: _selectDate,
                ),
              ],
            ),
          );
        });
  }
}

class OrderCreditFormFieldWithDropdown<T> extends StatefulWidget {
  const OrderCreditFormFieldWithDropdown(
      {super.key,
      this.controller,
      required this.label,
      this.value,
      required this.onChanged,
      required this.items});
  final TextEditingController? controller;
  final String label;
  final T? value;
  final void Function(T?) onChanged;
  final List<DropdownMenuItem<T>>? items;

  @override
  State<OrderCreditFormFieldWithDropdown> createState() =>
      _OrderCreditFormFieldWithDropdownState<T>();
}

class _OrderCreditFormFieldWithDropdownState<T>
    extends State<OrderCreditFormFieldWithDropdown<T>> {
  final _fieldFocus = FocusNode();
  final _focusNotifier = ValueNotifier(false);
  T? _value;

  @override
  void initState() {
    super.initState();
    _fieldFocus.addListener(() {
      _focusNotifier.value = _fieldFocus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _focusNotifier,
        builder: (_, hasfocus, __) {
          return Container(
            height: 50,
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE8E8E8)),
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<T>(
                    isDense: true,
                    icon: const SizedBox.shrink(),
                    iconSize: 0,
                    items: widget.items,
                    onChanged: (value) {
                      _value = value;
                      widget.onChanged.call(value);
                    },
                    value: widget.value,
                    decoration: InputDecoration(
                        labelText: widget.label,
                        labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: hasfocus || _value != null
                                ? Colors.black
                                : const Color(0xFF747474)),
                        border: InputBorder.none),
                    style: const TextStyle(
                      color: Color(0xFF747474),
                      fontSize: 14,
                    ),
                    focusNode: _fieldFocus,
                  ),
                ),
                const Icon(Icons.arrow_drop_down)
              ],
            ),
          );
        });
  }
}
