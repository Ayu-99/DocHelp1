import 'package:cloud_firestore/cloud_firestore.dart';
import 'Staff/SearchPatient.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('Waiting Patients')
        .where('searchKey',
        isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }


  getSpecificPatient()async{
    print(patientName);
    return Firestore.instance.collection("Waiting Patients").where('name', isEqualTo: patientName).snapshots();

  }
}