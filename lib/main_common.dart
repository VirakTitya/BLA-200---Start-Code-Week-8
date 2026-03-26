import 'package:flutter/material.dart';

import 'app_dependencies.dart';
import 'data/repositories/location/location_repository.dart';
import 'data/repositories/ride/ride_repository.dart';
import 'data/repositories/ride_preference/ride_preference_repository.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/states/ride_preferences_state.dart';
import 'ui/theme/theme.dart';

class BlaBlaApp extends StatefulWidget {
  const BlaBlaApp({
    super.key,
    required this.locationRepository,
    required this.rideRepository,
    required this.ridePreferenceRepository,
  });

  final LocationRepository locationRepository;
  final RideRepository rideRepository;
  final RidePreferenceRepository ridePreferenceRepository;

  @override
  State<BlaBlaApp> createState() => _BlaBlaAppState();
}

class _BlaBlaAppState extends State<BlaBlaApp> {
  late final RidePreferencesState _ridePreferencesState;

  @override
  void initState() {
    super.initState();
    _ridePreferencesState = RidePreferencesState(
      repository: widget.ridePreferenceRepository,
    );
  }

  @override
  void dispose() {
    _ridePreferencesState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      locationRepository: widget.locationRepository,
      rideRepository: widget.rideRepository,
      ridePreferenceRepository: widget.ridePreferenceRepository,
      ridePreferencesState: _ridePreferencesState,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: blaTheme,
        home: const Scaffold(body: HomeScreen()),
      ),
    );
  }
}
