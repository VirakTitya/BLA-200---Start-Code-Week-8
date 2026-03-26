import '../../data/repositories/ride/ride_repository.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../states/ride_preference_state.dart';

class RidesSelectionViewModel {
  RidesSelectionViewModel({
    required RidePreferenceState ridePreferenceState,
    required RideRepository rideRepository,
  }) : _ridePreferenceState = ridePreferenceState,
       _rideRepository = rideRepository;

  final RidePreferenceState _ridePreferenceState;
  final RideRepository _rideRepository;

  RidePreference get selectedRidePreference =>
      _ridePreferenceState.selectedPreference!;

  List<Ride> get matchingRides =>
      _rideRepository.getRidesFor(selectedRidePreference);

  void updatePreference(RidePreference preference) {
    _ridePreferenceState.selectPreference(preference);
  }
}
