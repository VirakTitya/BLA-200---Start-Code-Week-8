import 'package:flutter/widgets.dart';

import 'data/repositories/location/location_repository.dart';
import 'data/repositories/ride/ride_repository.dart';
import 'data/repositories/ride_preference/ride_preference_repository.dart';
import 'ui/states/ride_preferences_state.dart';

class AppDependencies extends InheritedWidget {
  const AppDependencies({
    super.key,
    required super.child,
    required this.locationRepository,
    required this.rideRepository,
    required this.ridePreferenceRepository,
    required this.ridePreferencesState,
  });

  final LocationRepository locationRepository;
  final RideRepository rideRepository;
  final RidePreferenceRepository ridePreferenceRepository;
  final RidePreferencesState ridePreferencesState;

  static AppDependencies of(BuildContext context) {
    final AppDependencies? dependencies =
        context.dependOnInheritedWidgetOfExactType<AppDependencies>();
    assert(dependencies != null, 'AppDependencies not found in widget tree.');
    return dependencies!;
  }

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) {
    return locationRepository != oldWidget.locationRepository ||
        rideRepository != oldWidget.rideRepository ||
        ridePreferenceRepository != oldWidget.ridePreferenceRepository ||
        ridePreferencesState != oldWidget.ridePreferencesState;
  }
}
