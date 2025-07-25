import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store/core/constant.dart';
import 'package:store/screens/cart_page.dart';
import '../models/product_model.dart';
import 'package:delayed_widget/delayed_widget.dart';

import '../providers/cart_provider.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor.withAlpha(200),
        title: Text('Details', style: TextStyle(fontWeight: FontWeight.w400)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.arrow_left_solid),
          onPressed: () => Navigator.pop(context),
          // color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            icon: Icon(LineAwesomeIcons.cart_plus_solid),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(LineAwesomeIcons.search_solid),
          ),
          SizedBox(width: defaultPadding / 3),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: bgColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 2,
                  ),
                  child: Column(
                    children: [
                      /// product image
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding * 2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              defaultBorderRadius,
                            ),
                          ),
                          height: 350,
                          width: width,
                          child: Hero(
                            tag: product.id,
                            createRectTween: (begin, end) {
                              return MaterialRectArcTween(
                                begin: begin,
                                end: end,
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: product.image,
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: defaultPadding / 2),

                      ///category and title
                      DelayedWidget(
                        delayDuration: Duration(milliseconds: 200),
                        animationDuration: Duration(milliseconds: 700),
                        animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.category,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: defaultPadding / 2),
                            Text(
                              product.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: defaultPadding * 2),

                      /// rating
                      DelayedWidget(
                        delayDuration: Duration(milliseconds: 200),
                        animationDuration: Duration(milliseconds: 800),
                        animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                        child: Padding(
                          padding: const EdgeInsets.only(right: defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(LineAwesomeIcons.star_solid, color: starClr),
                              Text(
                                ' ${product.rating.toString()}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '(${product.ratingCount} Review)',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: defaultPadding * 2,
                          bottom: defaultPadding,
                        ),

                        /// description
                        child: DelayedWidget(
                          delayDuration: Duration(milliseconds: 200),
                          animationDuration: Duration(milliseconds: 900),
                          animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product info',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: defaultPadding),
                              Text(
                                product.description,
                                style: TextStyle(height: 1.8, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          ///Bottom of the page
          Container(
            color: Colors.white,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(
                left: defaultPadding * 2,
                bottom: defaultPadding,
                right: defaultPadding * 2,
                top: defaultPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Price :\n',
                          style: TextStyle(color: Colors.grey),
                        ),
                        WidgetSpan(child: SizedBox(height: defaultPadding * 2)),
                        TextSpan(
                          text: '\$ ${product.price.toString()}',
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: width * 0.48,
                    child: ElevatedButton(
                      onPressed: () {
                        final isInCart = cart.isInCart(product.id.toString());

                        if (isInCart) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'This product has already been added to cart ',
                              ),
                              backgroundColor: Colors.orange,
                              duration: Duration(seconds: 3),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {},
                              ),
                            ),
                          );
                        } else {
                          cart.addItem(
                            productId: product.id.toString(),
                            title: product.title,
                            price: product.price,
                            image: product.image,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Product successfully added to cart ',
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        backgroundColor: secondaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LineAwesomeIcons.cart_plus_solid,
                            color: Colors.black,
                          ),
                          SizedBox(width: defaultPadding - 10),
                          Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
