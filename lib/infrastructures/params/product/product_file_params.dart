import 'dart:io';

class ProductFileParams {
  final int? id;
  final File? file;
  final String? imageUrl;

  const ProductFileParams({
    this.id,
    this.file,
    this.imageUrl,
  });
}
