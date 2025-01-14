// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/cast_movie_bloc/cast_movie_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/similar_movies/similar_movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/loading_widget.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/modal_add_rating.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/modal_delete_rating.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/similar_movies_widget.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/movies_details_entity.dart';
import 'cast_movie_detail_widget.dart';

class MoviesDetailsWidget extends StatefulWidget {
  final MoviesDetailsEntity movie;
  final MoviesEntity movieEntity;
  const MoviesDetailsWidget({
    Key? key,
    required this.movie,
    required this.movieEntity,
  }) : super(key: key);

  @override
  State<MoviesDetailsWidget> createState() => _MoviesDetailsWidgetState();
}

class _MoviesDetailsWidgetState extends State<MoviesDetailsWidget> {
  @override
  void initState() {
    context.read<ReviewCubit>().getRating(widget.movie.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.movie.releaseDate);

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.movie.backPoster == null
                          ? "https://core360.com.br/shop/skin/frontend/base/default/lib/jlukic_semanticui/examples/assets/images/wireframe/image.png"
                          : "https://image.tmdb.org/t/p/original/${widget.movie.backPoster}",
                    ),
                  ),
                ],
              ),
              AspectRatio(
                aspectRatio: 3 / 2,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(1.0)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 1],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0.0,
                  left: 10.0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0)),
                              height: 120.0,
                              child: AspectRatio(
                                  aspectRatio: 2 / 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: CachedNetworkImage(
                                        imageUrl: widget.movie.poster == null
                                            ? "https://core360.com.br/shop/skin/frontend/base/default/lib/jlukic_semanticui/examples/assets/images/wireframe/image.png"
                                            : "https://image.tmdb.org/t/p/w200/${widget.movie.poster}"),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.movie.title,
                                style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat("dd/MM/yyyy").format(dateTime),
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                left: 5.0,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Duração: ",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        widget.movie.runtime.toString() + " Minutos",
                        style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.red),
                    child: IconButton(
                      onPressed: () {
                        context.read<FavoritesBloc>().add(
                              AddFavoritesEvent(movie: widget.movieEntity),
                            );
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.success,
                          title: 'Favoritado com Sucesso',
                          btnOkText: "Ok",
                          btnOkOnPress: () {},
                        ).show();
                      },
                      icon: const Icon(Icons.favorite_border_sharp,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ModalAddRating(
                    movieModel: widget.movie,
                    child: Container(
                      width: 160,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.amber,
                      ),
                      child: const Center(
                        child: Text(
                          "Deixe seu rating",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<ReviewCubit, ReviewState>(
                    builder: (context, state) {
                      if (state is RatingLoadedState) {
                        print(state.message);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                ModalDeleteRating(
                                        moviesDetailsEntity: widget.movie)
                                    .modalBottomSheet(context);
                              },
                              child: Text(
                                state.message,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      } else if (state is ReviewLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Filme não avaliado",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text("Sobre o filme",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.white)),
              const SizedBox(
                height: 10.0,
              ),
              Text(widget.movie.overview,
                  style: const TextStyle(
                      height: 1.5,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ],
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Atores",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.white)),
              const SizedBox(
                height: 10.0,
              ),
              BlocBuilder<CastMovieBloc, CastMovieState>(
                  builder: (context, state) {
                if (state is CastMovieLoadingState) {
                  return const LoadingWidget();
                } else if (state is CastMovieErrorState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else if (state is CastMovieLoadedState) {
                  return CastMovieDetailWidget(
                    castsList: state.casts,
                  );
                } else {
                  return const Center(
                    child: Text("Algo de errado deu muito errado!"),
                  );
                }
              })
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text("Sobre o Filme",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white)),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Status:",
                      style: TextStyle(fontSize: 14.0, color: Colors.white)),
                  Text(widget.movie.status,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.white))
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Orçamento:",
                      style: TextStyle(fontSize: 14.0, color: Colors.white)),
                  Text("\$ ${widget.movie.budget} doláres",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.white))
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Receita(\$):",
                      style: TextStyle(fontSize: 14.0, color: Colors.white)),
                  Text("\$ ${widget.movie.revenue}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14.0,
                      ))
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Text("Filmes que você pode gostar",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white)),
              ),
              const SizedBox(
                height: 15.0,
              ),
              BlocBuilder<SimilarMoviesBloc, SimilarMoviesState>(
                  builder: (context, state) {
                if (state is SimilarMoviesLoadingState) {
                  return const LoadingWidget();
                } else if (state is SimilarMoviesErrorState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else if (state is SimilarMoviesLoadedState) {
                  return SimilarMoviesWidget(
                    moviesList: state.moviesList,
                  );
                } else {
                  return const Center(
                    child: Text("Algo de errado deu muito errado!"),
                  );
                }
              })
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
