import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:provider/provider.dart';

class Addprojectdetail extends StatelessWidget {
  const Addprojectdetail({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();
    var TitleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project'),
        backgroundColor: const Color(0xFFEBECED),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  var pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  dbclass.setProjectImage(File(pickedFile!.path));
                },
                child: Consumer<DataBase>(builder: (context, value, child) {
                  return value.ProjectImage != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            child: Image.file(
                              value.ProjectImage!,
                              fit: BoxFit.contain,
                              width: 200,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: MediaQuery.of(context).size.width,
                            height: 70,
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Colors.black,
                                ),
                                Text('Choice Project Primary Image'),
                              ],
                            )),
                          ));
                }),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       border: Border.all(color: Colors.black)
                //     ),
                //     width: MediaQuery.of(context).size.width,
                //     height: 70,
                //     child: Center(child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(Icons.image,color: Colors.black,),
                //         Text('Choice Project Image'),
                //       ],
                //     )),
                //   ),
                // ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: TitleController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      labelText: 'Tittle',
                      labelStyle: GoogleFonts.ubuntu()),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
              ),

              // InkWell(
              //   onTap: () async {
              //     dbclass.selectImages();
              //
              //     print(
              //         'Gallery button was hit ! will select images now ! ');
              //
              //   },
              //   child: Chip(
              //     backgroundColor: Theme.of(context).primaryColor,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20)),
              //     label: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(Icons.image,
              //               color: Theme.of(context).backgroundColor),
              //           Text(
              //             "Add Project Gallery",
              //             style: GoogleFonts.ubuntu(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //                 color: Colors.white),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20),

              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    var user_id = id.toString();
                    var title = TitleController.text.toString();
                    dbclass.Addproject(user_id: user_id, title: title);
                  },
                  child: Text(
                    'Post Project',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
