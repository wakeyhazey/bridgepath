import 'package:bridgepath/blocs/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebFilterWithNumberRange extends StatefulWidget {
  final String filterName;
  final List filterValue;
  final bool rating;
  const WebFilterWithNumberRange(
      {super.key,
      required this.filterName,
      required this.filterValue,
      required this.rating});

  @override
  State<WebFilterWithNumberRange> createState() =>
      _WebFilterWithNumberRangeState();
}

class _WebFilterWithNumberRangeState extends State<WebFilterWithNumberRange> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.filterName),
      content: Row(
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
          const SizedBox(
            width: 10,
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
      ),
      actions: [
        TextButton(
            onPressed: () {
              context
                  .read<HomePageBloc>()
                  .add(ClearFilters(filterName: widget.filterName));
              Navigator.pop(context);
            },
            child: const Text(
              'clear',
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
            onPressed: () {
              if (double.parse(widget.filterValue[0].text) <=
                  double.parse(widget.filterValue[1].text)) {
                context.read<HomePageBloc>().add(ApplyFilter());
                Navigator.pop(context);
              }
            },
            child: const Text('update'))
      ],
    );
  }
}
