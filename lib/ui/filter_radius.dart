import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterRadiusWidget extends StatefulWidget {
  final String filterName;
  final TextEditingController filterValue;
  const FilterRadiusWidget(
      {super.key, required this.filterName, required this.filterValue});

  @override
  State<FilterRadiusWidget> createState() => _FilterRadiusWidgetState();
}

class _FilterRadiusWidgetState extends State<FilterRadiusWidget> {
  bool loading = false;
  double sliderValue = 0;
  // meters
  double radiusMultiplier = 2000;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: widget.filterValue.text != '0' ? true : false,
      title: Text(widget.filterName),
      children: [
        SizedBox(
          width: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextFormField(
              controller: widget.filterValue,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), helperText: "Radius'}"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'enter readius in km';
                }
                return null;
              },
            ),
          ),
        )
      ],
    );
  }
}
