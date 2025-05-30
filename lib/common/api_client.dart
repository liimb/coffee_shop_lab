import 'package:coffee_shop/features/coffee/data/entity/dto/coffee_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../features/category/data/entity/dto/category_response_dto.dart';
import '../features/order/data/entity/order_dto.dart';
import '../features/order/data/entity/order_response_dto.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("products/categories")
  Future<CategoryResponseDto> getCategories({
    @Query("page") int page = 0,
    @Query("limit") int limit = 100,
    @Header('Content-Type') String contentType = 'application/json',
  });

  @GET("products")
  Future<CoffeeResponseDto> getCoffee({
    @Query("page") int page = 0,
    @Query("limit") int limit = 100,
    @Header('Content-Type') String contentType = 'application/json',
  });
  
  @POST("orders")
  Future<OrderResponseDto> createOrder(
    @Body() OrderDto body,
    {@Header('Content-Type') String contentType = 'application/json'}
  );
}
