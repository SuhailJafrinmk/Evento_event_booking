part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}
class CategoryEventsLoading extends CategoryState{}
class CategoryEventsFetched extends CategoryState{
  final CategoryModel categoryModel;
  final List<EventModel> events;
  CategoryEventsFetched({required this.events,required this.categoryModel});
}
class FailedFetchingCategoryEvents extends CategoryState{
  final String errorMessage;
  FailedFetchingCategoryEvents({required this.errorMessage});
}