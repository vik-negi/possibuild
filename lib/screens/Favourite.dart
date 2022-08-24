import 'package:flutter/material.dart';
import 'package:possi_build/components/allMovies.dart';
import 'package:possi_build/components/horizontalScroll.dart';
import 'package:possi_build/components/stars.dart';
import 'package:possi_build/components/textContainer.dart';
import 'package:possi_build/models/apiData.dart';
import 'package:possi_build/models/userModel.dart';
import 'package:possi_build/screens/IndividualMovie.dart';

class Catalog extends StatelessWidget {
  const Catalog(
      {Key? key,
      this.userModel,
      required this.movieModel,
      required this.favouriteMovies,
      required this.actorModel})
      : super(key: key);
  final UserModel? userModel;
  final List<MovieModel> movieModel;
  final List<MovieModel> favouriteMovies;
  final List<List<ActorModel>> actorModel;

  @override
  Widget build(BuildContext context) {
    return
        // const Text("bkfn");
        Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HorizontalScroll(
              movie: movieModel,
              favouriteMovies: favouriteMovies,
              actorModel: actorModel,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Your Fovourite',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        child: const Text('View All'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  favouriteMovies.length > 0
                      ? ListView.builder(
                          itemCount: favouriteMovies.length,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemExtent: 220,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IndividualMovie(
                                      movieModel: favouriteMovies[i],
                                      idx: i,
                                      fovouriteMovies: favouriteMovies,
                                      actor: actorModel,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                left: Radius.circular(15)),
                                        child: Image.network(
                                          favouriteMovies[i].image ??
                                              favouriteMovies[i].banner!,
                                          width: 130,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextContainer(
                                            text: favouriteMovies[i]
                                                .title
                                                .toString(),
                                            size: 20,
                                          ),
                                          TextContainer(
                                            text:
                                                "By ${favouriteMovies[i].directors.toString()}",
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              (favouriteMovies[i]
                                                          .launchDate
                                                          .toString() !=
                                                      "")
                                                  ? Row(
                                                      children: [
                                                        Text(favouriteMovies[i]
                                                            .launchDate
                                                            .toString()
                                                            .substring(0, 9)),
                                                        SizedBox(
                                                          width: 45,
                                                        )
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                              (favouriteMovies[i]
                                                          .runtimeStr
                                                          .toString() !=
                                                      "")
                                                  ? Text(favouriteMovies[i]
                                                      .runtimeStr
                                                      .toString())
                                                  : const SizedBox(),
                                            ],
                                          ),
                                          Text(favouriteMovies[i]
                                              .genres
                                              .toString()),
                                          (favouriteMovies[i]
                                                          .ratings!
                                                          .imDb
                                                          .toString() !=
                                                      "" ||
                                                  favouriteMovies[i]
                                                          .ratings!
                                                          .imDb
                                                          .toString() !=
                                                      null)
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: Stars(
                                                      count: double.parse(
                                                              favouriteMovies[i]
                                                                  .ratings!
                                                                  .imDb
                                                                  .toString())
                                                          .round()),
                                                )
                                              : Container(),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                215,
                                            child: TextContainer(
                                              text:
                                                  "${favouriteMovies[i].plot.toString().substring(0, 90)} ...",
                                              size: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          })
                      : const Text("You Don't have any favourite",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                  // Container(
                  //   height: 500,
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: ListView.builder(
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: movieModel.length,
                  //     itemBuilder: (ctx, i) => VerticalListItem(i),
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Top Rated Movies',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          child: Text('View All'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  AllMovies(
                    movie: movieModel.sublist(0, 6),
                    favouriteMovies: favouriteMovies,
                    actorModel: actorModel,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
