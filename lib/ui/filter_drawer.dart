import 'package:bridgepath/blocs/home_page_bloc.dart';
import 'package:bridgepath/ui/filter_with_list_widget.dart';
import 'package:bridgepath/ui/filter_with_number.dart';
import 'package:bridgepath/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDrawer extends StatelessWidget {
  final Map selectedFilters;
  const FilterDrawer({super.key, required this.selectedFilters});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ...filters.entries.map((entry) {
            switch (entry.key) {
              case "price":
                return FilterWithNumberWidget(
                  filterName: entry.key,
                  filterValue: selectedFilters[entry.key],
                  rating: false,
                );
              // case "location":
              //   return FilterRadiusWidget(
              //       filterName: entry.key,
              //       filterValue: selectedFilters['radius']);
              case "rating":
                return FilterWithNumberWidget(
                  filterName: entry.key,
                  filterValue: selectedFilters[entry.key],
                  rating: true,
                );
              default:
                return FilterWithListOptionsWidget(
                  filterName: entry.key,
                  filterOptions: entry.value,
                  selectedOptions: selectedFilters[entry.key],
                );
            }
          }).toList(),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<HomePageBloc>().add(ApplyFilter());
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: const Text('Apply'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: SizedBox(
              width: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.read<HomePageBloc>().add(ClearFilters());
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(), backgroundColor: Colors.red),
                child: const Text('Clear filter'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
