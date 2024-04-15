import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_frontend/utils/constants/colors.dart';

class SymptomsEntryPage extends StatefulWidget {
  const SymptomsEntryPage({super.key});

  @override
  State<SymptomsEntryPage> createState() => _SymptomsEntryPageState();
}

class _SymptomsEntryPageState extends State<SymptomsEntryPage> {
  List<String> selectedSymptoms = [];
  List<String> symptomsArray = [];
//  List<String> symptomsArray = [
//     'itching',
//     'skin_rash',
//     'nodal_skin_eruptions',
//     'continuous_sneezing',
//     'shivering',
//     'chills',
//     'joint_pain',
//     'stomach_pain',
//     'acidity',
//     'ulcers_on_tongue',
//     'muscle_wasting',
//     'vomiting',
//     'burning_micturition',
//     'spotting_ urination',
//     'fatigue',
//     'weight_gain',
//     'anxiety',
//     'cold_hands_and_feets',
//     'mood_swings',
//     'weight_loss',
//     'restlessness',
//     'lethargy',
//     'patches_in_throat',
//     'irregular_sugar_level',
//     'cough',
//     'high_fever',
//     'sunken_eyes',
//     'breathlessness',
//     'sweating',
//     'dehydration',
//     'indigestion',
//     'headache',
//     'yellowish_skin',
//     'dark_urine',
//     'nausea',
//     'loss_of_appetite',
//     'pain_behind_the_eyes',
//     'back_pain',
//     'constipation',
//     'abdominal_pain',
//     'diarrhoea',
//     'mild_fever',
//     'yellow_urine',
//     'yellowing_of_eyes',
//     'acute_liver_failure',
//     'fluid_overload',
//     'swelling_of_stomach',
//     'swelled_lymph_nodes',
//     'malaise',
//     'blurred_and_distorted_vision',
//     'phlegm',
//     'throat_irritation',
//     'redness_of_eyes',
//     'sinus_pressure',
//     'runny_nose',
//     'congestion',
//     'chest_pain',
//     'weakness_in_limbs',
//     'fast_heart_rate',
//     'pain_during_bowel_movements',
//     'pain_in_anal_region',
//     'bloody_stool',
//     'irritation_in_anus',
//     'neck_pain',
//     'dizziness',
//     'cramps',
//     'bruising',
//     'obesity',
//     'swollen_legs',
//     'swollen_blood_vessels',
//     'puffy_face_and_eyes',
//     'enlarged_thyroid',
//     'brittle_nails',
//     'swollen_extremeties',
//     'excessive_hunger',
//     'extra_marital_contacts',
//     'drying_and_tingling_lips',
//     'slurred_speech',
//     'knee_pain',
//     'hip_joint_pain',
//     'muscle_weakness',
//     'stiff_neck',
//     'swelling_joints',
//     'movement_stiffness',
//     'spinning_movements',
//     'loss_of_balance',
//     'unsteadiness',
//     'weakness_of_one_body_side',
//     'loss_of_smell',
//     'bladder_discomfort',
//     'foul_smell_of urine',
//     'continuous_feel_of_urine',
//     'passage_of_gases',
//     'internal_itching',
//     'toxic_look_(typhos)',
//     'depression',
//     'irritability',
//     'muscle_pain',
//     'altered_sensorium',
//     'red_spots_over_body',
//     'belly_pain',
//     'abnormal_menstruation',
//     'dischromic _patches',
//     'watering_from_eyes',
//     'increased_appetite',
//     'polyuria',
//     'family_history',
//     'mucoid_sputum',
//     'rusty_sputum',
//     'lack_of_concentration',
//     'visual_disturbances',
//     'receiving_blood_transfusion',
//     'receiving_unsterile_injections',
//     'coma',
//     'stomach_bleeding',
//     'distention_of_abdomen',
//     'history_of_alcohol_consumption',
//     'fluid_overload.1',
//     'blood_in_sputum',
//     'prominent_veins_on_calf',
//     'palpitations',
//     'painful_walking',
//     'pus_filled_pimples',
//     'blackheads',
//     'scurring',
//     'skin_peeling',
//     'silver_like_dusting',
//     'small_dents_in_nails',
//     'inflammatory_nails',
//     'blister',
//     'red_sore_around_nose',
//     'yellow_crust_ooze',
//   ];

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptoms'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownSearch<String>(
              popupProps: PopupProps.menu(
                isFilterOnline: true,
                showSearchBox: true,
                showSelectedItems: true,
                searchFieldProps: const TextFieldProps(
                  decoration: InputDecoration(
                    hintText: 'Enter symptom',
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
              dropdownDecoratorProps: const DropDownDecoratorProps(),

              // mode: Mode.MENU,
              // showSelectedItem: true,

              // asyncItems: (String text) async {
              //   await Future.delayed(const Duration(seconds: 2));
              //   String data = await DefaultAssetBundle.of(context).loadString('assets/json/symptoms.json');
              //   List<dynamic> symptomsArray = jsonDecode(data);
              //   // return symptoms.cast<String>();
              //   print(symptomsArray);
              //   return symptomsArray.map((symptom) => _formatSymptom(symptom)).toList();
              // },

              dropdownBuilder: (context, selectedItem) {
                return Text(
                  selectedItem ?? 'Search',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                );
              },
              // filterFn: (item, filterItems) {
              //   return true;
              //   // final String itemLowerCase = item.toString().toLowerCase();
              //   // final String filterTermLowerCase = filterItems.toLowerCase();
              //   // return itemLowerCase.contains(filterTermLowerCase);
              // },
              items: symptomsArray.map((symptom) => _formatSymptom(symptom)).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: selectedSymptoms.map((String symptom) {
                return Chip(
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
            ElevatedButton(
              onPressed: () {
                //Formaet selected symptoms
                List<String> formattedSymptoms = selectedSymptoms.map((symptom) => _unformatSymptom(symptom)).toList();
                String symptoms = formattedSymptoms.join(',');
                Map<String, String> symptomsMap = {
                  'symptoms': symptoms,
                };
                print(symptomsMap);
                // print(formattedSymptoms);
                //Convert the list of symtoms to a map of String,

                // Map<String, dynamic> symptomsMap = {
                //   "symptoms": selectedSymptoms.map((symptom) => _unformatSymptom(symptom)).toList(),
                // };
                // print(symptomsMap);
              },
              child: const Text('Print Symptoms'),
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
