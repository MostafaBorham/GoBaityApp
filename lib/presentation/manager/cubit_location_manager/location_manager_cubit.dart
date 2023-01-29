import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yallabaity/application/permissions.dart';

part 'location_state.dart';

class LocationManagerCubit extends Cubit<LocationManagerState> {
  LocationManagerCubit() : super(LocationInitial());
  Position? position;
  List<Placemark>? placeMarks;
  Future<void> getLocation() async {
    if (await Geolocator.isLocationServiceEnabled() || await Geolocator.openLocationSettings()) {
      LocationPermission locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
      }
      switch (locationPermission) {
        case LocationPermission.denied:
          emit(LoadingLocationFailed(message: Permissions.deniedLocationPermission));
          break;
        case LocationPermission.deniedForever:
          emit(LoadingLocationFailed(message: Permissions.deniedLocationPermissionForEver));
          break;
        case LocationPermission.always:
        case LocationPermission.whileInUse:
          position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          emit(LocationLoaded(latitude: position!.latitude, longitude: position!.longitude));
      }
    }
  }

  Future<Placemark> getPlaceInfo()async{
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
      localeIdentifier: 'en_UK',
    );

    return placeMarks[0];
  }
  static getLocationEvent(context)=>BlocProvider.of<LocationManagerCubit>(context).getLocation();
  static gerPlaceNameEvent(context)=>BlocProvider.of<LocationManagerCubit>(context).getPlaceInfo();
}
