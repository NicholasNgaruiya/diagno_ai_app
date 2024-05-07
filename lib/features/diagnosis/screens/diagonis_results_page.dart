import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/common/widgets/errors/custom_snackbar_content.dart';
import 'package:restaurant_frontend/features/diagnosis/screens/symptoms_page.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';

import '../../../data/diagnosis/bloc/diagnosis_bloc.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class DiagnosisResultsPage extends StatefulWidget {
  const DiagnosisResultsPage({super.key});

  @override
  State<DiagnosisResultsPage> createState() => _DiagnosisResultsPageState();
}

class _DiagnosisResultsPageState extends State<DiagnosisResultsPage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(
        index,
        curve: Curves.easeInOut,
        // duration: const Duration(milliseconds: 900),
      );
    });
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
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        // width: TDeviceUtils.getScreenWidth(context) * 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _onTabSelected(0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _selectedIndex == 0 ? Colors.green : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Tab(
                                    child: Text(
                                      'Information',
                                      style: TextStyle(
                                        color: _selectedIndex == 0 ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _onTabSelected(1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _selectedIndex == 1 ? Colors.green : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Tab(
                                    child: Text(
                                      'Lifestyle',
                                      style: TextStyle(
                                        color: _selectedIndex == 1 ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: _selectedIndex == 0
                        ? InformationTab(
                            description: state.diagnosis['description'],
                            precautions: [state.diagnosis['precautions']],
                            medications: [state.diagnosis['medications']],
                          )
                        : LifestyleTab(
                            diets: [state.diagnosis['diets']],
                            workouts: [state.diagnosis['workout']],
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
  final List<dynamic> precautions;
  final List<dynamic> medications;

  const InformationTab({
    super.key,
    required this.description,
    required this.precautions,
    required this.medications,
  });

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   alignment: Alignment.center,
    //   child: const Text('Details Tab Content'),
    // );
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: precautions.map((precaution) {
              final List<String> precautionList = precaution
                  .toString()
                  .replaceAll('[', '') // Remove leading [
                  .replaceAll(']', '') // Remove trailing ]
                  .split(',') // Split by comma
                  .map((e) => e.trim()) // Trim any extra spaces
                  .toList(); // Convert back to list

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: precautionList.map((precautionItem) {
                  return Text(
                    '• ${precautionItem[0].toUpperCase()}${precautionItem.substring(1)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: medications[0].map<Widget>((medication) {
              final List<String> medicationList = medication
                  .toString()
                  .replaceAll('[', '') // Remove leading [
                  .replaceAll(']', '') // Remove trailing ]
                  .replaceAll("'", ' ')
                  .split(','); // Split by comma

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: medicationList.map((medicationItem) {
                  return Text(
                    '• $medicationItem',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class LifestyleTab extends StatelessWidget {
  final List<dynamic> diets;

  final List<dynamic> workouts;

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
            children: workouts[0].map<Widget>((workout) {
              final String workoutItem = workout
                  .toString()
                  .replaceAll('[', '') // Remove leading [
                  .replaceAll(']', '') // Remove trailing ]
                  .replaceAll("'", ''); // Remove single quotes

              return Text(
                '• $workoutItem',
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
            children: diets[0].map<Widget>((diet) {
              final List<String> dietList = diet
                  .toString()
                  .replaceAll('[', '') // Remove leading [
                  .replaceAll(']', '') // Remove trailing ]
                  .replaceAll("'", '') // Remove single quotes
                  .split(','); // Split by comma

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: dietList.map((dietItem) {
                  return Text(
                    '• $dietItem',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
