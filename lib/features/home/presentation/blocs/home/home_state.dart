part of 'home_bloc.dart';

enum Status {
  initial,
  loading,
  isInfinite,
  proses,
  success,
  updated,
  failure,
}

class HomeState extends Equatable {
  const HomeState({
    this.failure,
    this.user,
    this.status = Status.initial,
  });

  factory HomeState.initial() {
    return const HomeState();
  }

  final Status status;
  final Failure? failure;
  final User? user;

  HomeState copyWith({
    Status? status,
    Failure? failure,
    User? user,
  }) {
    return HomeState(
      failure: failure,
      user: user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        user,
        status,
      ];
}
