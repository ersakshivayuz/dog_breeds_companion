import 'package:flutter/material.dart';

class APIBreeds extends StatefulWidget {
  const APIBreeds({super.key});

  @override
  State<APIBreeds> createState() => _APIBreedsState();
}

class _APIBreedsState extends State<APIBreeds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (context, index){
            return ListTile(
              title: Text('Labrador Retriever'),
              subtitle: Text("this is a dummy content that needs to be shown, and this content will be changed after sometime "),
            );
          },
          separatorBuilder: (context,index) => Divider(),
          itemCount: 30),
    );
  }
}
