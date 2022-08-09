

import 'package:flutter/material.dart';
import 'package:movie_list_assesment/model/movie.dart';


class MovieWidgets2 extends StatefulWidget {
  final List<Movie> movies;

  MovieWidgets2({required this.movies});

  @override
  State<MovieWidgets2> createState() => _MovieWidgets2State();
}

class _MovieWidgets2State extends State<MovieWidgets2> {





  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {

          final movie = widget.movies[index];
          String poster = movie.poster;
          print(movie.poster);
          print('poster address');
          if(movie.poster=='N/A') {
            poster='https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80';
          }


          return ListTile(
              title:

              Row(children: [
                SizedBox(

                    width: 100,
                    child:
                  ClipRRect(
                      child: Image.network(poster),
                      borderRadius: BorderRadius.circular(10),
                    )

                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.title),
                        Text(movie.year)
                      ],),
                  ),
                )
              ],),
              onTap: () {
                //print("hi"+'$index');


                print('ballla amaerr');
                Navigator.pushNamed(context, 'movieDetails', arguments: {
                  'movie_name':movie.title,//
                  'year':'year',//
                  //'runtime':'runtime',//
                  'imdb':'imdbId',
                  //'type':'director',
                  //'': 'language',
                  //'award':'award',
                  'poster':movie.poster,//

                });
          },
          );
        }
    );
  }
}
