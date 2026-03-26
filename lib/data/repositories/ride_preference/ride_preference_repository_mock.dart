import '../../../model/ride_pref/ride_pref.dart';
import 'ride_preference_repository.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository {
  RidePreference? _selectedPreference;
  final List<RidePreference> _preferenceHistory = [];

  @override
  int get maxAllowedSeats => 8;

  @override
  RidePreference? getSelectedPreference() {
    return _selectedPreference;
  }

  @override
  List<RidePreference> getPreferenceHistory() {
    return List<RidePreference>.unmodifiable(_preferenceHistory);
  }

  @override
  void selectPreference(RidePreference preference) {
    if (preference == _selectedPreference) {
      return;
    }

    _selectedPreference = preference;
    _preferenceHistory.add(preference);
  }
}
