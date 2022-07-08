import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/random_datamodel.dart';

part 'random_data_event.dart';
part 'random_data_state.dart';

class RandomDataBloc extends Bloc<RandomDataEvent, RandomDataState> {
  RandomDataBloc() : super(RandomDataInitial()) {
    on<SendRandomData>((event, emit) async {
      await event.randomData.sendRandomData();
      emit(RandomDataLoaded(randomData: event.randomData));
    });
  }

  void onDataSend(SendRandomData randomData, Emitter<RandomDataState> emit) {
    emit(RandomDataLoaded(randomData: randomData.randomData));
  }
}
