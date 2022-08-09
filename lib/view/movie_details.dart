import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;

class MovieDetails extends StatefulWidget {


  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
   void initState() {
     super.initState();
     _fetchAllMovies();
   }
  Map movie_data={};
  Map movie_data2={};
  double height_2 = 2 ;


  _fetchAllMovies() async {
    final response = await http.get(Uri.parse("http://www.omdbapi.com/?t='${movie_data['movie_name']}'&apikey=fed0079a"));
    print('response er details');
    print(jsonDecode(response.body));
    movie_data2 =jsonDecode(response.body);
    print(movie_data2);



  }



  @override
  Widget build(BuildContext context) {
    movie_data = ModalRoute.of(context)?.settings.arguments as Map;
    print('route data----------------');
    print(movie_data['poster']);
    _fetchAllMovies();
    print(movie_data2);

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body:
      SingleChildScrollView(


        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Center(

              child: ClipRRect(
                  child: Image.network(movie_data['poster'],
                    //height: 450,
                   // width: 350,
                    ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Text('${movie_data['movie_name']}', style: TextStyle(fontSize: 30),),
             SizedBox(
              width: 380.0,
              height: height_2,


              child: Card(
                color: Colors.blue[100],
                  child: Text(
                           '${movie_data2['Title']}'


                          'Year: ${movie_data2['Year']}\n'
                          'IMBD-ID: ${movie_data2['imdbID']}\n'
                          'Language: ${movie_data2['Language']}'
                          'Genre: ${movie_data2['Genre']}\n'
                          'Director: ${movie_data2['Director']}\n'
                          'Actor: ${movie_data2['Actors']}\n'
                          'Award: ${movie_data2['Awards']}\n'
                          '\n'
                          '\n'
                              'Plot: ${movie_data2['Plot']}'
                              '\n',
                         style: TextStyle(
                           fontSize: 20,
                           letterSpacing: .5,
                           color: Colors.black,
                         ),

                  ),
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: Text('Reload Page'),

              onPressed: () {

                setState(() {
                  _fetchAllMovies();
                });
                height_2=500;
              },
            ),
          ],

        ),
      ),


    );
  }
}
