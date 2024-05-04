import 'package:flutter/material.dart';

class HealthTipsList extends StatelessWidget {
  const HealthTipsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HealthTipItem(
            title: 'Nutrition',
            description:
                'Maintain a balanced diet rich in fruits, vegetables, lean proteins, and whole grains. Limit processed foods and sugary drinks.',
          ),
          SizedBox(height: 10),
          HealthTipItem(
            title: 'Exercise',
            description:
                'Incorporate regular physical activity into your routine. Aim for at least 30 minutes of moderate exercise most days of the week.',
          ),
          SizedBox(height: 10),
          HealthTipItem(
            title: 'Stress Management',
            description:
                'Practice stress-reducing techniques such as deep breathing, meditation, yoga, or spending time in nature.',
          ),
          // Add more HealthTipItems as needed
        ],
      ),
    );
  }
}

class HealthTipItem extends StatelessWidget {
  final String title;
  final String description;

  const HealthTipItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(description),
        ],
      ),
    );
  }
}
