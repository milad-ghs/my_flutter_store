import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/core/constant.dart';
import '../providers/cart_provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CartIconWithBadge extends StatelessWidget {
  final VoidCallback onTap;

  const CartIconWithBadge({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final itemCount = cartProvider.itemCount;

    return Stack(
      children: [
        IconButton(
          icon: Icon(LineAwesomeIcons.shopping_cart_solid, size: 34),
          onPressed: onTap,
        ),
        if (itemCount > 0)
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              padding: EdgeInsets.all(defaultPadding / 4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                '$itemCount',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
