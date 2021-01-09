import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testfirebase/screens/home/settings_form.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase/screens/home/user_list.dart';
import 'package:testfirebase/models/user.dart';
import 'package:testfirebase/screens/home/settings_form.dart';
import 'package:testfirebase/screens/keskonfai/keskonfaiSolo.dart';
import '../../models/film.dart';
import '../../models/movie_card.dart';

class KeskonfaiSoloFilm extends StatefulWidget {

  @override
  _KeskonfaiSoloFilmState createState() => _KeskonfaiSoloFilmState();
}

class _KeskonfaiSoloFilmState extends State<KeskonfaiSoloFilm> {

  final AuthService _auth = AuthService();
  final FirebaseAuth authentication = FirebaseAuth.instance;
  int indexFilm = 0;
  int _indexBottomNavBar = 0;
  Film filmActuel;
  List<Widget> listMovieCard;
  // final FirebaseUser user = await authentication.currentUser();
  // final userUid = user.uid;

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }


    return StreamProvider<List<User>>.value(
      value: DatabaseService().users,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Home'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Logout'),
                  onPressed: () async {
                    await _auth.signOut();
                  }),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: () => _showSettingsPanel(),
              ),
            ],
          ),
          body: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("films")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new IndexedStack(
                        index: indexFilm,
                        children: listMovieCard = snapshot.data.documents
                            .map((DocumentSnapshot document) {
                              print('index : ${indexFilm}');
                          return new MovieCard(
                            film: filmActuel= Film(
                              idFilm: int.parse(document.documentID),
                              titreFilm: document.data["titre"],
                              synopsis: document.data["synopsis"],
                              imageFilm: document.data["image_film"],
                              realisateur: document.data["realisateur"],
                              typeFilm: document.data["type_Film"],
                              casting: document.data["casting"],
                              anneeSortie: document.data["annee_sortie_film"],
                              rating: document.data["rating"],
                              duree: document.data["duree"],
                            ),
                          );
                        }).toList(),
                      );
                  }
                },
              )
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: onItemTap,
            selectedItemColor: Colors.white,
            showSelectedLabels: false,   // <-- HERE
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.clear, color: Colors.pink),
                label:'Dislike',
              ),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.info, color: Colors.pink,),
                  label: 'Information'
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.favorite, color: Colors.pink),
                label:'Like',
              ),
            ],
          ),
      ),
    );
  }

  void onItemTap(int index) {
    setState(() {
      _indexBottomNavBar = index;
    });
    switch (_indexBottomNavBar) {
      case 0: //TODO Passer le film en dislike + save dernier film
        print('Case 1 ');
        indexFilm += 1;
        // currentUser.user.useruid
        break;
      case 1:
        print('Case 2 ');
        showModalBottomSheet(context: context, builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: MovieInfo(film: Film(
              idFilm: filmActuel.idFilm,
              titreFilm: filmActuel.titreFilm,
              synopsis: filmActuel.synopsis,
              realisateur: filmActuel.realisateur,
              typeFilm: filmActuel.typeFilm,
              casting: filmActuel.casting,
              anneeSortie: filmActuel.anneeSortie,
              rating: filmActuel.rating,
              duree: filmActuel.duree,
            )),
          );
        });
        break;
      case 2: //TODO Passer le film en like + save dernier film
        print('Case 3 ');
        indexFilm += 1;
        break;
    }
  }
}