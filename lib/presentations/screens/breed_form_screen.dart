import 'package:dog_breeds/main.dart';
import 'package:dog_breeds/presentations/cubits/custom_breed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/custom_dog_breed.dart';

class BreedFormScreen extends StatefulWidget {
  final CustomDogBreed? breed;

  const BreedFormScreen({Key? key, this.breed}) : super(key: key);

  @override
  State<BreedFormScreen> createState() => _BreedFormScreenState();
}

class _BreedFormScreenState extends State<BreedFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _breedController;
  late TextEditingController _descController;
  late TextEditingController _tagsController;

  @override
  void initState() {
    super.initState();
    _breedController = TextEditingController(text: widget.breed?.name ?? '');
    _descController =
        TextEditingController(text: widget.breed?.description ?? '');
    _tagsController = TextEditingController(text: widget.breed?.tags ?? '');
  }

  @override
  void dispose() {
    _breedController.dispose();
    _descController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final name = _breedController.text.trim();
      final desc = _descController.text.trim();
      final tags = _tagsController.text.trim();

      final breed = CustomDogBreed(
          id: widget.breed?.id, name: name, description: desc, tags: tags);

      final cubit = context.read<CustomBreedsCubit>();
      if (widget.breed == null) {
        cubit.addBreed(breed);
      } else {
        cubit.updateBreed(breed);
      }

      Navigator.pop(context,true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.breed != null;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Breed' : 'Add Breed'),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isEditing ? 'Update Breed Name' : 'Create a New Breed',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _breedController,
                        decoration: const InputDecoration(
                          labelText: 'Breed Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Enter breed name';
                          }

                          final trimmedVal = val.trim();

                          // Allow only letters and spaces
                          final regex = RegExp(r'^[A-Za-z ]+$');

                          if (!regex.hasMatch(trimmedVal)) {
                            return 'Only alphabets and spaces allowed';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _descController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Enter breed name';
                          }

                          final trimmedVal = val.trim();

                          // Allow only letters and spaces
                          final regex = RegExp(r'^[A-Za-z ]+$');

                          if (!regex.hasMatch(trimmedVal)) {
                            return 'Only alphabets and spaces allowed';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _tagsController,
                        decoration: const InputDecoration(
                          labelText: 'Tags',
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Enter breed name';
                          }

                          final trimmedVal = val.trim();

                          // Allow only letters and spaces
                          final regex = RegExp(r'^[A-Za-z ]+$');

                          if (!regex.hasMatch(trimmedVal)) {
                            return 'Only alphabets and spaces allowed';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            isEditing ? 'Update Breed' : 'Add Breed',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
