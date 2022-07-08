part of 'random_data_bloc.dart';

abstract class RandomDataState extends Equatable {
  const RandomDataState();

  @override
  List<Object> get props => [];
}

class RandomDataInitial extends RandomDataState {}

class RandomDataLoaded extends RandomDataState {
  final RandomData randomData;
  const RandomDataLoaded({required this.randomData});

  @override
  List<Object> get props => [randomData];
}

class RandomDataLoading extends RandomDataState {}
