import 'package:coffee_shop/features/price/data/entity/dto/price_dto.dart';
import 'package:coffee_shop/features/price/domain/entity/price_model.dart';

extension PriceMapper on PriceDto {
  PriceModel toModel() {
    return PriceModel(value: value, currency: currency);
  }
}