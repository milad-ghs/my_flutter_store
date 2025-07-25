import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/core/constant.dart';
import 'package:store/models/product_model.dart';

class OurProduct extends StatelessWidget {
  final Product product;
  final VoidCallback press;

  const OurProduct({super.key, required this.product, required this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.only(
                top: defaultPadding * 1.3,
                left: defaultPadding * 1.3,
                right: defaultPadding * 1.3,
              ),
              height: 170,
              width: 170,
              decoration: BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                child: Hero(
                  tag: product.id,
                  createRectTween: (begin, end) {
                    return MaterialRectArcTween(begin: begin, end: end);
                  },
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right :defaultPadding / 2 , top: defaultPadding  , left: defaultPadding / 2 , bottom: defaultPadding / 2),
            child: Text(product.title, style: TextStyle(color: text2Color,fontSize:12) , maxLines: 2,overflow: TextOverflow.ellipsis),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: Text(
              '\$ ${product.price}',
              style: TextStyle(fontWeight: FontWeight.w700,color: backgroundColor,letterSpacing:1.05,fontSize: 19),
            ),
          ),
        ],
      ),
    );
  }
}
