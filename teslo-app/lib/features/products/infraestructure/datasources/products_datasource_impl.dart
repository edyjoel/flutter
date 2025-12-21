import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/datasources/products_datasource.dart';
import 'package:teslo_shop/features/products/domain/entities/product.dart';
import 'package:teslo_shop/features/products/infraestructure/errors/products_errors.dart';
import 'package:teslo_shop/features/products/infraestructure/mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  late final Dio dio;
  final String accessToken;

  ProductsDatasourceImpl({required this.accessToken})
      : dio = Dio(
          BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );

  Future<String> _uploadFile(String path) async {
    try {
      final fileName = path.split('/').last;
      final FormData data = FormData.fromMap({
        'file': await MultipartFile.fromFile(path, filename: fileName),
      });

      final response = await dio.post('/files/product', data: data);

      return response.data['image'];
    } catch (e) {
      throw Exception('Failed to upload file');
    }
  }

  Future<List<String>> _uploadPhotos(List<String> photos) async {
    final photosToUpload =
        photos.where((photo) => photo.contains('/')).toList();

    final photosToIgnore =
        photos.where((photo) => !photo.contains('/')).toList();

    final List<Future<String>> uploadJob =
        photosToUpload.map(_uploadFile).toList();
    final newImages = await Future.wait(uploadJob);

    return [...photosToIgnore, ...newImages];
  }

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final String? productId = productLike['id'];
      final String method = (productId == null) ? 'POST' : 'PUT';
      final String url =
          (productId == null) ? '/products' : '/products/$productId';
      productLike.remove('id');
      productLike['images'] =
          await _uploadPhotos(List<String>.from(productLike['images'] ?? []));

      final response = await dio.request(url,
          data: productLike, options: Options(method: method));

      final product = ProductMapper.jsonToEntity(response.data);
      return product;
    } catch (e) {
      throw Exception('Failed to create or update product');
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await dio.get('/products/$id');
      return ProductMapper.jsonToEntity(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw ProductNotFound(
            'Error loading product: ${e.response?.statusCode}');
      }
      throw Exception('Connection error');
    } catch (e) {
      throw Exception('Failed to load product');
    }
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    final response =
        await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Product> products = [];
    for (final product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductsByTerm(String term) {
    // TODO: implement searchProductsByTerm
    throw UnimplementedError();
  }
}
