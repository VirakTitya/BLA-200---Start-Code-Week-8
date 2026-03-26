import '../../model/ride_pref/ride_pref.dart';
import '../states/ride_preferences_state.dart';

class HomeViewModel {
  HomeViewModel({required RidePreferencesState ridePreferencesState})
    : _ridePreferencesState = ridePreferencesState;

  final RidePreferencesState _ridePreferencesState;

  RidePreference? get selectedPreference =>
      _ridePreferencesState.selectedPreference;

  List<RidePreference> get history =>
      _ridePreferencesState.preferenceHistory.reversed.toList();

  void selectPreference(RidePreference preference) {
    _ridePreferencesState.selectPreference(preference);
  }
}
