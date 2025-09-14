import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store/core/constant.dart';
import 'package:store/screens/cart_page.dart';
import 'package:store/widgets/debouncer.dart';
import '../core/app_color.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({super.key, required this.product});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _buttonController;
  late Animation<double> _buttonScale;

  late AnimationController _badgeController;
  late Animation<double> _badgeScale;

  late OverlayEntry _overlayEntry;
  late AnimationController _flyController;
  late Animation<Offset> _flyAnimation;
  late Animation<double> _flyScale;

  final GlobalKey _imageKey = GlobalKey();
  final GlobalKey _cartKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _buttonScale = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOutBack),
    );

    _badgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _badgeScale = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _badgeController, curve: Curves.elasticOut),
    );

    _flyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    _badgeController.dispose();
    _flyController.dispose();
    super.dispose();
  }

  void _animateButton() {
    _buttonController.forward().then((_) => _buttonController.reverse());
  }

  void _animateBadge() {
    _badgeController.forward().then((_) => _badgeController.reverse());
  }

  void _runFlyToCartAnimation() {
    final RenderBox imageBox =
        _imageKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox cartBox =
        _cartKey.currentContext!.findRenderObject() as RenderBox;

    final imagePos = imageBox.localToGlobal(Offset.zero);
    final cartPos = cartBox.localToGlobal(Offset.zero);

    _flyAnimation = Tween<Offset>(
      begin: imagePos,
      end: Offset(cartPos.dx, cartPos.dy),
    ).animate(CurvedAnimation(parent: _flyController, curve: Curves.easeIn));

    _flyScale = Tween<double>(
      begin: 1.0,
      end: 0.2,
    ).animate(CurvedAnimation(parent: _flyController, curve: Curves.easeIn));

    _overlayEntry = OverlayEntry(
      builder:
          (context) => AnimatedBuilder(
            animation: _flyController,
            builder: (_, __) {
              return Positioned(
                left: _flyAnimation.value.dx,
                top: _flyAnimation.value.dy,
                child: Transform.scale(
                  scale: _flyScale.value,
                  child: CachedNetworkImage(
                    imageUrl: widget.product.image,
                    width: imageBox.size.width,
                    height: imageBox.size.height,
                  ),
                ),
              );
            },
          ),
    );

    Overlay.of(context).insert(_overlayEntry);
    _flyController.forward().then((_) {
      _overlayEntry.remove();
      _flyController.reset();
      _animateBadge();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final cart = Provider.of<CartProvider>(context, listen: false);
    final theme = Theme.of(context);
    final debouncer = Debouncer(milliseconds: 1000);

    return Scaffold(
      backgroundColor: AppColor.backgroundLight,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(
          'Details',
          style: theme.appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LineAwesomeIcons.arrow_left_solid),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer<CartProvider>(
            builder:
                (_, cartProvider, __) => Stack(
                  children: [
                    IconButton(
                      key: _cartKey,
                      icon: const Icon(
                        LineAwesomeIcons.shopping_cart_solid,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const CartPage(showAppBar: true),
                          ),
                        );
                      },
                    ),
                    if (cartProvider.itemCount > 0)
                      Positioned(
                        right: 2,
                        top: 2,
                        child: ScaleTransition(
                          scale: _badgeScale,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${cartProvider.itemCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(LineAwesomeIcons.search_solid),
          ),
          const SizedBox(width: defaultPadding / 3),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: AppColor.backgroundLight,
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
                          key: _imageKey,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              defaultBorderRadius,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          height: 350,
                          width: width,
                          child: Hero(
                            tag: widget.product.id,
                            createRectTween:
                                (begin, end) => MaterialRectArcTween(
                                  begin: begin,
                                  end: end,
                                ),
                            child: CachedNetworkImage(
                              imageUrl: widget.product.image,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding / 2),

                      ///category and title
                      DelayedWidget(
                        delayDuration: const Duration(milliseconds: 200),
                        animationDuration: const Duration(milliseconds: 700),
                        animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.category,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            Text(
                              widget.product.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 2),

                      /// rating
                      DelayedWidget(
                        delayDuration: const Duration(milliseconds: 200),
                        animationDuration: const Duration(milliseconds: 800),
                        animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                        child: Row(
                          children: [
                            RatingBarIndicator(
                              rating: widget.product.rating,
                              itemBuilder: (BuildContext context, int index) {
                                return Icon(
                                  LineAwesomeIcons.star_solid,
                                  color: AppColor.star,
                                );
                              },
                              itemCount: 5,
                              itemSize: 33,
                              itemPadding: EdgeInsets.symmetric(horizontal: 2),
                              direction: Axis.horizontal,
                            ),
                            SizedBox(width: defaultPadding),
                            Text(
                              '(${widget.product.ratingCount} Review)',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 2),

                      ///description
                      Padding(
                        padding: const EdgeInsets.only(bottom: defaultPadding),
                        child: DelayedWidget(
                          delayDuration: const Duration(milliseconds: 200),
                          animationDuration: const Duration(milliseconds: 900),
                          animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Product info',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: defaultPadding),
                              Text(
                                widget.product.description,
                                style: const TextStyle(
                                  height: 1.8,
                                  fontSize: 15,
                                  letterSpacing: 0.7,
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
            ),
          ),

          ///Bottom of the page
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(40, 10),
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(defaultPadding * 2),
                topLeft: Radius.circular(defaultPadding * 2),
              ),
            ),
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
                        const TextSpan(
                          text: 'Price :\n',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: '\$ ${widget.product.price.toString()}',
                          style: const TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ScaleTransition(
                    scale: _buttonScale,
                    child: SizedBox(
                      height: 55,
                      width: width * 0.48,
                      child: ElevatedButton(
                        onPressed: () {
                         debouncer.run((){
                           _animateButton();

                           final isInCart = cart.isInCart(
                             widget.product.id.toString(),
                           );
                           if (isInCart) {
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                 action: SnackBarAction(
                                   label: 'Close',
                                   onPressed: () {},
                                   textColor: Colors.red,
                                 ),
                                 content: const Text(
                                   'This product has already been added to cart',
                                   style: TextStyle(color: Colors.black),
                                 ),
                                 backgroundColor: AppColor.warning,
                                 duration: const Duration(seconds: 3),
                               ),
                             );
                           } else {
                             cart.addItem(
                               productId: widget.product.id.toString(),
                               title: widget.product.title,
                               price: widget.product.price,
                               image: widget.product.image,
                             );
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                 content: const Text(
                                   'Product successfully added to cart',
                                 ),
                                 duration: const Duration(seconds: 3),
                                 backgroundColor: AppColor.success,
                               ),
                             );
                             _runFlyToCartAnimation();
                           }
                         });
                        },
                        style: theme.elevatedButtonTheme.style,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              LineAwesomeIcons.cart_plus_solid,
                              color: Colors.white,
                            ),
                            SizedBox(width: defaultPadding - 10),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
