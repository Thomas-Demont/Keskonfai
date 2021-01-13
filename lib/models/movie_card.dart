import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testfirebase/models/film.dart';

class MovieCard extends StatelessWidget {
  final Film film;

  MovieCard({this.film});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(film.titreFilm, style: TextStyle(
              height: 2,
              fontSize: 25,
              fontWeight: FontWeight.bold,
        )),
            Image.network('${film.imageFilm}'),
          ],
        ),
      ),
    );
  }

  Widget afficherInfo(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
        Text('${film.titreFilm}'),
        Text('${film.synopsis}'),
        Text('realisateur: ${film.realisateur}'),
        Text('casting: ${film.casting}'),
        Text('duree: ${film.duree}'),
      ],
      ),
    );
  }
}

