import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../application/app_failures/failures.dart';
import '../../application/network.dart';
import '../../domain/repositories/google_apis_repo.dart';
import '../data_sources/google_apis_remote_datasource.dart';

class GoogleApisRepoImpl extends GoogleApisRepo {
  final GoogleApisRemoteDataSource googleRemoteDataSource;
  final NetworkStatus networkStatus;
  GoogleApisRepoImpl({
    required this.networkStatus,
    required this.googleRemoteDataSource,
  });

  @override
  Future<Either<Failure, Unit>> getPlaces({required String placeName}) async {
    if (await networkStatus.isConnected) {
      // mobile has internet access
      try {
        // get data from remote data source
        Unit places = await googleRemoteDataSource.getPlaces(placeName);

        return Right(places);
      } on InvalidPermissionException {
        return Left(InvalidRequestFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
