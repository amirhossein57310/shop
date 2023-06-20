import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// class CachedImage extends StatelessWidget {
//   String? imageUrl;
//   CachedImage({Key? key, this.imageUrl}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       child: CachedNetworkImage(
//         imageUrl: imageUrl ??
//             'http://startflutter.ir/api/files/f5pm8kntkfuwbn1/78q8w901e6iipuk/rectangle_63_7kADbEzuEo.png',
//         fit: BoxFit.cover,
//         placeholder: (context, url) => Container(
//           color: Colors.grey,
//         ),
//         errorWidget: (context, url, error) => Container(
//           color: Colors.red,
//         ),
//       ),
//     );
//   }
// }

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const CachedImage({Key? key, this.imageUrl, this.radius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl ??
            'http://startflutter.ir/api/files/f5pm8kntkfuwbn1/78q8w901e6iipuk/rectangle_63_7kADbEzuEo.png',
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey,
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
