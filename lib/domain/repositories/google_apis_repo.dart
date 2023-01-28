import 'package:dartz/dartz.dart';

import '../../application/app_failures/failures.dart';

abstract class GoogleApisRepo {
  Future<Either<Failure, Unit>> getPlaces({required String placeName});
}