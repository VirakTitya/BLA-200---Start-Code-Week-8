import 'package:blabla/data/dummy_data.dart';

import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import 'ride_repository.dart';

class RideRepositoryMock implements RideRepository {
  final List<Ride> _rides = fakeRides;

  @override
  List<Ride> getAllRides() {
    return _rides;
  }

  @override
  List<Ride> getRidesFor(RidePreference preferences) {
    return _rides
        .where(
          (ride) =>
              ride.departureLocation == preferences.departure &&
              ride.arrivalLocation == preferences.arrival &&
              ride.availableSeats >= preferences.requestedSeats,
        )
        .toList();
  }
}
