part of 'category_bloc.dart';

@freezed
class CategoryEvent with _$CategoryEvent {
  const factory CategoryEvent.loadCategories() = LoadCategories;
  const factory CategoryEvent.selectCategory(int id) = SelectCategory;
}
