import 'package:bridgepath/blocs/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterWithListOptionsWidget extends StatefulWidget {
  final String filterName;
  final List filterOptions;
  final List selectedOptions;
  const FilterWithListOptionsWidget(
      {super.key,
      required this.filterName,
      required this.filterOptions,
      required this.selectedOptions});

  @override
  State<FilterWithListOptionsWidget> createState() =>
      _FilterWithListOptionsWidgetState();
}

class _FilterWithListOptionsWidgetState
    extends State<FilterWithListOptionsWidget> {
  List selected = [];

  @override
  void initState() {
    selected = widget.selectedOptions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: selected.isEmpty ? false : true,
      title: Text(widget.filterName),
      children: widget.filterOptions.map((e) {
        return ListTile(
          title: Text(e),
          leading: IconButton(
            onPressed: () {
              setState(() {
                if (selected.contains(e)) {
                  selected.remove(e);
                } else {
                  selected.add(e);
                }
              });
              context.read<HomePageBloc>().add(UpdateFilter(
                  filterName: widget.filterName, filter: selected));
            },
            icon: Icon(selected.contains(e)
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked),
          ),
        );
      }).toList(),
    );
  }
}
