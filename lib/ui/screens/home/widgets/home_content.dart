import 'package:flutter/material.dart';

import '../../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../widgets/pickers/ride_preference/bla_ride_preference_picker.dart';
import '../view_model/home_model.dart';
import 'home_history_tile.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    required this.viewModel,
    required this.onRidePreferenceSelected,
  });

  final HomeModel viewModel;
  final ValueChanged<RidePreference> onRidePreferenceSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, child) {
        final List<RidePreference> history = viewModel.history;

        return Column(
          children: [
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Your pick of rides at low price',
                style: BlaTextStyles.heading.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 100),
            Container(
              margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlaRidePreferencePicker(
                    initRidePreference: viewModel.selectedPreference,
                    locationRepository: viewModel.locationRepository,
                    maxAllowedSeats: viewModel.maxAllowedSeats,
                    onRidePreferenceSelected: onRidePreferenceSelected,
                  ),
                  SizedBox(height: BlaSpacings.m),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: history.length,
                      itemBuilder: (ctx, index) => HomeHistoryTile(
                        ridePref: history[index],
                        onPressed: () => onRidePreferenceSelected(history[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
