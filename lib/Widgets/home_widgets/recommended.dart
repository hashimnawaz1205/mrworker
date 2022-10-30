import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:mrworker/Widgets/home_widgets/categoryPage.dart';
import 'package:provider/provider.dart';
import '../Details/DetailPage2.dart';

class Recommended extends StatelessWidget {
  const Recommended({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Recommendations',
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  print('List of All Registered Workers.');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const categoryPage(),
                    ),
                  );
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFa51b1f)),
                ),
              )
            ],
          ),
        ),
        Consumer<DataBase>(
          builder: (context, value, child) {
            return value.mapRecommendation.isEmpty && !value.errorRecommendation
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black12,
                      backgroundColor: Colors.black12,
                    ),
                  )
                : value.errorRecommendation
                    ? Text(
                        'Oops, something went wrong .${value.errorMessageRecommendation}',
                        textAlign: TextAlign.center,
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            value.mapRecommendation['service_search'].length,
                        itemBuilder: (context, index) {
                          var map =
                              value.mapRecommendation['service_search'][index];
                          return GestureDetector(
                            onTap: () {
                              print(map);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailPage2(map: map);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                                map['image']),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                map['name'],
                                                style: GoogleFonts.ubuntu(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              map['city'],
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 12.0,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.black,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    map['area'],
                                                    maxLines: 1,
                                                    style: GoogleFonts.ubuntu(
                                                        fontSize: 12.0,
                                                        color: Colors.black),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        map['speciality'],
                                        style: GoogleFonts.ubuntu(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
          },
        ),
      ],
    );
  }
}
