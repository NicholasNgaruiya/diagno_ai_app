// import 'package:flutter/material.dart';

// class MyTabbedPage extends StatefulWidget {
//   const MyTabbedPage({Key? key}) : super(key: key);

//   @override
//   _MyTabbedPageState createState() => _MyTabbedPageState();
// }

// class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: 2); // Assuming you have 2 tabs
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your App Name'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: 'Details'),
//             Tab(text: 'Treatment'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           DetailsTab(/* pass your parameters */),
//           TreatmentTab(/* pass your parameters */),
//         ],
//       ),
//     );
//   }
// }
