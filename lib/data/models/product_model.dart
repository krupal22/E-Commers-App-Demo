class Product {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final num? price;
  final num? discountPercentage;
  final num? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final num? weight;
  final Dimensions? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<Review>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final Meta? meta;
  final List<String>? images;
  final String? thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    category: json['category'],
    price: (json['price']),
    discountPercentage: (json['discountPercentage']),
    rating: (json['rating']),
    stock: json['stock'],
    tags: json['tags']!=null?List<String>.from(json['tags']):[],
    brand: json['brand'],
    sku: json['sku'],
    weight: (json['weight']),
    dimensions: json['dimensions']!=null?Dimensions.fromJson(json['dimensions']):null,
    warrantyInformation: json['warrantyInformation'],
    shippingInformation: json['shippingInformation'],
    availabilityStatus: json['availabilityStatus'],
    reviews: json['reviews']!=null?List<Review>.from(json['reviews'].map((x) => Review.fromJson(x))):[],
    returnPolicy: json['returnPolicy'],
    minimumOrderQuantity: json['minimumOrderQuantity'],
    meta: json['meta']!=null?Meta.fromJson(json['meta']):null,
    images: json['images']!=null?List<String>.from(json['images']):[],
    thumbnail: json['thumbnail'],
  );


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

}

class Dimensions {
  final num width;
  final num height;
  final num depth;

  Dimensions({required this.width, required this.height, required this.depth});

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    width: (json['width']),
    height: (json['height']),
    depth: (json['depth']),
  );
}

class Review {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    rating: json['rating'],
    comment: json['comment'],
    date: DateTime.parse(json['date']),
    reviewerName: json['reviewerName'],
    reviewerEmail: json['reviewerEmail'],
  );
}

class Meta {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    barcode: json['barcode'],
    qrCode: json['qrCode'],
  );
}
