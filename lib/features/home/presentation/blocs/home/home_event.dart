part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class ResetHomeEvent extends HomeEvent {}

class SubmitHomeEvent extends HomeEvent {}

class UpdateProfileEvent extends HomeEvent {
  final UpdateProfileParams params;

  const UpdateProfileEvent({required this.params});

  @override
  List<Object?> get props => [params];
}
