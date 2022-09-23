part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class FindAllProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}
