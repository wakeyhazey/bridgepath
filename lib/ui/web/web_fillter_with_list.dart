import 'package:bridgepath/blocs/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebFilterWithListOptionsWidget extends StatefulWidget {
  final String filterName;
  final List filterOptions;
  final List selectedOptions;
  const WebFilterWithListOptionsWidget(
      {super.key,
      required this.filterName,
      required this.filterOptions,
      required this.selectedOptions});

  @override
  State<WebFilterWithListOptionsWidget> createState() =>
      _WebFilterWithListOptionsWidgetState();
}

class _WebFilterWithListOptionsWidgetState
    extends State<WebFilterWithListOptionsWidget> {
  List selected = [];

  @override
  void initState() {
    selected = widget.selectedOptions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.filterName} options'),
      content: SizedBox(
        width: 300,
        height: widget.filterOptions.length * 50,
        child: Column(
          children: widget.filterOptions.map((e) {
            return ListTile(
              title: Text(e),
              trailing: IconButton(
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
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {},
            child: const Text(
              'clear',
              style: TextStyle(color: Colors.red),
            )),
        TextButton(onPressed: () {}, child: const Text('update'))
      ],
    );
  }
}
