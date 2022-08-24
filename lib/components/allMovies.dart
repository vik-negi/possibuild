import 'package:flutter/material.dart';
import 'package:possi_build/components/stars.dart';
import 'package:possi_build/components/textContainer.dart';
import 'package:possi_build/models/apiData.dart';
import 'package:possi_build/screens/IndividualMovie.dart';

class AllMovies extends StatelessWidget {
  const AllMovies(
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: GridView.builder(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 30,
              mainAxisExtent: 320,
              crossAxisSpacing: 15,
              crossAxisCount: (Orientation == Orientation.portrait) ? 3 : 2),
          itemCount: movie.length,
          itemBuilder: (context, i) {
            return InkWell(
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    (movie[i].image.toString() != "")
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 190, 190, 190),
                                  blurRadius: 5,
                                  offset: Offset.zero,
                                )
                              ],
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  movie[i].image.toString(),
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Image.network(movie[i].thumbnail.toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.network(movie[i].banner.toString()),
                            ],
                          ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 5, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextContainer(
                            text: movie[i].title.toString(),
                            size: 18,
                            fontweight: FontWeight.w500,
                          ),
                          TextContainer(
                            text: movie[i].directors.toString(),
                            size: 14,
                            color: Colors.grey,
                          ),
                          Stars(count: 3, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
