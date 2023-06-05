import 'package:cars/src/cars/services/car_service.dart';
import 'package:cars/src/cars/views/add_car.dart';
import 'package:cars/src/cars/views/car_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarsListView extends StatefulWidget {
  @override
  _CarsListViewState createState() => _CarsListViewState();
}

class _CarsListViewState extends State<CarsListView> {
  final Stream<QuerySnapshot> collectionReference = CarService.readCars();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Cars List'),
        ),
        body: StreamBuilder(
          stream: collectionReference,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView(
                  children: snapshot.data!.docs.map((e) {
                    return Column(children: [CarTile(e)]);
                  }).toList(),
                ),
              );
            }

            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddCarView()),
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}

class CarTile extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> car;

  CarTile(this.car, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(car["image"])),
      title: Text(car["name"]),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CarDetailsView(car)),
        )
      },
    );
  }
}
