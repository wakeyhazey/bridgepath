import 'package:bridgepath/blocs/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAppBar extends StatelessWidget {
  SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Nursing Homes',
            //   // style: CustomTextStyle.title02,
            // ),
            TextField(
              controller: context.read<HomePageBloc>().searchTerm,
              decoration: InputDecoration(
                  suffixIcon:
                      context.read<HomePageBloc>().searchTerm.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                context.read<HomePageBloc>().add(SearchListings(
                                    searchString: context
                                        .read<HomePageBloc>()
                                        .searchTerm
                                        .text = ''));
                              },
                              icon: const Icon(Icons.close),
                            ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Search for a home',
                  // hintStyle: CustomTextStyle.hint,
                  filled: true,
                  fillColor: const Color(0xffEBEBEB)),
              onTapOutside: (PointerDownEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: (value) {
                context.read<HomePageBloc>().add(SearchListings(
                    searchString:
                        context.read<HomePageBloc>().searchTerm.text));
              },
            ),
          ],
        ),
      ),
    );
  }
}
