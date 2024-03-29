import 'package:flutter/material.dart';
import 'grid_dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff392850),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 110),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'My Family',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Home',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  alignment: Alignment.topCenter,
                  icon: const Icon(Icons.notification_add),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          //TODO Grid Dashboard
          GridDashboard(),
        ],
      ),
    );
  }
}
