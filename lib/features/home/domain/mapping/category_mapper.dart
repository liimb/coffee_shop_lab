import 'package:coffee_shop/features/home/data/entity/category_dto.dart';
import 'package:coffee_shop/features/home/domain/entity/category_model.dart';

extension CategoryMapper on CategoryDto {
  CategoryModel toModel() {
    return CategoryModel(id: id, slug: slug);
  }
}
