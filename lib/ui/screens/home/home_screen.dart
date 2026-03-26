import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';
import '../../../app_dependencies.dart';
import '../../../utils/animations_util.dart';
import '../../states/ride_preferences_state.dart';
import '../../theme/theme.dart';
import '../../view_models/home_view_model.dart';
import '../../widgets/pickers/ride_preference/bla_ride_preference_picker.dart';
import '../rides_selection/rides_selection_screen.dart';
import 'widgets/home_history_tile.dart';

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
  late final RidePreferencesState _ridePreferencesState;
  late final HomeViewModel _viewModel;
  bool _dependenciesReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_dependenciesReady) {
      return;
    }

    _dependencies = AppDependencies.of(context);
    _ridePreferencesState = _dependencies.ridePreferencesState;
    _viewModel = HomeViewModel(ridePreferencesState: _ridePreferencesState);
    _dependenciesReady = true;
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

    return AnimatedBuilder(
      animation: _ridePreferencesState,
      builder: (context, child) {
        return Stack(children: [_buildBackground(), _buildForeground()]);
      },
    );
  }

  Widget _buildForeground() {
    return Column(
      children: [
        // 1 - THE HEADER
        SizedBox(height: 16),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            "Your pick of rides at low price",
            style: BlaTextStyles.heading.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(height: 100),

        Container(
          margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2 - THE FORM
              BlaRidePreferencePicker(
                initRidePreference: _viewModel.selectedPreference,
                locationRepository: _dependencies.locationRepository,
                maxAllowedSeats: _ridePreferencesState.maxAllowedSeats,
                onRidePreferenceSelected: onRidePrefSelected,
              ),
              SizedBox(height: BlaSpacings.m),

              // 3 - THE HISTORY
              _buildHistory(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory() {
    List<RidePreference> history = _viewModel.history;
    return SizedBox(
      height: 200, // Set a fixed height
      child: ListView.builder(
        shrinkWrap: true, // Fix ListView height issue
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (ctx, index) => HomeHistoryTile(
          ridePref: history[index],
          onPressed: () => onRidePrefSelected(history[index]),
        ),
      ),
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
