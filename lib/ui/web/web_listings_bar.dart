import 'package:bridgepath/blocs/home_page_bloc.dart';
import 'package:bridgepath/ui/search_bar.dart';
import 'package:bridgepath/ui/web/web_filter_with_list.dart';
import 'package:bridgepath/ui/web/web_filter_with_number.dart';
import 'package:bridgepath/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebTopBarListsingWidget extends StatelessWidget {
  final Map<String, dynamic> selectedFilters;
  const WebTopBarListsingWidget({super.key, required this.selectedFilters});

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widthSize,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(width: 300, child: SearchAppBar()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...filters.entries.map((entry) {
                  switch (entry.key) {
                    case "price":
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return WebFilterWithNumberRange(
                                    filterName: entry.key,
                                    filterValue: selectedFilters[entry.key],
                                    rating: false,
                                  );
                                });
                          },
                          style: OutlinedButton.styleFrom(
                            shape: const StadiumBorder(),
                          ),
                          child: Text(entry.key),
                        ),
                      );
                    // case "location":
                    //   return FilterRadiusWidget(
                    //       filterName: entry.key,
                    //       filterValue: selectedFilters['radius']);
                    case "rating":
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return WebFilterWithNumberRange(
                                    filterName: entry.key,
                                    filterValue: selectedFilters[entry.key],
                                    rating: true,
                                  );
                                });
                          },
                          style: OutlinedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: (selectedFilters[entry.key][1]
                                            as TextEditingController)
                                        .text ==
                                    '0'
                                ? null
                                : Colors.red.withOpacity(0.5),
                          ),
                          child: Text(entry.key),
                        ),
                      );

                    default:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return WebFilterWithListOptionsWidget(
                                    filterName: entry.key,
                                    filterOptions: entry.value,
                                    selectedOptions: selectedFilters[entry.key],
                                  );
                                });
                          },
                          style: OutlinedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: selectedFilters[entry.key].isEmpty
                                ? null
                                : Colors.red.withOpacity(0.5),
                          ),
                          child: Text(entry.key),
                        ),
                      );
                  }
                }),
                TextButton(
                    onPressed: () {
                      context.read<HomePageBloc>().add(ClearFilters());
                    },
                    child: const Text(
                      'Clear all filter',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
