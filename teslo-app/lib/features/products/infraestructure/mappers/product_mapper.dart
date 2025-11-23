import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductMapper {
  static jsonToEntity(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        price: double.parse(json['price'].toString()),
        description: json['description'],
        slug: json['slug'],
        stock: json['stock'],
        sizes: List<String>.from(json['sizes'].map((size) => size.toString())),
        gender: json['gender'],
        tags: List<String>.from(json['tags'].map((tag) => tag.toString())),
        images: List<String>.from(json['images'].map((image) =>
            image.startsWith('http')
                ? image
                : '${Environment.apiUrl}/files/product/$image')),
        user: UserMapper.userJsonToEntity(json['user']),
      );
}
