part of 'category_bloc.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = CategoryInitialState;
  const factory CategoryState.loading() = CategoryLoadingState;
  const factory CategoryState.loaded(List<CategoryModel> categories) = CategoryLoadedState;
  const factory CategoryState.error(String message) = CategoryErrorState;
}
