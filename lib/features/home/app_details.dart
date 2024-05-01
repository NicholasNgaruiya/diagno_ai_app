import 'package:flutter/material.dart';

class AppDetailsList extends StatelessWidget {
  const AppDetailsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150, // Adjust the height as needed
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            DetailCard(
              title: 'Feature 1',
              description: 'Description of Feature 1',
              icon: Icons.lens,
            ),
            DetailCard(
              title: 'Feature 2',
              description: 'Description of Feature 2',
              icon: Icons.lens,
            ),
            DetailCard(
              title: 'Feature 2',
              description: 'Description of Feature 2',
              icon: Icons.lens,
            ),
            DetailCard(
              title: 'Feature 2',
              description: 'Description of Feature 2',
              icon: Icons.lens,
            ),
            // Add more DetailCard widgets for additional features
          ],
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const DetailCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Adjust the width as needed
      margin: const EdgeInsets.symmetric(horizontal: 3), // Add spacing between cards
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
