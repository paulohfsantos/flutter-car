import 'package:cars/src/cars/models/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('cars');

class CarService {
  static Stream<QuerySnapshot> readCars() {
    return _Collection.snapshots();
  }

  static Future<Response> addCar({
    required String name,
    required String image,
  }) async {
    Response response = Response();
    DocumentReference documentReference = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "image": image,
    };

    await documentReference.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Car added successfully";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> deleteCar({required String id}) async {
    Response response = Response();

    await _Collection.doc(id).delete().whenComplete(() {
      response.code = 200;
      response.message = "Car deleted successfully";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> updateCar({
    required String id,
    required String name,
    required String image,
  }) async {
    Response response = Response();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "image": image,
    };

    await _Collection.doc(id).update(data).whenComplete(() {
      response.code = 200;
      response.message = "Car updated successfully";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
