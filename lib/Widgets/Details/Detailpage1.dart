import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class DetailPage1 extends StatelessWidget {
  final Map<String, dynamic> map;

  DetailPage1({Key? key, required this.map}) : super(key: key);
  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: "+92" + map['whatsapp'],
      text:
          "Hey! I'm inquiring about the Services which you provid on Mr.Worker",
    );
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launch" method is part of "url_launcher".
    await launch('$link');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFEBECED),
          foregroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(map['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 222, 218, 218),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(map['tags'].toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      // Row(
                      //   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     SizedBox(
                      //
                      //
                      //       child: SingleChildScrollView(
                      //         scrollDirection:Axis.horizontal,
                      //
                      //
                      //         child: Text(
                      //           map['tags'],overflow: TextOverflow.ellipsis,
                      //           style: TextStyle(
                      //               fontSize: 20, fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //     ),
                      //     Spacer(),
                      //     // Expanded(child: Icon(Icons.share)),
                      //   ],
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          map['name'].toString(),
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on),
                          Expanded(
                            child: Text(
                              map['area'].toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 2.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'About ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            //color: Colors.purple),
                          ),
                        ),
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
                            // fontWeight: FontWeight.bold,
                            // color: Color.fromARGB(255, 245, 251, 249),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  elevation: 5.0,
                                ),
                                onPressed: () => launch("tel:" + map['phone']),
                                child: Row(
                                  children: const [
                                    FaIcon(
                                      FontAwesomeIcons.phone,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      'Call Now',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey,
                                    elevation: 5.0,
                                  ),
                                  onPressed: () async {
                                    await launchWhatsApp();
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        'Whatsapp Now',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
