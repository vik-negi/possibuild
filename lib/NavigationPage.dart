import 'package:flutter/material.dart';
import 'package:possi_build/models/apiData.dart';
import 'package:possi_build/models/userModel.dart';
import 'package:possi_build/screens/Favourite.dart';
import 'package:possi_build/screens/HomePage.dart';
import 'package:possi_build/screens/ProfilePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NavigatorMenu extends StatefulWidget {
  NavigatorMenu({
    Key? key,
    this.userdata,
    this.userModel,
  }) : super(key: key);
  late Map? userdata;
  final UserModel? userModel;

  @override
  State<NavigatorMenu> createState() => _NavigatorMenuState();
}

class _NavigatorMenuState extends State<NavigatorMenu> {
  String url = "https://api-telly-tell.herokuapp.com/movies/rahul.verma";

  late Future<List<MovieModel>> futureMovieModel;
  List<MovieModel> movieModel = [];
  List<MovieModel> fovouriteMovies = [];
  late RatingModel ratingModel = RatingModel();
  List<List<ActorModel>> actorModel = [];
  List<String> movieClip = [];
  Map<int, String> movieImg = {};
  List<List<String>> movieLang = [];
  Map<int, String> movieGenres = {};
  Map<int, String> movieEnglish = {};
  Map<int, String> movieTamil = {};

  Future<List<MovieModel>> apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    mapResponce = await json.decode(response.body);
    dataResponse = mapResponce["data"];
    int i = 0;
    for (var movie in dataResponse) {
      if (!movie["Ratings"].isEmpty) {
        ratingModel = RatingModel(
            imDb: movie["Ratings"]["imDb"],
            metacritic: movie["Ratings"]['metacritic'],
            theMovieDb: movie["Ratings"]['theMovieDb'],
            rottenTomatoes: movie["Ratings"]['rottenTomatoes'],
            filmAffinity: movie["Ratings"]['filmAffinity']);

        // ratingModel.add(rating);
      }

      if (!movie["video"].isEmpty) {
        String clip = movie["video"];
        movieClip.add(clip);
      }
      if (!movie['image'].isEmpty) {
        String img = movie['image'];
        movieImg[i] = img;
        if (movie['Languages'].indexOf("English") != -1) {
          movieEnglish[i] = img;
        }
        if (movie['Languages'].indexOf("Tamil") != -1) {
          movieTamil[i] = img;
        }
      }
      if (!movie['Languages'].isEmpty) {
        List<String> lang = movie['Languages'].toString().split(",");
        for (var i = 0; i < lang.length; i++) {
          lang[i] = lang[i].trim();
        }
        movieLang.add(lang);
      }
      if (!movie['genres'].isEmpty) {
        movieGenres[i] = movie['genres'];
      }
      List<ActorModel> actord = [];
      if (!movie["Actors_list"].isEmpty) {
        for (var actor in movie["Actors_list"]) {
          ActorModel actorDetails = ActorModel(
            name: actor['name'],
            asCharacter: actor['asCharacter'],
            image: actor['image'],
          );
          // actord.add(i);
          actord.add(actorDetails);
        }

        actorModel.add(actord);
      } else {
        ActorModel actorDetails = ActorModel(
          name: 'name',
          asCharacter: 'asCharacter',
          image:
              'https://imdb-api.com/images/original/MV5BMmZlNDMwMGMtODQ2Ny00NWI3LTg2NjgtNTFmYjA3Y2IzOTlkXkEyXkFqcGdeQXVyMjYwMDk5NjE@._V1_Ratio1.1429_AL_.jpg',
        );
        actord.add(actorDetails);
        actorModel.add(actord);
      }

      MovieModel movieDetails = MovieModel(
          ratings: ratingModel,
          description: movie['description'],
          live: movie['live'],
          thumbnail: movie["thumbnail"],
          launchDate: movie['launchDate'],
          video: movie['video'],
          directors: movie['directors'],
          year: movie['year'],
          image: movie['image'],
          genres: movie['genres'],
          languages: movie['Languages'],
          runtimeStr: movie['RuntimeStr'],
          plot: movie['Plot'],
          writers: movie['Writers'],
          title: movie['title'],
          actors: actorModel,
          banner: movie['banner']);
      movieModel.add(movieDetails);
      i += 1;
    }

    if (response.statusCode == 200) {
      return movieModel;
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  void initState() {
    futureMovieModel = apiCall();
  }

  int index = 0;

  final TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = <Widget>[
      HomePage(
        movieModel: movieModel,
        ratingModel: ratingModel,
        actorModel: actorModel,
        movieClip: movieClip,
        movieImg: movieImg,
        movieLang: movieLang,
        movieGenres: movieGenres,
        movieEnglish: movieEnglish,
        movieTamil: movieTamil,
        futureMovieModel: futureMovieModel,
        fovouriteMovies: fovouriteMovies,
      ),
      Catalog(
        userModel: widget.userModel,
        movieModel: movieModel,
        favouriteMovies: fovouriteMovies,
        actorModel: actorModel,
      ),
      ProfilePage(
        userModel: widget.userModel,
        userData: widget.userdata,
      ),
    ];
    return Scaffold(
      body: screens.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          navbarItem(icon: Icons.home, label: "Home"),
          navbarItem(icon: Icons.favorite_outline_outlined, label: "Favourite"),
          navbarItem(icon: Icons.account_box, label: "Accounts"),
        ],
        currentIndex: index,
        unselectedItemColor: const Color(0xffa1a1a1),
        selectedItemColor: const Color(0xff415859),
        showUnselectedLabels: true,
        selectedIconTheme: const IconThemeData(size: 30),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  BottomNavigationBarItem navbarItem(
      {required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
