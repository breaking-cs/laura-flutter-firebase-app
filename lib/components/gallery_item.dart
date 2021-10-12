import 'package:flutter/material.dart';

class GalleryItem extends StatelessWidget {
  final String title;
  final String imgUrl;

  const GalleryItem({
    Key? key,
    required this.title,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        // leading: IconButton(icon: Icon(Icons.favorite), onPressed: null),
        // trailing: IconButton(icon: Icon(Icons.shopping_cart), onPressed: null),
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
      child: Image.network(
        imgUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
