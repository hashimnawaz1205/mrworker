import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class DetailPage2 extends StatelessWidget {
  DetailPage2({Key? key, required this.map}) : super(key: key);
  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: "+92" + map['whatsapp'],
      text: "Hey!" +
          map['name'] +
          "." +
          "I'm inquiring about the Services which you provid on Mr.Worker",
    );
    await launch('$link');
  }

  Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    String tags = map['tags'];
    List<String> tlist = tags.split(",");
    var dbclass = context.read<DataBase>();
    dbclass.fetchProjects(map['id']);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 218, 218),
      appBar: AppBar(
          backgroundColor: const Color(0xFFEBECED),
          foregroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 222, 218, 218),
              ),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: map['image'].toString(),
                        imageBuilder: (context, imageProvider) => Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          color: Colors.black12,
                          backgroundColor: Colors.black12,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      title: Text(
                        map['name'].toString(),
                        style: GoogleFonts.ubuntu(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      trailing: SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(1.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green),
                                ),
                                onPressed: () async {
                                  await launchWhatsApp();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Icon(FontAwesomeIcons.whatsapp),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 1.0,
                            ),
                            Container(
                              margin: const EdgeInsets.all(1.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                ),
                                onPressed: () => launch(
                                  "tel:" + map['phone'].toString(),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Icon(FontAwesomeIcons.phone),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(map['city'].toString()),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Center(
                        child: Text(
                      map['speciality'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 26),
                    )
                        // ListView.builder(
                        //     shrinkWrap: true,
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: tlist.length,
                        //     itemBuilder: (context, index) {
                        //       return Card(
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(3.0),
                        //           child: Text(
                        //             '#' + tlist[index].toString(),
                        //           ),
                        //         ),
                        //       );
                        //     }),
                        ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.drive_file_rename_outline),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              map['name'].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.location_city),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Phone',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              map['phone'].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.location_city),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'City',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              map['city'].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Area',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              map['area'].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.email),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              map['email'].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.account_box_outlined),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'About',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              map['about'].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Projects',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<DataBase>(
                            builder: (context, value, child) {
                              return value.mapProjects.isEmpty &&
                                      !value.errorProjects
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
                                          itemCount: value
                                              .mapProjects['projects'].length,
                                          itemBuilder: (context, index) {
                                            var map = value
                                                .mapProjects['projects'][index];
                                            String primaryImage =
                                                map['primary_image'];

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: ListTile(
                                                onTap: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (_) => imageDialog(
                                                          map['title']
                                                              .toString(),
                                                          map['project_images'],
                                                          context));
                                                },
                                                leading: CachedNetworkImage(
                                                  width: 50,
                                                  height: 50,
                                                  imageUrl: primaryImage,
                                                  fit: BoxFit.cover,
                                                ),
                                                title: Text(
                                                    map['title'].toString()),
                                              ),
                                            );
                                          },
                                        );
                            },
                          ),
                        ),
                      ],
                    ),
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

Widget imageDialog(text, list, context) {
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
                style: const TextStyle(fontWeight: FontWeight.bold),
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
        SizedBox(
            width: 220,
            height: 200,
            child: CarouselSlider.builder(
              itemCount: finalList.length,
              itemBuilder: (context, itemIndex, realIndex) {
                // return Text(itemIndex.toString());
                return CachedNetworkImage(
                  width: 220,
                  height: 200,
                  imageUrl: finalList[itemIndex]['image_link'],
                  fit: BoxFit.cover,
                );
              },
              options: CarouselOptions(
                autoPlay: true,
              ),
            )
            //here !

            ),
      ],
    ),
  );
}
