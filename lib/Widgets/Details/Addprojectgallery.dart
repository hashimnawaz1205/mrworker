import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:provider/provider.dart';

class Addprojectgallery extends StatelessWidget {
  final String id;

  const Addprojectgallery({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();
    var project_id = id;
    print(project_id.toString() + 'Printing project id');

    return Scaffold(
        floatingActionButton: ElevatedButton(
          child: const Text('Post Projects Gallery'),
          onPressed: () {
            dbclass.AddprojectGallery(project_id: id);
          },
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Add Project Gallery',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                dbclass.selectImages();

                print('Gallery button was hit ! will select images now ! ');
              },
              child: Chip(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image,
                          color: Theme.of(context).backgroundColor),
                      Text(
                        "Add Project Gallery",
                        style: GoogleFonts.ubuntu(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Consumer<DataBase>(builder: (context, value, child) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: GridView.builder(
                    itemCount: dbclass.imageFileList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisSpacing: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(
                          File(dbclass.imageFileList![index].path),
                          fit: BoxFit.cover);
                    }),
              );
            }),
          ],
        ));
  }
}
