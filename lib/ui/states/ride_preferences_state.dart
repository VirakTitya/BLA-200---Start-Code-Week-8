import 'package:flutter/foundation.dart';

import '../../data/repositories/ride_preference/ride_preference_repository.dart';
import '../../model/ride_pref/ride_pref.dart';

class RidePreferencesState extends ChangeNotifier {
  RidePreferencesState({required RidePreferenceRepository repository})
    : _repository = repository;

  final RidePreferenceRepository _repository;

  int get maxAllowedSeats => _repository.maxAllowedSeats;

  RidePreference? get selectedPreference => _repository.getSelectedPreference();

  List<RidePreference> get preferenceHistory => _repository.getPreferenceHistory();

  void selectPreference(RidePreference preference) {
    final RidePreference? previous = selectedPreference;
    _repository.selectPreference(preference);

    if (previous != selectedPreference) {
      notifyListeners();
    }
  }
}
