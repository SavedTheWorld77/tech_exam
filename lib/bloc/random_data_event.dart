part of 'random_data_bloc.dart';

abstract class RandomDataEvent extends Equatable {
  const RandomDataEvent();

  @override
  List<Object> get props => [];
}

class SendRandomData extends RandomDataEvent {
  final RandomData randomData;

  const SendRandomData({required this.randomData});

  @override
  List<Object> get props => [randomData];
}
