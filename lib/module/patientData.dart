// ignore_for_file: non_constant_identifier_names

class PatientData {
  String patientID,
      firstName,
      lastName,
      gender,
      birthDate,
      blood,
      allergies,
      symptoms,
      diagnosis,
      followUp,
      treatment;

  PatientData({
    required this.patientID,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.blood,
    required this.allergies,
    required this.symptoms,
    required this.diagnosis,
    required this.treatment,
    required this.followUp,
    required this.gender,
  });
}
