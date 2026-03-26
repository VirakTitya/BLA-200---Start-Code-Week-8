import 'package:flutter/material.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../app_dependencies.dart';
import '../../../utils/animations_util.dart' show AnimationUtils;
import '../../widgets/pickers/location/bla_ride_preference_modal.dart';
import '../../states/ride_preference_state.dart';
import 'view_model/rides_selection_model.dart';
import 'widgets/rides_selection_content.dart';

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
  late final RidesSelectionModel _viewModel;
  bool _dependenciesReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_dependenciesReady) {
      return;
    }

    final AppDependencies dependencies = AppDependencies.of(context);
    final RidePreferenceState ridePreferenceState =
        dependencies.ridePreferenceState;
    _viewModel = RidesSelectionModel(
      ridePreferenceState: ridePreferenceState,
      rideRepository: dependencies.rideRepository,
    );
    _dependenciesReady = true;
  }

  @override
  void dispose() {
    if (_dependenciesReady) {
      _viewModel.dispose();
    }
    super.dispose();
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

  void onPreferencePressed() async {
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(
              initialPreference: _viewModel.selectedRidePreference,
            ),
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
      body: RidesSelectionContent(
        viewModel: _viewModel,
        onBackPressed: onBackTap,
        onFilterPressed: onFilterPressed,
        onPreferencePressed: onPreferencePressed,
        onRideSelected: onRideSelected,
      ),
    );
  }
}
