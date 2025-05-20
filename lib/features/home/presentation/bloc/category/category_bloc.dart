import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/category_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entity/category_model.dart';

part 'category_bloc.freezed.dart';
part 'category_state.dart';
part 'category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository}) : super(const CategoryState.initial()) {
    on<LoadCategories>((event, emit) async {
      emit(const CategoryState.loading());
      try {
        final categories = await categoryRepository.getCategories();
        final Map<String, GlobalKey> categoriesKeys = {
          for (final category in categories) category.slug: GlobalKey()
        };
        emit(CategoryState.loaded(categories, categories.first.id, categoriesKeys));
      } catch (e) {
        emit(CategoryState.error('Ошибка загрузки категорий'));
      }
    });

    on<SelectCategory>((event, emit) {
      final currentState = state;
      if(currentState is CategoryLoadedState) {
        emit(currentState.copyWith(selectedCategoryId: event.id));
      }
    });
  }
}
