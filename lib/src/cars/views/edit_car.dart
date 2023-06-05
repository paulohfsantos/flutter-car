import 'package:cars/src/cars/services/car_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditCarView extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> car;

  const EditCarView({Key? key, required this.car}) : super(key: key);

  static const routeName = '/edit';

  @override
  _EditCarViewState createState() => _EditCarViewState();
}

class _EditCarViewState extends State<EditCarView> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _image;

  @override
  void initState() {
    super.initState();

    _name = widget.car['name'];
    _image = widget.car['image'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Car}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: _name,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value!,
                  ),
                  TextFormField(
                    initialValue: _image,
                    decoration: const InputDecoration(labelText: 'Image'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a image';
                      }
                      return null;
                    },
                    onSaved: (value) => _image = value!,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          await CarService.updateCar(
                            id: widget.car.id,
                            name: _name,
                            image: _image,
                          );

                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
