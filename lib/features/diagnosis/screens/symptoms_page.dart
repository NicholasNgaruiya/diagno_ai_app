import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restaurant_frontend/data/diagnosis/bloc/diagnosis_bloc.dart';
import 'package:restaurant_frontend/features/diagnosis/screens/diagonis_results_page.dart';
import 'package:restaurant_frontend/utils/constants/colors.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';
import 'package:restaurant_frontend/utils/helpers/helper_functions.dart';

import '../../../common/widgets/errors/custom_snackbar_content.dart';
import '../../../utils/constants/sizes.dart';

class SymptomsEntryPage extends StatefulWidget {
  const SymptomsEntryPage({super.key});

  @override
  State<SymptomsEntryPage> createState() => _SymptomsEntryPageState();
}

class _SymptomsEntryPageState extends State<SymptomsEntryPage> {
  List<String> selectedSymptoms = [];
  List<String> symptomsArray = [];

  Future<void> loadSymptoms() async {
    String data = await DefaultAssetBundle.of(context).loadString('assets/json/symptoms.json');
    List<dynamic> symptoms = jsonDecode(data);
    setState(() {
      symptomsArray = symptoms.cast<String>();
    });
  }

  @override
  void initState() {
    super.initState();
    loadSymptoms();
  }

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.dark : TColors.white,
      appBar: AppBar(
        backgroundColor: dark ? TColors.black : TColors.white,
        toolbarHeight: TDeviceUtils.getScreenHeight(context) * 0.25,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'What are your',
                style: TextStyle(
                  color: dark ? TColors.white : TColors.black,
                  fontSize: 40,
                ),
              ),
              Text(
                'Symptoms?',
                style: TextStyle(
                  color: dark ? TColors.white : TColors.black,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Column(
          children: <Widget>[
            DropdownSearch<String>(
              popupProps: PopupProps.menu(
                scrollbarProps: ScrollbarProps(
                  thickness: 10,
                  // interactive: true,
                  thumbColor: TColors.black.withOpacity(0.5),
                  fadeDuration: const Duration(milliseconds: 500),
                ),
                isFilterOnline: true,
                showSearchBox: true,
                showSelectedItems: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: TColors.darkGrey,
                      size: 30,
                    ),
                    hintText: 'Search for symptom',
                    hintStyle: const TextStyle(
                      color: TColors.darkGrey,
                    ),
                  ),
                ),
                loadingBuilder: (context, searchEntry) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: TColors.primaryColor,
                    ),
                  );
                },
              ),
              onChanged: (String? symptom) {
                if (symptom != null && !selectedSymptoms.contains(symptom)) {
                  setState(() {
                    selectedSymptoms.add(symptom);
                  });
                }
              },
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: TColors.black,
                  ),
                  // hintStyle: TextStyle(
                  //   color: Colors.black,
                  //   fontSize: 16,
                  // ),
                  // hintText: 'Search for symptoms',
                ),
              ),
              dropdownBuilder: (context, selectedItem) {
                return Text(
                  selectedItem ?? 'Search',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
              items: symptomsArray.map((symptom) => _formatSymptom(symptom)).toList(),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Column(
              children: [
                selectedSymptoms.isEmpty
                    ? const Text(
                        'No symptoms selected',
                        style: TextStyle(
                          color: TColors.darkGrey,
                          fontSize: 16,
                        ),
                      )
                    : const Text(
                        'Selected Symptoms',
                        style: TextStyle(
                          color: TColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: selectedSymptoms.map((String symptom) {
                    return Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      deleteIcon: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                      deleteIconColor: Colors.grey[600],
                      labelStyle: const TextStyle(
                        color: TColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      backgroundColor: TColors.grey,
                      label: Text(symptom),
                      onDeleted: () {
                        setState(() {
                          selectedSymptoms.remove(symptom);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: TColors.success,
                side: const BorderSide(color: TColors.success),
              ),
              onPressed: () {
                //Formaet selected symptoms
                List<String> formattedSymptoms = selectedSymptoms.map((symptom) => _unformatSymptom(symptom)).toList();
                String symptoms = formattedSymptoms.join(',');

                print('symptoms are : $symptoms');
                //?commented out to remove functionality for easy testing
                try {
                  BlocProvider.of<DiagnosisBloc>(context).add(PredictButtonClickedEvent(symptoms: symptoms));
                } catch (e) {
                  print(e);
                  // Show snackbar in case of error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: CustomSnackBarContent(
                        snackBarTitle: 'Oops!',
                        snackBarSubtitle: e.toString(),
                        backgroundColor: TColors.error,
                      ),
                      behavior: SnackBarBehavior.floating,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }
                //?commented out to remove functionality for easy testing

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DiagnosisResultsPage()));
              },
              child: const Text(
                'Predict Disease',
                style: TextStyle(
                  color: TColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatSymptom(String symptom) {
  //capitalize the first letter
  String capitalizedSymptom = symptom.capitalize();

  //Split the symptom by undercores
  List<String> words = capitalizedSymptom.split('_');
  return words.join(' ');
}

String _unformatSymptom(String symptom) {
  String uncapitalizedSymptom = symptom.uncapitalize();
  //Split the symptom by spaces
  List<String> words = uncapitalizedSymptom.split(' ');
  return words.join('_');
}

//Extension method to capitalize the first letter of a string
extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String uncapitalize() {
    return '${this[0].toLowerCase()}${substring(1)}';
  }
}
