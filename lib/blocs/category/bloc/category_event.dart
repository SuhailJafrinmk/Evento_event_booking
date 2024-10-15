part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}
class GetEventsByCategory extends CategoryEvent{
  final CategoryModel categoryModel;
  GetEventsByCategory({required this.categoryModel});
}
