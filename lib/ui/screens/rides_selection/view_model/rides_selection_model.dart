import 'package:flutter/foundation.dart';

import '../../../../data/repositories/ride/ride_repository.dart';
import '../../../../model/ride/ride.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../states/ride_preference_state.dart';

class RidesSelectionModel extends ChangeNotifier {
  RidesSelectionModel({
    required RidePreferenceState ridePreferenceState,
    required RideRepository rideRepository,
  }) : _ridePreferenceState = ridePreferenceState,
       _rideRepository = rideRepository {
    _ridePreferenceState.addListener(_onStateChanged);
  }

  final RidePreferenceState _ridePreferenceState;
  final RideRepository _rideRepository;

  RidePreference get selectedRidePreference =>
      _ridePreferenceState.selectedPreference!;

  List<Ride> get matchingRides =>
      _rideRepository.getRidesFor(selectedRidePreference);

  void updatePreference(RidePreference preference) {
    _ridePreferenceState.selectPreference(preference);
  }

  void _onStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _ridePreferenceState.removeListener(_onStateChanged);
    super.dispose();
  }
}
