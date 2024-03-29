import 'package:corriol_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CounterButtonWidget extends StatefulWidget {
  const CounterButtonWidget({
    super.key,
    required this.hint,
    required this.image,
    required this.onChanged,
  });

  final String hint;
  final AssetImage image;
  final ValueChanged<int> onChanged;

  @override
  State<CounterButtonWidget> createState() => _CounterButtonWidgetState();
}

class _CounterButtonWidgetState extends State<CounterButtonWidget> {
  int _count = 0;

  void _increment() {
    if (mounted) {
      setState(() {
        _count++;
      });
    }
    widget.onChanged.call(_count);
  }

  void _decrement() {
    if (mounted) {
      setState(() {
        if (_count > 0) _count--;
      });
    }
    widget.onChanged.call(_count);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: widget.image,
          width: 24.0,
          height: 24.0,
        ),
        const SizedBox(width: kDouble25),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: kColorDropDown),
              color: kColorDropDown,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.hint),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: _decrement,
            ),
            Text(
              '$_count',
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _increment,
            ),
          ],
        )
      ],
    );
  }
}
