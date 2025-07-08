import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store/core/constant.dart';
import 'package:store/providers/item_count_provider.dart';

import '../models/product_model.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
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
            onPressed: () {},
            icon: Icon(LineAwesomeIcons.cart_plus_solid),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(LineAwesomeIcons.search_solid),
          ),
          SizedBox(width: defaultPadding / 3),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: secondaryColor,
          height: height,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 0.3),
                height: 500,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defaultBorderRadius * 2),
                    topRight: Radius.circular(defaultBorderRadius * 2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: defaultPadding),
                      child: Text(
                        product.category,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: defaultPadding / 2),
                    Text(
                      product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: 'Price\n'),
                                TextSpan(text: '\$ ${product.price.toString()}'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            width: width * 0.3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                defaultBorderRadius,
                              ),
                              child: Hero(
                                tag: product.id,
                                child: CachedNetworkImage(
                                  imageUrl: product.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: 'rate :'),
                              TextSpan(text: ' ${product.rating.toString()}'),
                            ],
                          ),
                        ),
                        Icon(Icons.star, color: yellowClr),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding,
                      ),
                      child: Text(
                        product.description,
                        style: TextStyle(height: 1.5),
                      ),
                    ),
                    Row(
                      children: [
                        OutLineButtonWidget(onPress: Provider.of<ItemCountProvider>(context,listen: false).decrement,icon: Icons.remove),
                        Consumer<ItemCountProvider>(builder : (context ,itemCountProvider,child )=> Padding(
                          padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                          child: Text('${itemCountProvider.num}',style: TextStyle(fontSize: 20),),
                        ) ),
                        OutLineButtonWidget(onPress: Provider.of<ItemCountProvider>(context , listen: false).increment,icon: Icons.add),
                        Spacer(),
                        Container(
                          alignment: Alignment.center,
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF6464),
                            shape: BoxShape.circle
                          ),
                          child: Icon(Icons.favorite,color: Colors.white,),
                        )

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: defaultPadding),
                            height: 50,
                            width: 58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(defaultPadding),
                              border: Border.all(color: primaryColor)
                            ),
                            child: IconButton(onPressed: (){}, icon: Icon(LineAwesomeIcons.cart_plus_solid,color: primaryColor,)),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(defaultPadding),
                                color: primaryColor
                              ),
                              child: Text('Buy Now',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OutLineButtonWidget extends StatelessWidget {
  const OutLineButtonWidget({
    required this.onPress,
    required this.icon,
    super.key,
  });
  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius)
        )
      ),
        onPressed: onPress,
        child: Icon(icon),
      ),
    );
  }
}
