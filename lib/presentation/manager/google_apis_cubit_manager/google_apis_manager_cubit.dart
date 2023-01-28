import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../application/app_failures/failures.dart';
import '../../../application/app_failures/map_failure_to_massage.dart';
import '../../../domain/use_cases/google_apis_usescases.dart';

part 'google_apis_manager_state.dart';

class GoogleApisManagerCubit extends Cubit<GoogleApisManagerState> {
  final GoogleApisUseCases googleApisUseCases;
  GoogleApisManagerCubit({required this.googleApisUseCases}) : super(GoogleApisManagerInitial());
  getPlaces({required String placeName}) async {
    Either<Failure, Unit> either = await googleApisUseCases.getPlaces(placeName: placeName);
    either.fold(
        (failure) => emit(GoogleAutoCompletePlacesFailState()), (adsResponse) => emit(GoogleAutoCompletePlacesSuccessState()));
  }

  static getPlacesEvent({required BuildContext context, required String placeName}) {
    BlocProvider.of<GoogleApisManagerCubit>(context).getPlaces(placeName: placeName);
  }
}
