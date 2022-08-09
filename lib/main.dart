
import 'package:movie_list_assesment/view/error_screen.dart';
import 'package:movie_list_assesment/view/home.dart';
import 'package:flutter/material.dart';
import 'package:movie_list_assesment/view/imagePage.dart';
import 'package:movie_list_assesment/view/movie_details.dart';
import 'package:movie_list_assesment/view/searchResult.dart';



void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => home(),

        'imagePage':(context) => ImagePage(),
        'errorScreen':(context) => ErrorScreen(),
        'searchResult':(context)=> SearchResult(),
        'movieDetails':(context)=>MovieDetails(),



      },
    );
  }
}
