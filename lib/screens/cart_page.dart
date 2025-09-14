import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store/core/constant.dart';
import '../core/app_color.dart';
import '../providers/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartPage extends StatefulWidget {
  final bool showAppBar;

  const CartPage({super.key, this.showAppBar = false});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();
    final cartKeys = cart.items.keys.toList();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColor.backgroundMedium,
      appBar:
          AppBar(
                backgroundColor: theme.appBarTheme.backgroundColor,
                title: Text(
                  'Cart',
                  style: theme.appBarTheme.titleTextStyle,
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(LineAwesomeIcons.arrow_left_solid),
                  onPressed: () => Navigator.pop(context),
                  // color: Colors.black,
                ),
              ),

      body:
          cart.itemCount == 0
              ? Center(
                child: Lottie.asset(
                  'assets/animations/NoData.json',
                  height: 250,
                  width: 250,
                ),
              )
              : SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.touch_app, color: Colors.black, size: 20),
                          Text(
                            'swipe on an item to delete',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cart.itemCount,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          final productId = cartKeys[index];

                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) async {
                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (ctx) => Dialog(
                                        backgroundColor: AppColor.backgroundLight,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Container(
                                            color: Colors.white.withOpacity(0.3),
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Are you sure?',
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                const Text(
                                                  'Do you want to remove this item from the cart?',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                                const SizedBox(height: 25),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: TextButton(
                                                        style: TextButton.styleFrom(
                                                          backgroundColor: Colors.grey.shade300,
                                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(12),
                                                          ),
                                                        ),
                                                        onPressed: () => Navigator.of(ctx).pop(false),
                                                        child: const Text(
                                                          'No',
                                                          style: TextStyle(color: Colors.black, fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Expanded(
                                                      child: TextButton(
                                                        style: TextButton.styleFrom(
                                                          backgroundColor: Colors.redAccent,
                                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(12),
                                                          ),
                                                        ),
                                                        onPressed: () => Navigator.of(ctx).pop(true),
                                                        child: const Text(
                                                          'Yes',
                                                          style: TextStyle(color: Colors.white, fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                    if (confirmed == true ) {
                                      cart.removeItem(productId);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Product successfully deleted.'),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                    }
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: PhosphorIcons.trash(PhosphorIconsStyle.regular),
                                  label: 'Delete',
                                )
                                ,
                                SlidableAction(
                                  onPressed: (_) => (),
                                  backgroundColor: const Color(0xFF0392CF),
                                  foregroundColor: Colors.white,
                                  icon: PhosphorIcons.x(PhosphorIconsStyle.regular),
                                  label: 'Close',
                                ),
                              ],
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    defaultBorderRadius * 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          defaultPadding / 2,
                                        ),
                                        child: CachedNetworkImage(
                                          height: 95,
                                          width: 95,
                                          // fit: BoxFit.cover,
                                          imageUrl: item.image,
                                        ),
                                      ),
                                      SizedBox(width: defaultPadding),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Baseline(
                                                    baseline: 24,
                                                    baselineType:
                                                        TextBaseline.alphabetic,
                                                    child: Text(
                                                      item.title,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 10),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '\$${(item.price).toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.primary,
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          defaultPadding * 2,
                                                        ),
                                                    color: AppColor.primary,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed:
                                                            () => cart
                                                                .decreaseQuantity(
                                                                  productId,
                                                                ),
                                                        icon: Icon(
                                                          Icons.remove,
                                                          color:
                                                              AppColor
                                                                  .backgroundLight,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${item.quantity}',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              AppColor
                                                                  .backgroundLight,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed:
                                                            () => cart
                                                                .increaseQuantity(
                                                                  productId,
                                                                ),
                                                        icon: Icon(
                                                          Icons.add,
                                                          color:
                                                              AppColor
                                                                  .backgroundLight,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    /// payment
                    Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Payment',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${cart.totalAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),

                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    defaultBorderRadius,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Process to Payment',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
