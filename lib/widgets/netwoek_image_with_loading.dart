import 'package:flutter/material.dart';

class NetworkImageWithLoading extends StatelessWidget {
  String imagePath;
  BoxFit? fit;
  Widget? errorWidget;
  double? height;
  double? width;

  NetworkImageWithLoading(
      {required this.imagePath, this.fit, this.errorWidget,this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      height: height,
      width: width,
      imagePath,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ??
          Center(
            child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
          ),
    );
  }
}
