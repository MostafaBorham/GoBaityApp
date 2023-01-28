import 'package:dartz/dartz.dart';

import '../../application/app_failures/failures.dart';
import '../repositories/google_apis_repo.dart';

class GoogleApisUseCases {
  final GoogleApisRepo googleApisRepo;
  GoogleApisUseCases({required this.googleApisRepo});
  Future<Either<Failure, Unit>> getPlaces({required String placeName}) => googleApisRepo.getPlaces(placeName: placeName);
}
