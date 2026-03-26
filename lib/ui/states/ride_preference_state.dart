import 'package:flutter/foundation.dart';

import '../../data/repositories/ride_preference/ride_preference_repository.dart';
import '../../model/ride_pref/ride_pref.dart';

class RidePreferenceState extends ChangeNotifier {
  RidePreferenceState({required RidePreferenceRepository repository})
    : _repository = repository,
      _selectedPreference = repository.getSelectedPreference(),
      _preferenceHistory = List<RidePreference>.from(
        repository.getPreferenceHistory(),
      );

  final RidePreferenceRepository _repository;
  RidePreference? _selectedPreference;
  List<RidePreference> _preferenceHistory;

  int get maxAllowedSeats => _repository.maxAllowedSeats;

  RidePreference? get selectedPreference => _selectedPreference;

  List<RidePreference> get preferenceHistory =>
      List<RidePreference>.unmodifiable(_preferenceHistory);

  void selectPreference(RidePreference preference) {
    if (preference == _selectedPreference) {
      return;
    }

    _repository.selectPreference(preference);
    _selectedPreference = preference;
    _preferenceHistory = List<RidePreference>.from(
      _repository.getPreferenceHistory(),
    );

    notifyListeners();
  }
}
