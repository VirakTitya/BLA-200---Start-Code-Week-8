import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';
import '../../../app_dependencies.dart';
import '../../../utils/animations_util.dart';
import '../../states/ride_preference_state.dart';
import '../rides_selection/rides_selection_screen.dart';
import 'view_model/home_model.dart';
import 'widgets/home_content.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AppDependencies _dependencies;
  late final HomeModel _viewModel;
  bool _dependenciesReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_dependenciesReady) {
      return;
    }

    _dependencies = AppDependencies.of(context);
    final RidePreferenceState ridePreferenceState =
        _dependencies.ridePreferenceState;
    _viewModel = HomeModel(
      ridePreferenceState: ridePreferenceState,
      locationRepository: _dependencies.locationRepository,
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

  void onRidePrefSelected(RidePreference selectedPreference) async {
    _viewModel.selectPreference(selectedPreference);

    await Navigator.of(
      context,
    ).push(AnimationUtils.createBottomToTopRoute(const RidesSelectionScreen()));
  }

  @override
  Widget build(context) {
    if (!_dependenciesReady) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        _buildBackground(),
        HomeContent(
          viewModel: _viewModel,
          onRidePreferenceSelected: onRidePrefSelected,
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}
