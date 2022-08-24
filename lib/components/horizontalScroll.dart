import 'package:flutter/material.dart';
import 'package:possi_build/models/apiData.dart';
import 'package:possi_build/screens/IndividualMovie.dart';

class HorizontalScroll extends StatelessWidget {
  const HorizontalScroll(
      {Key? key,
      required this.movie,
      required this.favouriteMovies,
      required this.actorModel})
      : super(key: key);
  final List<MovieModel> movie;
  final List<MovieModel> favouriteMovies;
  final List<List<ActorModel>> actorModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 23, top: 60),
          alignment: Alignment.bottomLeft,
          child: Text(
            "Trending Movies".toUpperCase(),
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
              itemExtent: 250,
              itemCount: movie.length,
              itemBuilder: (context, i) {
                return (movie[i].banner.toString() != "" &&
                        movie[i].banner.toString() != null)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IndividualMovie(
                                  movieModel: movie[i],
                                  idx: i,
                                  fovouriteMovies: favouriteMovies,
                                  actor: actorModel,
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              fit: BoxFit.cover,
                              movie[i].banner.toString(),
                            ),
                          ),
                        ),
                      )
                    : Container();
              }),
        ),
      ],
    );
  }
}
