import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterWithNumberWidget extends StatefulWidget {
  final String filterName;
  final List filterValue;
  final bool rating;

  FilterWithNumberWidget(
      {required this.filterName,
      required this.filterValue,
      required this.rating});

  @override
  State<FilterWithNumberWidget> createState() => _FilterWithNumberWidgetState();
}

class _FilterWithNumberWidgetState extends State<FilterWithNumberWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded:
          widget.filterValue[0].text != '0' || widget.filterValue[1].text != '0'
              ? true
              : false,
      title: Text(widget.filterName),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: widget.filterValue[0],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      helperText: "Min ${widget.rating ? "rating" : 'price'}"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter a minimum price';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: widget.filterValue[1],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      helperText: "Max ${widget.rating ? "rating" : 'price'}"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter a maximum price';
                    }
                    return null;
                  },
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
