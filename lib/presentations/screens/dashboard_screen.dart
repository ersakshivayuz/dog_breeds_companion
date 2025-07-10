import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/custom_breed_repository.dart';
import '../cubits/custom_breed_cubit.dart';
import '../cubits/dog_breed_cubits.dart';
import '../widgets/buildMyNavBar.dart';
import 'APIBreeds.dart';
import 'LocalBreeds.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int pageIndex = 0;
  final pages = [const APIBreeds(),
    BlocProvider(
      create: (_) => CustomBreedsCubit(BreedRepository())..loadBreeds(),
      child: const LocalBreeds(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Dog Breeds Companion",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        currentIndex: pageIndex,
          onTap: (index){
          setState(() {
            pageIndex= index;

          });
          },
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.adb),label: "APIBreeds", ),
        BottomNavigationBarItem(icon: Icon(Icons.mail),label: "LocalBreeds"),
      ]),
    );
  }

}