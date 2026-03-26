import 'package:blabla/data/repositories/location/location_repository_mock.dart';
import 'package:blabla/data/repositories/ride/ride_repository_mock.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository_mock.dart';
import 'package:blabla/main_common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home screen renders search action', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlaBlaApp(
        locationRepository: LocationRepositoryMock(),
        rideRepository: RideRepositoryMock(),
        ridePreferenceRepository: RidePreferenceRepositoryMock(),
      ),
    );

    expect(find.text('Search'), findsOneWidget);
  });
}
