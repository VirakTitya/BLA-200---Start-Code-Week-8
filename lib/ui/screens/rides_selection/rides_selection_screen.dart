import 'package:flutter/material.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../app_dependencies.dart';
import '../../../utils/animations_util.dart' show AnimationUtils;
import '../../widgets/pickers/location/bla_ride_preference_modal.dart';
import '../../states/ride_preference_state.dart';
import '../../theme/theme.dart';
import '../../view_models/rides_selection_view_model.dart';
import 'widgets/rides_selection_header.dart';
import 'widgets/rides_selection_tile.dart';

///
///  The Ride Selection screen allows user to select a ride, once ride preferences have been defined.
///  The screen also allow user to:
///   -  re-define the ride preferences
///   -  activate some filters.
///
class RidesSelectionScreen extends StatefulWidget {
  const RidesSelectionScreen({super.key});

  @override
  State<RidesSelectionScreen> createState() => _RidesSelectionScreenState();
}

class _RidesSelectionScreenState extends State<RidesSelectionScreen> {
  late final RidesSelectionViewModel _viewModel;
  late final RidePreferenceState _ridePreferenceState;
  bool _dependenciesReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_dependenciesReady) {
      return;
    }

    final AppDependencies dependencies = AppDependencies.of(context);
    _ridePreferenceState = dependencies.ridePreferenceState;
    _viewModel = RidesSelectionViewModel(
      ridePreferenceState: _ridePreferenceState,
      rideRepository: dependencies.rideRepository,
    );
    _dependenciesReady = true;
  }

  void onBackTap() {
    Navigator.pop(context);
  }

  void onFilterPressed() {
    // TODO
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  RidePreference get selectedRidePreference =>
      _viewModel.selectedRidePreference;

  List<Ride> get matchingRides => _viewModel.matchingRides;

  void onPreferencePressed() async {
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(initialPreference: selectedRidePreference),
          ),
        );

    if (newPreference != null) {
      _viewModel.updatePreference(newPreference);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_dependenciesReady) {
      return const Scaffold(body: SizedBox.shrink());
    }

    return Scaffold(
      body: AnimatedBuilder(
        animation: _ridePreferenceState,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.only(
              left: BlaSpacings.m,
              right: BlaSpacings.m,
              top: BlaSpacings.s,
            ),
            child: Column(
              children: [
                RideSelectionHeader(
                  ridePreference: selectedRidePreference,
                  onBackPressed: onBackTap,
                  onFilterPressed: onFilterPressed,
                  onPreferencePressed: onPreferencePressed,
                ),
                SizedBox(height: 100),
                Expanded(
                  child: ListView.builder(
                    itemCount: matchingRides.length,
                    itemBuilder: (ctx, index) => RideSelectionTile(
                      ride: matchingRides[index],
                      onPressed: () => onRideSelected(matchingRides[index]),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
