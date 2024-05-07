import 'package:restaurant_frontend/data/diagnosis/services/diagnosis_service.dart';

class DiagnosisRepository {
  DiagnosisRepository();

  Future<Map<String, dynamic>> getDiagnosis(String symptoms) async {
    try {
      final response = await DiagnosisService().predictDisease(symptoms);
      return response;
    } catch (e) {
      print('Error getting diagnosis: $e');
      rethrow;
    }
  }
}
