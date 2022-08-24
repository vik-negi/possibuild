import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:possi_build/components/allMovies.dart';
import 'package:possi_build/components/horizontalScroll.dart';
import 'package:possi_build/models/apiData.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:possi_build/screens/IndividualMovie.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

String stringResponce = "";
Map mapResponce = {};
List dataResponse = [];

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.movieModel,
      required this.ratingModel,
      required this.actorModel,
      required this.movieClip,
      required this.movieImg,
      required this.movieLang,
      required this.movieGenres,
      required this.movieEnglish,
      required this.movieTamil,
      required this.futureMovieModel,
      required this.fovouriteMovies})
      : super(key: key);
  final List<MovieModel> movieModel;
  final List<MovieModel> fovouriteMovies;
  final Future<List<MovieModel>> futureMovieModel;
  final RatingModel ratingModel;
  final List<List<ActorModel>> actorModel;
  final List<String> movieClip;
  final Map<int, String> movieImg;
  final List<List<String>> movieLang;
  final Map<int, String> movieGenres;
  final Map<int, String> movieEnglish;
  final Map<int, String> movieTamil;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController videoPlayerController = VideoPlayerController.network(
      "https://res.cloudinary.com/duenuiiav/video/upload/v1649789401/videos/keywcjty6xusjvtumpjt.mp4");
  ChewieController? chewieController;

  bool isbtnPressed = false;
  bool ishoverOnCard = false;
  final FocusNode _searchFocus = FocusNode();
  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(
        "https://res.cloudinary.com/duenuiiav/video/upload/v1649789401/videos/keywcjty6xusjvtumpjt.mp4");
    await Future.wait([videoPlayerController.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      aspectRatio: videoPlayerController.value.aspectRatio,
      placeholder: Container(
        color: Colors.white,
      ),
      autoInitialize: true,
    );
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
    // futureMovieModel = apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_searchFocus.hasFocus) {
          setState(() {
            _searchFocus.unfocus();
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "MOVIES NOW",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: const Icon(Icons.notifications),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(Icons.more_vert),
                          ],
                        )
                      ],
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  child: CupertinoSearchTextField(
                    focusNode: _searchFocus,
                    placeholder: "Search here",
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      size: 25,
                    ),
                    padding:
                        const EdgeInsets.only(top: 15, left: 10, bottom: 15),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: widget.futureMovieModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return futureMovieModelData(context);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column futureMovieModelData(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.movieImg.values.toList().map((item) {
            MapEntry entry = widget.movieImg.entries
                .firstWhere((element) => element.value == item.toString());
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IndividualMovie(
                      movieModel: widget.movieModel[entry.key],
                      idx: entry.key,
                      fovouriteMovies: widget.fovouriteMovies,
                      actor: widget.actorModel,
                    ),
                  ),
                );
              },
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: 1000,
                  ),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 1.0,
            enlargeCenterPage: true,
          ),
        ),
        HorizontalScroll(
          movie: widget.movieModel,
          favouriteMovies: widget.fovouriteMovies,
          actorModel: widget.actorModel,
        ),
        AllMovies(
          movie: widget.movieModel,
          favouriteMovies: widget.fovouriteMovies,
          actorModel: widget.actorModel,
        ),
        Container(
          padding: const EdgeInsets.only(left: 23, top: 30, bottom: 20),
          alignment: Alignment.bottomLeft,
          child: Text(
            "Only for you".toUpperCase(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.start,
          ),
        ),
        LanguageWiseMovie(
          map: widget.movieImg,
          category: 'Top Movies',
          movieModel: widget.movieModel,
          fovouriteMovies: widget.fovouriteMovies,
          actorModel: widget.actorModel,
        ),
        LanguageWiseMovie(
          map: widget.movieEnglish,
          category: 'English Movies',
          movieModel: widget.movieModel,
          fovouriteMovies: widget.fovouriteMovies,
          actorModel: widget.actorModel,
        ),
        LanguageWiseMovie(
          map: widget.movieTamil,
          category: 'Tamil Movies',
          movieModel: widget.movieModel,
          fovouriteMovies: widget.fovouriteMovies,
          actorModel: widget.actorModel,
        ),
      ],
    );
  }
}

class LanguageWiseMovie extends StatelessWidget {
  const LanguageWiseMovie(
      {Key? key,
      this.map,
      required this.category,
      required this.movieModel,
      required this.fovouriteMovies,
      required this.actorModel})
      : super(key: key);
  final Map<int, String>? map;
  final String category;
  final List<MovieModel> movieModel;
  final List<MovieModel> fovouriteMovies;
  final List<List<ActorModel>> actorModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 23, top: 30),
          alignment: Alignment.bottomLeft,
          child: Text(
            category.toUpperCase(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          height: 200,
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemExtent: 150,
              itemCount: map!.length,
              itemBuilder: (context, i) {
                List key = map!.keys.toList();
                List value = map!.values.toList();
                return (mapResponce['data'].toString() == "null")
                    ? const CircularProgressIndicator()
                    : (value[i].toString() != "")
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IndividualMovie(
                                    movieModel: movieModel[key[i]],
                                    idx: key[i],
                                    fovouriteMovies: fovouriteMovies,
                                    actor: actorModel,
                                  ),
                                ),
                              );
                            },
                            child: Image.network(
                              value[i].toString(),
                            ),
                          )
                        : Container();
              }),
        ),
      ],
    );
  }
}
