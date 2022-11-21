import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/add_review_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/delete_review_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/get_reviews_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/update_review_usecase.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final UpdateReviewUsecase updateReviewUsecase;
  final AddReviewUsecase addReviewUsecase;
  final DeleteReviewUsecase deleteReviewUsecase;
  final GetReviewsUsecase getReviewsUsecase;
  ReviewCubit({
    required this.updateReviewUsecase,
    required this.addReviewUsecase,
    required this.deleteReviewUsecase,
    required this.getReviewsUsecase,
  }) : super(ReviewInitial());

  Future<void> addReview({required ReviewEntity review}) async {
    try {
      emit(ReviewLoadingState());
      await addReviewUsecase.call(review);
    } on SocketException catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    } catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    }
  }

  Future<void> deleteReview({required ReviewEntity review}) async {
    try {
      emit(ReviewLoadingState());
      await deleteReviewUsecase.call(review);
    } on SocketException catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    } catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    }
  }

  Future<void> updateReview({required ReviewEntity review}) async {
    try {
      emit(ReviewLoadingState());
      await updateReviewUsecase.call(review);
    } on SocketException catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    } catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    }
  }

  Future<void> getReviews({required String uid}) async {
    emit(ReviewLoadingState());
    try {
      getReviewsUsecase.call(uid).listen((reviews) {
        emit(ReviewLoadedState(reviews: reviews));
      });
    } on SocketException catch (_) {
      emit(const ReviewErrorState(errorMessage: "Erro ao pegar notas!"));
    } catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    }
  }
}