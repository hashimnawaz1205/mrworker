import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:provider/provider.dart';

import '../Details/DetailPage2.dart';
import '../Details/DetailPage3.dart';

class categoryPage extends StatelessWidget {
  const categoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = context.read<DataBase>();
    context.read<DataBase>().ViewAll;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
          title: const Text('All Workers'),
          centerTitle: true,
          backgroundColor: const Color(0xFFEBECED),
          foregroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Consumer<DataBase>(
          builder: (context, value, child) {
            return value.mapViewmore.isEmpty && !value.errorViewmore
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black12,
                      backgroundColor: Colors.black12,
                    ),
                  )
                : value.errorViewmore
                    ? Text(
                        'Oops, something went wrong .${value.errorMessageViewmore}',
                        textAlign: TextAlign.center,
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.mapViewmore['view more'].length,
                        itemBuilder: (context, index) {
                          var map = value.mapViewmore['view more'][index];
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
                                                map['image'].toString()),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                map['name'].toString(),
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
                                              map['city'].toString(),
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
                                                    map['area'].toString(),
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
                                        map['speciality'].toString(),
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
      ),
    );
  }
}
