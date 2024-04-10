import 'package:bridgepath/blocs/home_page_bloc.dart' as homeBloc;
import 'package:bridgepath/blocs/housing_detail_bloc.dart';
import 'package:bridgepath/pages/housing_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HousingDetailCard extends StatelessWidget {
  final Map<String, dynamic> housingDetail;
  final List favoritesID;
  final bool inListing;
  const HousingDetailCard(
      {super.key,
      required this.housingDetail,
      required this.favoritesID,
      required this.inListing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
                create: (context) =>
                    HousingDetailBloc()..add(InitializeHousingDetailData()),
                child:
                    NurseHousingDetailPage(nursinhHomeDetails: housingDetail)),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                  child: Image.network(
                    housingDetail['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      context.read<homeBloc.HomePageBloc>().add(
                          homeBloc.ToggleToWishList(
                              housingID: housingDetail['id'],
                              inListing: inListing));
                    },
                    icon: Icon(
                      favoritesID.contains(housingDetail['id'])
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: favoritesID.contains(housingDetail['id'])
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    housingDetail['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    housingDetail['address'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        housingDetail['rating'].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
