import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:mrworker/Widgets/Details/Addprojectdetail.dart';
import 'package:mrworker/Widgets/Details/Addprojectgallery.dart';
import 'package:provider/provider.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({Key? key, required this.user_id}) : super(key: key);
  final String user_id;

  @override
  Widget build(BuildContext context) {
    final id = user_id.toString();
    var dbclass = context.read<DataBase>();
    dbclass.fetchProjects(user_id);
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Addprojectdetail(
                id: id,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child: const Text('Add Projects'),
      ),
      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: const Color(0xFFEBECED),
        foregroundColor: Colors.black,
      ),
      body: Consumer<DataBase>(
        builder: (context, value, child) {
          return value.mapProjects.isEmpty && !value.errorProjects
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black12,
                    backgroundColor: Colors.black12,
                  ),
                )
              : value.errorProjects
                  ? const Text(
                      'No Records found.',
                      textAlign: TextAlign.center,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: value.mapProjects['projects'].length,
                      itemBuilder: (context, index) {
                        var map = value.mapProjects['projects'][index];
                        String primaryImage = map['primary_image'];

                        return GestureDetector(
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (_) => imageDialog(
                                    map['title'].toString(),
                                    map['project_images'],
                                    context,
                                    dbclass,
                                    user_id));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            width: 350,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    imageUrl: primaryImage,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 250),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    color: Colors.white54,
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                map['title'],
                                                style: GoogleFonts.ubuntu(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                Addprojectgallery(
                                                                    id: map[
                                                                        'project_id']),
                                                          ),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 5,
                                                                bottom: 5),
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      child: const Text(
                                                          'Add gallery')),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  const Icon(Icons
                                                                      .photo_library_outlined),
                                                                  const Text(
                                                                    'Alert',
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Icon(
                                                                        Icons
                                                                            .clear),
                                                                  ),
                                                                ],
                                                              ),
                                                              content: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child: Text('Are you sure you want to delete \n' +
                                                                        map['title'] +
                                                                        '\n All the data inside will be removed.'),
                                                                  ),
                                                                  const SizedBox(
                                                                    height:
                                                                        10.0,
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            foregroundColor:
                                                                                MaterialStateProperty.all<Color>(Colors.white),
                                                                            backgroundColor:
                                                                                MaterialStateProperty.all<Color>(
                                                                              const Color(0xFF198754),
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            await dbclass.removeProject(map['project_id']);
                                                                            dbclass.fetchProjects(user_id);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text('Yes')),
                                                                      ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            foregroundColor:
                                                                                MaterialStateProperty.all<Color>(Colors.white),
                                                                            backgroundColor:
                                                                                MaterialStateProperty.all<Color>(
                                                                              const Color(0xFFa51b1f),
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text('No'))
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Theme.of(context)
                                                          .primaryColor,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10,
                                                              top: 5,
                                                              bottom: 5),
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    child: const Text('Remove'),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        // CircleIconButton(
                                        //     iconUrl: 'assets/icons/mark.svg',
                                        //     color: Theme.of(context).primaryColor)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.94,
                          //   child: Card(
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(0.0),
                          //     ),
                          //     color: Colors.white70,
                          //     elevation: 10,
                          //     child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: <Widget>[
                          //         Padding(
                          //           padding: const EdgeInsets.all(2.0),
                          //           child: ConstrainedBox(
                          //             constraints: BoxConstraints(
                          //               maxWidth: MediaQuery.of(context).size.width * 0.28,
                          //               maxHeight: MediaQuery.of(context).size.width * 0.28,
                          //             ),
                          //             child:CachedNetworkImage(
                          //               height: 130,
                          //
                          //                     imageUrl: primaryImage,
                          //                     fit: BoxFit.cover,
                          //                   ),
                          //           ),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only( left:8 ,top: 50),
                          //           child: Text(map['title'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          //         ),
                          //         // Column(
                          //         //   crossAxisAlignment: CrossAxisAlignment.start,
                          //         //   children: <Widget>[
                          //         //
                          //         //     Container(
                          //         //
                          //         //       alignment: Alignment.center,
                          //         //       width: MediaQuery.of(context).size.width * 0.5,
                          //         //       child: Center(
                          //         //         child: Padding(
                          //         //           padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          //         //           child:
                          //         //           Text(map['title'].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                          //         //         ),
                          //         //       ),
                          //         //     ),
                          //         //   ],
                          //         // ),
                          //       ],
                          //     ),
                          //   )),
                        );

                        //   Card(
                        //
                        //   child: ListTile(
                        //     onTap: () async {
                        //       await showDialog(
                        //           context: context,
                        //           builder: (_) => imageDialog(
                        //               map['title'].toString(),
                        //               map['project_images'],
                        //               context));
                        //     },
                        //     leading:  ConstrainedBox(
                        // constraints: BoxConstraints(
                        // minWidth: 100,
                        // minHeight: 260,
                        // maxWidth: 104,
                        // maxHeight: 364,
                        // ),
                        //   child:  CachedNetworkImage(
                        //       width: 200,
                        //       height: 230,
                        //       imageUrl: primaryImage,
                        //       fit: BoxFit.cover,
                        //     )),
                        //     title: Text(map['title'].toString()),
                        //   ),
                        // );
                      },
                    );
        },
      ),
    );
  }
}

Widget imageDialog(text, list, context, dbclass, user_id) {
  final List<dynamic> finalList = list;
  print(finalList.toString());
  return Dialog(
    // backgroundColor: Colors.transparent,
    // elevation: 0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$text',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_rounded),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
        Container(
            decoration: const BoxDecoration(color: Colors.grey),
            width: 250,
            height: 450,
            child: CarouselSlider.builder(
              itemCount: finalList.length,
              itemBuilder: (context, itemIndex, realIndex) {
                // return Text(itemIndex.toString());
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: 250.0,
                        height: 250.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  finalList[itemIndex]['image_link']
                                      .toString()),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFa51b1f),
                          ),
                        ),
                        onPressed: () {
                          dbclass.removeGalleryImage(
                              finalList[itemIndex]['id'].toString());
                          print(finalList[itemIndex]['id'].toString());
                          dbclass.fetchProjects(user_id);
                          Navigator.pop(context);
                        },
                        child: (finalList[itemIndex]['id'].toString() == 'null')
                            ? Text('Primary Photo')
                            : Text('Remove'),
                      )
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
              ),
            )
            //here !

            ),
      ],
    ),
  );
}
