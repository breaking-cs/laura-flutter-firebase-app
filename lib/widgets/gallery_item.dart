import 'package:flutter/material.dart';

class GalleryItem extends StatelessWidget {
  final String imgUrl;

  const GalleryItem({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        imgUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return const Center(child: Text('Loading...'));
          // You can use LinearProgressIndicator or CircularProgressIndicator instead
        },
        errorBuilder: (context, error, stackTrace) =>
            const Text('Some errors occurred!'),
      ),
    );
  }
}
