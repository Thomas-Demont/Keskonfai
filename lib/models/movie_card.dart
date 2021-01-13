import 'package:flutter/material.dart';
import 'package:testfirebase/models/film.dart';
class MovieCard extends StatelessWidget {
  final Film film;

  MovieCard({this.film});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text('Titre: ${film.titreFilm}'),
          Image.network('${film.imageFilm}'),
          // Image(image: FirebaseImage(film.imageFilm)),
          // Text('id: ${film.idFilm}'),
          // Text('synopsis: ${film.synopsis}'),
          // Text('realisateur: ${film.realisateur}'),
          // Text('typeFilm: ${film.typeFilm}'),
          // Text('casting: ${film.casting}'),dis

          // Text('anneeSortie: ${film.anneeSortie}'),
          // Text('rating: ${film.rating}'),
          // Text('duree: ${film.duree}'),
        ],
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

