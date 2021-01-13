import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testfirebase/screens/home/settings_form.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase/models/user.dart';
import '../../models/film.dart';
import '../../models/movie_card.dart';

class KeskonfaiSoloFilm extends StatefulWidget {

  @override
  _KeskonfaiSoloFilmState createState() => _KeskonfaiSoloFilmState();
}

class _KeskonfaiSoloFilmState extends State<KeskonfaiSoloFilm> {

  final AuthService _auth = AuthService();
  final FirebaseAuth authentication = FirebaseAuth.instance;
  int indexFilm = 0;//int.parse(getDataFromCollection('Users', currentUserUid, 'dernierFilm'));
  int _indexBottomNavBar = 0;
  Film filmActuel;
  List<MovieCard> listMovieCard;
  String currentUserUid;
  // final FirebaseUser user = await authentication.currentUser();
  // final userUid = user.uid;

  @override
  Widget build(BuildContext context) {
    getCurrentUserUid();
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
                      // int userDernierFilm =
                      // int.parse(getDataFromCollection('Users', currentUserUid, 'dernierFilm'));
                      // attendre();
                      // print('TEST INDEX $userDernierFilm');
                      return new IndexedStack(
                        index: indexFilm,
                        children: listMovieCard = snapshot.data.documents
                            .map((DocumentSnapshot document) {
                              print('indexFilm : ${indexFilm}');
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

  void onItemTap(int index) async{
    setState(() {
      _indexBottomNavBar = index;
    });
    print('index bottom bar : ${_indexBottomNavBar}');
    switch (_indexBottomNavBar) {
      case 0: //TODO Passer le film en dislike
        print('Case 1 ');
        getCurrentUserUid();
        attendre();
        indexFilm += 1;
        setDernierFilm(listMovieCard[indexFilm].film.idFilm, indexFilm);
        break;
      case 1:
        print('Case 2 ');
        showModalBottomSheet(context: context, builder: (context) {
          return listMovieCard[indexFilm].afficherInfo(context);
        });
        break;
      case 2: //TODO Passer le film en like
        print('Case 3 ');
        getCurrentUserUid();
        attendre();
        indexFilm += 1;
        setDernierFilm(listMovieCard[indexFilm].film.idFilm, indexFilm);
        break;
    }
  }

  Future<String> getCurrentUserUid() async {
    final FirebaseUser user = await authentication.currentUser();
    print('getCurrentUserId() : ${user.uid}');
    attendre();
    return currentUserUid = user.uid;
  }

  String getDataFromCollection(String collection, String idUser, String nomChamp) {
    Firestore.instance.collection(collection).document(idUser)
        .get().then((documentSnapshot) {
        print(documentSnapshot.data);
        attendre();
        return (documentSnapshot.data[nomChamp].toString());
      }
    );
  }

  void setDernierFilm(int idFilm, int indexUpdate) async{
    Firestore.instance.collection('Users').document(currentUserUid).updateData(
        {'dernierFilm': indexUpdate});
  }

  void attendre() async {
    await Future.delayed(const Duration(milliseconds: 1000), (){});//Pause pendant 300 milisecondes pour attendre le currentUserId
  }

}
