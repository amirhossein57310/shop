abstract class ProductCategoryEvent {}

class ProductCategoryResponseEvent extends ProductCategoryEvent {
  String id;
  ProductCategoryResponseEvent(this.id);
}
