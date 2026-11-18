
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const String githubUrl =
      'https://github.com/AlexisHuda/Assigment_baggage-_calc';

  Future<void> openGitHub() async {
    final Uri url = Uri.parse(githubUrl);

    final bool opened = await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );

    if (!opened) {
      throw Exception('Could not open GitHub repository');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Application'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            // Application Icon

            Container(
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(25),
              ),

              child: const Icon(
                Icons.luggage,
                size: 85,
                color: primaryGreen,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Excess Baggage Calculator',
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,

              child: Text(
                'Author Information',

                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
            ),

            const SizedBox(height: 15),

            const ListTile(
              leading: Icon(
                Icons.person,
                color: primaryGreen,
              ),
              title: Text('Author'),
              subtitle: Text(
                'NUR ALEESYA HUDA BINTI MOHD KAFII',
              ),
            ),

            const ListTile(
              leading: Icon(
                Icons.badge,
                color: primaryGreen,
              ),
              title: Text('Matric Number'),
              subtitle: Text('2025424582'),
            ),

            const ListTile(
              leading: Icon(
                Icons.school,
                color: primaryGreen,
              ),
              title: Text('Course'),
              subtitle: Text(
                'ICT602 - MOBILE TECHNOLOGY AND DEVELOPMENT',
              ),
            ),

            const SizedBox(height: 20),

            // GitHub Repository

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: openGitHub,
                icon: const Icon(Icons.code),
                label: const Text('GitHub Repository'),
              ),
            ),

            const SizedBox(height: 25),

            const Divider(),

            const Text(
              '© 2026 Excess Baggage Calculator. '
                  'All Rights Reserved.',

              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
