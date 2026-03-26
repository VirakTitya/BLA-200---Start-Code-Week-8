import 'package:flutter/foundation.dart';

import '../../../../data/repositories/location/location_repository.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../states/ride_preference_state.dart';

class HomeModel extends ChangeNotifier {
  HomeModel({
    required RidePreferenceState ridePreferenceState,
    required this.locationRepository,
  }) : _ridePreferenceState = ridePreferenceState {
    _ridePreferenceState.addListener(_onStateChanged);
  }

  final RidePreferenceState _ridePreferenceState;
  final LocationRepository locationRepository;

  RidePreference? get selectedPreference => _ridePreferenceState.selectedPreference;

  List<RidePreference> get history =>
      _ridePreferenceState.preferenceHistory.reversed.toList();

  int get maxAllowedSeats => _ridePreferenceState.maxAllowedSeats;

  void selectPreference(RidePreference preference) {
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
