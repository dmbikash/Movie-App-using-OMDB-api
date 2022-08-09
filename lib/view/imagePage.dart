import 'dart:convert';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_list_assesment/model/movie.dart';
import 'package:movie_list_assesment/widgets/moviesWidgets2.dart';

class ImagePage extends StatefulWidget {


  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {

  List<Movie> _movies = <Movie>[];
  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  void _populateAllMovies() async {
    final movies = await _fetchAllMovies();
    setState(() {
      _movies = movies;
    });
  }


  Future<List<Movie>> _fetchAllMovies() async {
    final response = await http.get(Uri.parse("http://www.omdbapi.com/?s=man&page=5&apikey=fed0079a"));

    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to load movies!");
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie list---(Image)--Page 2'),
        backgroundColor: Colors.grey[800],
      ),
      body:MovieWidgets2(movies: _movies),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade800,width: 4,),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5),
        child: GNav(

          onTabChange: (index){
            print(index);
            if(index==0){

              Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);


            }
            if(index==2){

              Navigator.pushNamed(context, "searchResult");


            }
          },
          activeColor: Colors.teal[500],
          color: Colors.grey,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          tabs: [
            GButton(icon: Icons.home, text: 'Text',),
            GButton(icon: Icons.image,text: 'Image'),
            GButton(icon: Icons.search,text: 'Search')
          ],
        ),
      ),
    );
  }
}
