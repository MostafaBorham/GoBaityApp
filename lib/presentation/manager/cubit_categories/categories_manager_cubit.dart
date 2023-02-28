import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:yallabaity/application/app_failures/failures.dart';
import 'package:yallabaity/application/app_failures/map_failure_to_massage.dart';
import 'package:yallabaity/domain/entities/response_entities/categories_response_entity.dart';
import 'package:yallabaity/domain/use_cases/categories_usecases.dart';
import 'package:yallabaity/network_layer/mapper/mapper.dart';
import 'package:yallabaity/network_layer/models/data_models/category_model.dart';

part 'categories_manager_state.dart';

class CategoriesManagerCubit extends Cubit<CategoriesManagerState> {
  CategoriesManagerCubit({required this.categoriesUseCases})
      : super(CategoriesManagerInitial());
  CategoriesUseCase categoriesUseCases;

  getCategories() async {
    emit(CategoriesLoadingState());
    final Either<Failure, CategoriesResponseEntity> categoriesResponse =
        await categoriesUseCases.getAll();
    categoriesResponse.fold(
        (Failure failure) =>
            emit(CategoriesErrorState(message: mapFailureToMessage(failure))),
        (CategoriesResponseEntity categoriesResponse) => emit(
            CategoriesLoadedState(
                categories: categoriesResponse.data!
                    .map((e) => e.fromEntityToModel)
                    .toList())));
  }

  getUserCategories(int id) async {
    emit(CategoriesLoadingState());
    final Either<Failure, CategoriesResponseEntity> categoriesResponse =
        await categoriesUseCases.getUserCategories(id);
    categoriesResponse.fold(
        (Failure failure) =>
            emit(CategoriesErrorState(message: mapFailureToMessage(failure))),
        (CategoriesResponseEntity categoriesResponse) => emit(
            CategoriesLoadedState(
                categories: categoriesResponse.data!
                    .map((e) => e.fromEntityToModel)
                    .toList())));
  }
}
