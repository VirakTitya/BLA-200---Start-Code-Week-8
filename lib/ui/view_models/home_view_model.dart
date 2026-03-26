import '../../model/ride_pref/ride_pref.dart';
import '../states/ride_preference_state.dart';

class HomeViewModel {
  HomeViewModel({required RidePreferenceState ridePreferenceState})
    : _ridePreferenceState = ridePreferenceState;

  final RidePreferenceState _ridePreferenceState;

  RidePreference? get selectedPreference =>
      _ridePreferenceState.selectedPreference;

  List<RidePreference> get history =>
      _ridePreferenceState.preferenceHistory.reversed.toList();

  void selectPreference(RidePreference preference) {
    _ridePreferenceState.selectPreference(preference);
  }
}
