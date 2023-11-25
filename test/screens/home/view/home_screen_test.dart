import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/cores/cores.dart';
import 'package:weather_app/repositories/repositories.dart';
import 'package:weather_app/screens/home/cubit/home_cubit.dart';
import 'package:weather_app/screens/screens.dart';

class _MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  group(HomeScreen, () {
    late _MockHomeCubit mockHomeCubit;
    final weather = Weather(time: DateTime.now(), temperature: 129);
    final initialState =
        HomeState(weather: weather, status: DataLoadStatus.success);
    setUp(() {
      mockHomeCubit = _MockHomeCubit();
      whenListen(
        mockHomeCubit,
        Stream.value(initialState),
        initialState: initialState,
      );
      when(
        () => mockHomeCubit.searchLocation(
          locationName: any(named: 'locationName'),
        ),
      ).thenAnswer((invocation) async {});
    });
    testWidgets('should render as expectation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeCubit>(
            create: (context) => mockHomeCubit,
            child: const HomeScreen(),
          ),
        ),
      );
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Find your location!'), findsOneWidget);
      expect(
        find.byType(SingleChildScrollView).evaluate().first.widget,
        isA<SingleChildScrollView>().having(
          (scrollView) => scrollView.child,
          'child',
          isA<Center>().having(
            (center) => center.child,
            'child',
            isA<Column>().having(
              (column) => column.children,
              'children',
              orderedEquals([
                isA<Text>().having(
                  (text) => text.data,
                  'data',
                  weather.time.toString(),
                ),
                isA<SizedBox>().having(
                  (sizedBox) => sizedBox.height,
                  'height',
                  8,
                ),
                isA<Text>().having(
                  (text) => text.data,
                  'data',
                  '${weather.temperature}ºF',
                ),
                isA<SizedBox>().having(
                  (sizedBox) => sizedBox.height,
                  'height',
                  16,
                ),
                isA<TextButton>().having(
                  (button) => button.child,
                  'child',
                  isA<Text>().having(
                    (text) => text.data,
                    'data',
                    'View weather detail',
                  ),
                ),
              ]),
            ),
          ),
        ),
      );
    });
    testWidgets(
        'should call HomeCubit.searchLocation() when finishing searching '
        'location', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeCubit>(
            create: (context) => mockHomeCubit,
            child: const HomeScreen(),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'locationName');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      verify(() => mockHomeCubit.searchLocation(locationName: 'locationName'))
          .called(1);
    });

    testWidgets('should show SnackBar when status is ${DataLoadStatus.failure}',
        (tester) async {
      whenListen(
        mockHomeCubit,
        Stream.value(
          HomeState(
            status: DataLoadStatus.failure,
            errorMessage: 'errorMessage',
          ),
        ),
        initialState: initialState,
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeCubit>(
            create: (context) => mockHomeCubit,
            child: const HomeScreen(),
          ),
        ),
      );
      await tester.pump();
      expect(
        find.byType(SnackBar).evaluate().first.widget,
        isA<SnackBar>().having(
          (snackBar) => snackBar.content,
          'content',
          isA<Text>().having((text) => text.data, 'data', 'errorMessage'),
        ),
      );
    });

    testWidgets('should open $WeatherDetailScreen when tapping the button',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeCubit>(
            create: (context) => mockHomeCubit,
            child: const HomeScreen(),
          ),
        ),
      );
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();
      expect(find.byType(WeatherDetailScreen), findsOneWidget);
    });
  });
}
