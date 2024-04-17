part of 'card_bloc_bloc.dart';

@immutable
abstract class CardBlocInitial extends Equatable {}

class DataLoading extends CardBlocInitial {
  @override
  List<Object?> get props => [];
}



class DataLoaded extends CardBlocInitial {
  DataLoaded(this.users);

  final List<Info> users;

  @override
  List<Object?> get props => [users];
}



class DataError extends CardBlocInitial {

  DataError(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}