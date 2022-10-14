// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:projeto_movies_clean_arciteture/src/core/error/exceptions.dart';

import 'package:projeto_movies_clean_arciteture/src/core/error/failures.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/datasources/remote/movies_remote_datasource.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/cast_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/genre_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_details_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/person_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/repositories/movies_repository.dart';

class MoviesRepositoryImplementation implements IMoviesRepository {
  final IMoviesRemoteDatasource moviesRemoteDatasource;
  MoviesRepositoryImplementation({
    required this.moviesRemoteDatasource,
  });

  @override
  Future<Either<Failure, List<CastEntity>>> getCastList(int movieId) async {
    try {
      final movies = await moviesRemoteDatasource.getCastList(movieId);
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<GenreEntity>>> getGenreList() async {
    try {
      final movies = await moviesRemoteDatasource.getGenreList();

      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MoviesEntity>>> getMovieByGenre(
      int movieId) async {
    try {
      final movies = await moviesRemoteDatasource.getMovieByGenre(movieId);

      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MoviesDetailsEntity>> getMoviesDetail(
      int movieId) async {
    try {
      final movies = await moviesRemoteDatasource.getMoviesDetail(movieId);
      print(movies);
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MoviesEntity>>> getNowMovies() async {
    try {
      final movies = await moviesRemoteDatasource.getNowMovies();

      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MoviesEntity>>> getSimilarMovies(
      int movieId) async {
    try {
      final movies = await moviesRemoteDatasource.getSimilarMovies(movieId);

      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> getTrendingPerson() async {
    try {
      final movies = await moviesRemoteDatasource.getTrendingPerson();

      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MoviesEntity>>> getUpcomingMovies() async {
    try {
      final movies = await moviesRemoteDatasource.getUpcomingMovies();
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
