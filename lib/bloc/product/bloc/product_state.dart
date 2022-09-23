part of 'product_bloc.dart';

@immutable
abstract class ProductState extends Equatable {}

class ListProductLoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

class ListProductState extends ProductState {
  List<Product> products = [];

  ListProductState({required this.products});

  @override
  List<Object> get props => [products];
}
