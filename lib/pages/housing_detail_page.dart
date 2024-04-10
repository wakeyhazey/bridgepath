import 'package:bridgepath/blocs/housing_detail_bloc.dart';
import 'package:bridgepath/ui/housing_location_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NurseHousingDetailPage extends StatelessWidget {
  final Map<String, dynamic> nursinhHomeDetails;
  const NurseHousingDetailPage({super.key, required this.nursinhHomeDetails});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HousingDetailBloc, HousingDetailStates>(
        builder: (context, state) {
      if (state is HousingDetailsPageLoaded) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.forum_outlined)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.mail)),
                    IconButton(
                      onPressed: () {
                        context.read<HousingDetailBloc>().add(ToggleToWishList(
                            housingID: nursinhHomeDetails['id']));
                      },
                      icon: Icon(
                        state.favoritesID.contains(nursinhHomeDetails['id'])
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color:
                            state.favoritesID.contains(nursinhHomeDetails['id'])
                                ? Colors.red
                                : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Text(
                        nursinhHomeDetails['name'],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // TO DO: gridview
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                        child: Image.network(
                          nursinhHomeDetails['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(nursinhHomeDetails['price'].toString()),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type of housing',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              nursinhHomeDetails['type'],
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(nursinhHomeDetails['description']),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Level of medical care',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child:
                                Text(nursinhHomeDetails['medical_care_level']),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Accessibility Features',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                                nursinhHomeDetails['accessibility_features']
                                    .join(',')),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HousingLocationMap(
                        latitude: nursinhHomeDetails['location']['lat'],
                        longitude: nursinhHomeDetails['location']['lon'],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      );
    });
  }
}
