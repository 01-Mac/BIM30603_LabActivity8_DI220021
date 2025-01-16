import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  // Method to create new data in the Handyman collection in Firestore
  Future<void> addHandymanInfo(
      Map<String, dynamic> handymanInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Handyman")
        .doc(id)
        .set(handymanInfoMap);
  }
  //to read all data from Handyman collection in Firestore
  Future<Stream<QuerySnapshot>> getHandymanDetails() async {
    return await FirebaseFirestore.instance.collection("Handyman").snapshots();
  }

  Future updateHandymanDetails(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Handyman")
        .doc(id)
        .update(updateInfo);
  }

  Future deleteHandymanDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("Handyman")
        .doc(id)
        .delete();
  }
}
