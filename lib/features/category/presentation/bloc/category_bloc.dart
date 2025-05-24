import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../util/request_retry.dart';
import '../../domain/repository/category_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entity/category_model.dart';

part 'category_bloc.freezed.dart';
part 'category_state.dart';
part 'category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _categoryRepository;

  CategoryBloc({required categoryRepository}) : _categoryRepository = categoryRepository, super(const CategoryState.initial()) {
    on<LoadCategoriesEvent>((event, emit) async {
      emit(const CategoryState.loading());
      try {
        final categories = await fetchWithRetry(() => _categoryRepository.getCategories());
        emit(CategoryState.loaded(categories, categories.first.id));
      } catch (e) {
        final categories = await _categoryRepository.getCategoriesFromDb();
        if(categories.isNotEmpty) {
          emit(CategoryState.loaded(categories, categories.first.id));
        } else {
          emit(CategoryState.error('Ошибка загрузки категорий'));
        }
      }
    });

    on<SelectCategoryEvent>((event, emit) {
      final currentState = state;
      if(currentState is CategoryLoadedState) {
        emit(currentState.copyWith(selectedCategoryId: event.id));
      }
    });
  }
}
