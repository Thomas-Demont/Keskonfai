import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testfirebase/models/donnee.dart';
import 'package:testfirebase/services/auth.dart';

class Film extends Donnees {
  //Attributs
  int idFilm;
  String titreFilm;
  String synopsis;
  String imageFilm;
  String realisateur;
  int typeFilm;
  String casting;
  Timestamp anneeSortie;
  String rating;
  String duree;

  Film({this.idFilm, this.titreFilm, this.synopsis, this.imageFilm, this.realisateur, this.typeFilm, this.casting,
  this.anneeSortie, this.rating, this.duree});

  //Methodes
  // Widget recupererFilms(AuthService user) {
  //   CollectionReference users = Firestore.instance.collection('users');
  //   (currentUser) => Firestore.instance
  //       .collection("users")
  //       .document(currentUser.user.uid).get();
  //   users.document(currentUser.user.uid)

    //Prend les 10 premier films à partir du dernier (avec user.uid)
    //et renvoi une liste avec ces films
    // user.user.
  //}

//MovieCard afficherFilm() {
//  creer MovieCard et la renvoi par rapport au attribut du films a recup dans BDD
//
//}
}