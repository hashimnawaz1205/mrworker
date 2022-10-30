import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/Screens/emergencyScreen.dart';

class EmergencyServices extends StatelessWidget {
  const EmergencyServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text('Directory of Emergency Services \n in your City'),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFa51b1f),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmergencyScreen(),
                      ),
                    );
                  },
                  child: Text('Emergency Services',
                      style: GoogleFonts.montserrat()),
                ),
              ],
            ),
            Expanded(
              child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.cover,
                  imageUrl: 'https://mrworker.pk/img/emergency_services.jpeg'),
            ),
          ],
        ),
      ),
    );
  }
}
