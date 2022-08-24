import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:possi_build/components/stars.dart';
import 'package:possi_build/components/textContainer.dart';
import 'package:possi_build/models/apiData.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui' as ui;

class IndividualMovie extends StatefulWidget {
  const IndividualMovie({
    Key? key,
    required this.movieModel,
    required this.idx,
    required this.fovouriteMovies,
    required this.actor,
  }) : super(key: key);
  final MovieModel movieModel;
  final List<MovieModel> fovouriteMovies;
  final List<List<ActorModel>> actor;
  final int idx;

  @override
  State<IndividualMovie> createState() => _IndividualMovieState();
}

class _IndividualMovieState extends State<IndividualMovie> {
  late String showenString =
      widget.movieModel.plot.toString().substring(0, 150);
  late String hidenString = "";
  // widget.movieModel.plot.toString().substring(150, widget.movieModel.plot.toString().length);

  late VideoPlayerController videoPlayerController = VideoPlayerController.network(
      "https://res.cloudinary.com/duenuiiav/video/upload/v1649789401/videos/keywcjty6xusjvtumpjt.mp4");
  ChewieController? chewieController;

  bool isShowMore = false;
  bool isbtnPressed = false;
  bool isLikedPressed = false;
  bool isheartPressed = false;
  bool isadded = false;
  bool isShared = false;
  bool isplaying = true;

