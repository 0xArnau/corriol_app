import 'package:corriol_app/core/constants.dart';
import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  const DropdownButtonWidget({
    super.key,
    required this.itemsList,
    required this.hint,
    required this.onChanged,
  });

  final List itemsList;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String? _valueChoose;

  @override
  void initState() {
    super.initState();
    _valueChoose = widget.itemsList[0];
    // widget.onChanged.call(_valueChoose!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.map_outlined),
        const SizedBox(width: kDouble25),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton(
              hint: Text(widget.hint),
              isExpanded: true,
              style: const TextStyle(color: Colors.black),
              value: _valueChoose,
              onChanged: (newValue) {
                setState(() {
                  _valueChoose = newValue as String;
                });
                widget.onChanged.call(_valueChoose!);
              },
              items: widget.itemsList.map((itemValue) {
                return DropdownMenuItem(
                  value: itemValue,
                  child: Text(itemValue),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
