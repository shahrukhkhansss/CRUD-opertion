import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addProductDetails(
      Map<String, dynamic> productInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .set(productInfoMap);
  }

  Future<Stream<QuerySnapshot>> getProductDetails() async {
    return await FirebaseFirestore.instance.collection("Product").snapshots();
  }

  Future UpdateProductDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .update(updateInfo);
  }

  Future DeleteProductDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .delete();
  }
}