  Future<void> initializePlayer() async {
    videoPlayerController =
        VideoPlayerController.network(widget.movieModel.video!);
    await Future.wait([videoPlayerController.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
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
    String moviePlot = widget.movieModel.plot.toString();
    if (moviePlot.length > 150) {
      showenString = moviePlot.substring(0, 150);
      hidenString = moviePlot.substring(150, moviePlot.length);
    } else {
      showenString = moviePlot;
      hidenString = "";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
    chewieController!.dispose();
  }

  late List value = [];

  @override
  Widget build(BuildContext context) {
    MovieModel movie = widget.movieModel;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              // Image.network((movie.banner != null)
              //     ? movie.banner.toString()
              //     : "https://qph.cf2.quoracdn.net/main-qimg-a1444ec6410b4d33f33ed6aa6b4a04a5-lq"),

              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  ),
                  Positioned(
                    top: 85,
                    right: MediaQuery.of(context).size.width * 0.5 - 30,
                    child: FloatingActionButton(
                      disabledElevation: 0,
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          isplaying = false;
                          videoPlayerController.value.isPlaying
                              ? videoPlayerController.pause()
                              : videoPlayerController.play();
                        });
                      },
                      child: Icon(
                        (videoPlayerController.value.isPlaying || isplaying)
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 50,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.black, size: 35),
                    ),
                  ),
                  Positioned(
                      bottom: 40,
                      right: 15,
                      child: Text(movie.runtimeStr.toString(),
                          style: const TextStyle(color: Colors.white))),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  movie.title.toString().toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Directed by ${movie.directors.toString().toUpperCase()}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isheartPressed = !isheartPressed;
                                  if (widget.fovouriteMovies.contains(movie)) {
                                    widget.fovouriteMovies.remove(movie);
                                  } else {
                                    widget.fovouriteMovies.add(movie);
                                  }
                                });
                              },
                              icon: Icon(CupertinoIcons.heart,
                                  color:
                                      isheartPressed ? Colors.red : Colors.grey,
                                  size: 35)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade500,
                                // spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 10,
                                offset: const Offset(-5, 0),
                              ),
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.grey.shade300,
                                offset: const Offset(5, 0),
                              )
                            ],
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                movie.image.toString(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 250,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stars(
                                    count: 1,
                                    size: 35,
                                  ),
                                  Stars(
                                    count: 1,
                                    size: 55,
                                  ),
                                  Stars(
                                    count: 1,
                                    size: 35,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            movie.ratings!.imDb! != ""
                                ? RatingWidget(
                                    rate: movie.ratings!.imDb!,
                                    ratedBy: "ImDb : ")
                                : Container(),
                            movie.ratings!.filmAffinity! != ""
                                ? RatingWidget(
                                    rate: movie.ratings!.filmAffinity!,
                                    ratedBy: "FilmAffinity : ")
                                : Container(),
                            movie.ratings!.metacritic! != ""
                                ? RatingWidget(
                                    rate: movie.ratings!.metacritic!,
                                    ratedBy: "Metacritic : ")
                                : Container(),
                            movie.ratings!.theMovieDb! != ""
                                ? RatingWidget(
                                    rate: movie.ratings!.theMovieDb!,
                                    ratedBy: "TheMovieDb : ",
                                  )
                                : Container(),
                            movie.ratings!.rottenTomatoes! != ""
                                ? RatingWidget(
                                    rate: movie.ratings!.rottenTomatoes!,
                                    ratedBy: "RottenTomatoes : ")
                                : Container(),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isLikedPressed = !isLikedPressed;
                                    });
                                  },
                                  icon: Icon(
                                    isLikedPressed
                                        ? CupertinoIcons.hand_thumbsup
                                        : CupertinoIcons.hand_thumbsup_fill,
                                    size: 30,
                                    color: isLikedPressed
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isShared = !isShared;
                                    });
                                  },
                                  icon: Icon(
                                    CupertinoIcons.share,
                                    size: 30,
                                    color:
                                        isShared ? Colors.green : Colors.grey,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isadded = !isadded;
                                    });
                                  },
                                  icon: Icon(
                                    CupertinoIcons.add,
                                    size: 35,
                                    color: isadded ? Colors.red : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                    ),
                    const TextContainer(
                      text: "About Movie",
                      size: 22,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    hidenString.isEmpty
                        ? Text(showenString)
                        : Stack(
                            children: [
                              Text(
                                isShowMore
                                    ? ("$showenString...")
                                    : (showenString + hidenString),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isShowMore = !isShowMore;
                                    });
                                  },
                                  child: Text(
                                    isShowMore ? "show more" : "show less",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            movieDetails(
                                title: "Director : ",
                                reply: movie.directors.toString()),
                            movieDetails(
                                title: "Released on : ",
                                reply: movie.launchDate
                                    .toString()
                                    .substring(0, 10)),
                            movieDetails(
                                title: "Languages : ",
                                reply: movie.languages.toString()),
                            movieDetails(
                                title: "Generes : ",
                                reply: movie.genres.toString()),
                            movieDetails(
                                title: "Writred : ",
                                reply: movie.writers.toString()),
                            movieDetails(
                              title: "Year : ",
                              reply: movie.year.toString(),
                            ),
                            const movieDetails(
                              title: "Type : ",
                              reply: "Movie",
                            ),
                          ],
                        )),
                    Text(movie.description.toString()),
                    (widget.idx != 6 || widget.idx != 7)
                        ? Container(
                            padding: const EdgeInsets.only(left: 23, top: 30),
                            alignment: Alignment.bottomLeft,
                            child: const Text(
                              "Actors",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                          )
                        : Container(),
                    (widget.idx != 6 && widget.idx != 7)
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            height: 250,
                            child: ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemExtent: 150,
                                itemCount: 18,
                                itemBuilder: (context, i) {
                                  List characher = movie
                                      .actors![widget.idx][i].asCharacter
                                      .toString()
                                      .split(" ");
                                  return (movie.actors![widget.idx][i]
                                              .toString() !=
                                          "")
                                      ? (i != 5
                                          ? Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: widget
                                                        .actor[widget.idx][i]
                                                        .image
                                                        .toString(),
                                                    placeholder:
                                                        (context, url) =>
                                                            const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 20.0),
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.network(
                                                            "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"),
                                                    width: 120,
                                                    height: 150,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                InkWell(
                                                  child: Text(
                                                    movie.actors![widget.idx][i]
                                                        .name
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                InkWell(
                                                  child: Text(
                                                    "${characher[0]} ${characher[1]}",
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Image.network(
                                              "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"))
                                      : Container();
                                }),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    Key? key,
    required this.ratedBy,
    required this.rate,
  }) : super(key: key);

  final String ratedBy;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(ratedBy.toUpperCase(),
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey)),
        Text(
          rate[0],
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        Text(rate.substring(1),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            )),
        // Stars(count: 1, size: 28),
      ],
    );
  }
}

class movieDetails extends StatelessWidget {
  const movieDetails({Key? key, required this.title, required this.reply})
      : super(key: key);
  final String title;
  final String reply;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.left,
      TextSpan(
          text: title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: reply,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ]),
    );
  }
}
