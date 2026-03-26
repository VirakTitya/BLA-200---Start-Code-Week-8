import 'package:flutter/material.dart';

import '../../../../model/ride/ride.dart';
import '../../../theme/theme.dart';
import '../view_model/rides_selection_model.dart';
import 'rides_selection_header.dart';
import 'rides_selection_tile.dart';

class RidesSelectionContent extends StatelessWidget {
  const RidesSelectionContent({
    super.key,
    required this.viewModel,
    required this.onBackPressed,
    required this.onFilterPressed,
    required this.onPreferencePressed,
    required this.onRideSelected,
  });

  final RidesSelectionModel viewModel;
  final VoidCallback onBackPressed;
  final VoidCallback onFilterPressed;
  final VoidCallback onPreferencePressed;
  final ValueChanged<Ride> onRideSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, child) {
        final List<Ride> matchingRides = viewModel.matchingRides;

        return Padding(
          padding: const EdgeInsets.only(
            left: BlaSpacings.m,
            right: BlaSpacings.m,
            top: BlaSpacings.s,
          ),
          child: Column(
            children: [
              RideSelectionHeader(
                ridePreference: viewModel.selectedRidePreference,
                onBackPressed: onBackPressed,
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
    );
  }
}
