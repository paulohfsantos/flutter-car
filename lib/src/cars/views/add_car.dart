import 'package:cars/src/cars/services/car_service.dart';
import 'package:flutter/material.dart';

class AddCarView extends StatefulWidget {
  const AddCarView({super.key});

  static const routeName = '/add_car';

  @override
  _AddCarViewState createState() => _AddCarViewState();
}

class _AddCarViewState extends State<AddCarView> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _image;

  @override
  void initState() {
    super.initState();

    _name = '';
    _image = '';
  }

  @override
  Widget build(BuildContext context) {
    final AddButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5.0),
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: const Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              var response =
                  await CarService.addCar(name: _name, image: _image);

              if (response.code == 200) {
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(response.message.toString()),
                ));
              }
            }
          },
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a car'),
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
                  Center(child: AddButton),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
