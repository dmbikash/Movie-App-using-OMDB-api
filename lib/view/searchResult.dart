import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;

import 'package:movie_list_assesment/model/movie.dart';
import 'package:movie_list_assesment/widgets/moviesWidgets2.dart';

class SearchResult extends StatefulWidget {
  //const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {


/////////////////////////////////////////////////

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  final myController = TextEditingController();

  String movie_name= 'man';
  ////////////////////////////////////////////

  Map data = {
    'default' : 'man',
    'movie_name':'',
  };

  List<Movie> _movies = <Movie>[];
 // @override
  //void initState() {
   // super.initState();
   // _populateAllMovies();
 // }

  void _populateAllMovies() async {
    final movies = await _fetchAllMovies();
    setState(() {
      _movies = movies;
      print("ami 1----------------------------------");
    });
  }


  Future<List<Movie>> _fetchAllMovies() async {

     String yoyo= movie_name;
     yoyo=yoyo.replaceAll(" ", "+");
    // print("http://www.omdbapi.com/?s=$yoyo&page=5&apikey=fed0079a-------------------------------");
    final response = await http.get(Uri.parse("http://www.omdbapi.com/?s=$yoyo&apikey=fed0079a"));
     print("ami 2----------------------------------");

    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result);
      if(result['Response']=='False'){
        Navigator.pushNamed(context, "errorScreen");
        throw Exception("No MoVie Found!");


      }else{


        Iterable list = result["Search"];
        return list.map((movie) => Movie.fromJson(movie)).toList();
          

      }

    } else {
      throw Exception("Failed to load movies!");
    }

  }



  @override
  Widget build(BuildContext context) {




    return Scaffold(
  appBar: AppBar(
    title: Text('Search and result Page'),
    backgroundColor: Colors.grey[800],
  ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
             SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: Center(
                  child: Column(

                    children: [
                      TextField(
                        controller: myController,
                        decoration: InputDecoration(
                            hintText: 'Search for something',
                            prefixIcon: Icon(Icons.search),

                        ),

                      ),
                      ElevatedButton(
                        onPressed: () {
                          if(myController.text!='')  {
                            movie_name=myController.text;
                            print(movie_name);
                            setState(() {
                              _populateAllMovies();
                            });

                          }
                        },
                        child: Text("Search"),

                      ),
                    ],
                  ),
                ),
              ),
            ),

          ];
        },
        body: MovieWidgets2(movies: _movies),

      ),
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
              print(index);
              Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);

            }
            if(index==1){
              print(index);
              Navigator.pushNamed(context, "imagePage");

            }
            if(index==2){
              print(index);

            }

          },
          activeColor: Colors.grey[800],
          color: Colors.grey,
          padding: EdgeInsets.symmetric(horizontal:10, vertical: 14),
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

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],


        ),
    );
  }
}

