import 'package:cars/src/cars/views/edit_car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarDetailsView extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> car;

  const CarDetailsView(this.car, {super.key});

  static const routeName = '/car';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car['name']),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditCarView(car: car);
                }));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete car'),
                    content: const Text('Are you sure?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('cars')
                              .doc(car.id)
                              .delete();

                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      // Car image
      body: Center(
        child: Image(
          image: NetworkImage(car['image']),
        ),
      ),
    );
  }
}
