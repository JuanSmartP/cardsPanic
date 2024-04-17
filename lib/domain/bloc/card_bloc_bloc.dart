// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:widget_panic_button/domain/repositorie/repositoreies.dart';
import 'package:widget_panic_button/models/panic_models.dart';

part 'card_bloc_event.dart';
part 'card_bloc_state.dart';

class CardBlocBloc extends Bloc<CardBlocEvent, CardBlocInitial> {
  final DataRepository _dataRepository;

  CardBlocBloc(this._dataRepository) : super(DataLoading()) {
    on<LoadData>(
      (event, emit) async {
        emit(DataLoading());
        try {
          final users = await _dataRepository.getPanicData();
          emit(DataLoaded(users));
        } catch (e) {
          emit(DataError(e.toString()));
          print('====>>>>>${e.toString()}');
        }
      },
    );
  }
}
