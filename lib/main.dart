import 'package:dog_breeds/data/repositories/dog_breed_repository.dart';
import 'package:dog_breeds/presentations/cubits/custom_breed_cubit.dart';
import 'package:dog_breeds/presentations/cubits/dog_breed_cubits.dart';
import 'package:dog_breeds/presentations/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/custom_breed_repository.dart';

void main() {
 runApp(MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_)=>DogBreedCubit(DogBreedRepository())..fetchBreeds(isInitial: true),
        ),
        BlocProvider(
          create: (_) => CustomBreedsCubit(BreedRepository())..loadBreeds(),
        ),
      ],
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'Dog Breeds Companion',
       theme: ThemeData(
           primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,

       ),
       home: DashboardScreen(),
      ),
    );
  }
}
