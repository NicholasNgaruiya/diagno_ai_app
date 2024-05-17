import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/errors/custom_snackbar_content.dart';
import '../../../data/diagnosis/bloc/diagnosis_bloc.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class DiagnosisResultsPage extends StatefulWidget {
  const DiagnosisResultsPage({super.key});

  @override
  State<DiagnosisResultsPage> createState() => _DiagnosisResultsPageState();
}

class _DiagnosisResultsPageState extends State<DiagnosisResultsPage> with SingleTickerProviderStateMixin {
  // int _selectedIndex = 0;
  late TabController _tabController;
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.addListener(() {
    //   setState(() {
    //     _selectedIndex = _tabController.index;
    //   });
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocListener<DiagnosisBloc, DiagnosisState>(
        listener: (context, state) {
          if (state is GetDiagnosisFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomSnackBarContent(
                  snackBarTitle: 'Oops!',
                  snackBarSubtitle: state.message.toString(),
                  backgroundColor: TColors.error,
                ),
                behavior: SnackBarBehavior.floating,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
            );

            Navigator.of(context).pop();
          } else if (state is GetDiagnosisSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: CustomSnackBarContent(
                  snackBarTitle: 'Wohoo!',
                  snackBarSubtitle: 'Predicted Successfully.',
                  backgroundColor: TColors.success,
                ),
                behavior: SnackBarBehavior.floating,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
            );
          }
        },
        child: BlocBuilder<DiagnosisBloc, DiagnosisState>(
          builder: (context, state) {
            if (state is GetDiagnosisLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: TColors.primaryColor,
                ),
              );
            } else if (state is GetDiagnosisSuccess) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    iconTheme: const IconThemeData(color: Colors.white),
                    expandedHeight: 150.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://images.pexels.com/photos/6203473/pexels-photo-6203473.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: TColors.primaryColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                          Positioned(
                            top: 50,
                            left: 50,
                            right: 40,
                            child: Column(
                              children: [
                                const Text(
                                  'Disease:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  state.diagnosis['predicted_disease'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //?Two switchable tabs to display either details or Treatment results
                  SliverToBoxAdapter(
                    child: Padding(
                      // padding: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            // width: TDeviceUtils.getScreenWidth(context) * 6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TabBar(
                                    controller: _tabController,
                                    labelStyle: const TextStyle(
                                      //The style of the labels
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    indicatorColor: Colors.green,
                                    unselectedLabelColor: Colors.black,
                                    labelColor: Colors.white,
                                    indicatorWeight: 2,
                                    indicator: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    indicatorSize: TabBarIndicatorSize.tab, //This adjusts the size of the tab
                                    tabs: const [
                                      Tab(
                                        text: 'Information',
                                      ),
                                      Tab(
                                        text: 'Lifestyle',
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
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        InformationTab(
                          description: state.diagnosis['description'],
                          precautions: (state.diagnosis['precautions'] as List<dynamic>).cast<String>(),
                          medications: (state.diagnosis['medications'] as List<dynamic>).cast<String>(),
                        ),
                        LifestyleTab(
                          diets: (state.diagnosis['diets'] as List<dynamic>).cast<String>(),
                          workouts: (state.diagnosis['workout'] as List<dynamic>).cast<String>(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      //Previous code
    );
  }
}

class InformationTab extends StatelessWidget {
  final String description;
  final List<String> precautions;
  final List<String> medications;

  const InformationTab({
    super.key,
    required this.description,
    required this.precautions,
    required this.medications,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          const Text(
            'Precautions',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // children: precautions.map((precaution) {
          // final List<String> precautionList = precaution
          //     .toString()
          //     .replaceAll('[', '') // Remove leading [
          //     .replaceAll(']', '') // Remove trailing ]
          //     .split(',') // Split by comma
          //     .map((e) => e.trim()) // Trim any extra spaces
          //     .toList(); // Convert back to list

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: precautions.map((precaution) {
              return Text(
                '• ${precaution[0].toUpperCase()}${precaution.substring(1)}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
              );
            }).toList(),
          ),
          // }).toList(),
          // ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Medications',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // children: medications[0].map<Widget>((medication) {
          // final List<String> medicationList = medication
          //     .toString()
          //     .replaceAll('[', '') // Remove leading [
          //     .replaceAll(']', '') // Remove trailing ]
          //     .replaceAll("'", ' ')
          //     .split(','); // Split by comma

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: medications.map((medication) {
              //Remove singl quotes and trim spaces
              final formattedMedication = medication.replaceAll("'", '').trim();

              return Text(
                '• $formattedMedication',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
              );
            }).toList(),
          ),
          // }).toList(),
          // ),
        ],
      ),
    );
  }
}

class LifestyleTab extends StatelessWidget {
  final List<String> diets;

  final List<String> workouts;

  const LifestyleTab({Key? key, required this.workouts, required this.diets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Workouts',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: workouts.map((workout) {
              final String formattedWorkout = workout.replaceAll("'", '').trim();

              return Text(
                '• $formattedWorkout',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Diets',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: diets.map((diet) {
              final String formattedDiet = diet.replaceAll("'", '').trim();
              return Text(
                '• $formattedDiet',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
              );
            }).toList(),
          ),
          // }).toList(),
          // ),
        ],
      ),
    );
  }
}
