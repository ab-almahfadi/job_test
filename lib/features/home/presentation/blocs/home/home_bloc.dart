import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:youapp_test/features/home/home.dart';
import 'package:welltested_annotation/welltested_annotation.dart';

part 'home_event.dart';

part 'home_state.dart';

@Welltested()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.updateProfileUseCase,
  }) : super(HomeState.initial()) {
    on<ResetHomeEvent>((event, emit) {
      emit(HomeState.initial());
    });

    on<UpdateProfileEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));

        final usecase = await updateProfileUseCase(event.params);

        usecase.fold((l) {
          emit(state.copyWith(status: Status.failure, failure: l));
        }, (r) {
          emit(state.copyWith(status: Status.success, user: r));
        });
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });
  }

  final UpdateProfileUseCase updateProfileUseCase;
}
