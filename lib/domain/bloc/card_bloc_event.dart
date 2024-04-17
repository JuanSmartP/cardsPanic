part of 'card_bloc_bloc.dart';




@immutable
abstract class CardBlocEvent extends Equatable {
  const CardBlocEvent();
}

class LoadData extends CardBlocEvent {
  @override
  List<Object?> get props => [];
}
