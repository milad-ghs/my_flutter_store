import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:store/core/constant.dart';
import 'package:store/models/our_product.dart';
import 'package:store/models/product_model.dart';
import 'package:store/network/response_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/providers/auth_provider.dart';
import '../core/app_color.dart';
import '../providers/product_data_provider.dart';
import 'details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = Provider.of<ProductDataProvider>(
        context,
        listen: false,
      );
      productProvider.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    super.build(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: Consumer<ProductDataProvider>(
        builder: (context, productDataModel, child) {
          switch (productDataModel.state.status) {
            case Status.loading:
              return SafeArea(
                child: GridView.builder(
                  padding: const EdgeInsets.all(defaultPadding),
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.775,
                  ),
                  itemBuilder:
                      (context, index) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(defaultPadding),
                          ),
                        ),
                      ),
                ),
              );

            case Status.completed:
              final auth = context.watch<AuthProvider>();
              final user = auth.currentUser;
              final displayName = (user?.name != null && user!.name!.isNotEmpty) ? user.name! : (user?.phoneNumber ?? 'کاربر');

              List<Product> models = productDataModel.filteredProducts;
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      padding: EdgeInsets.only(
                        right: defaultPadding,
                        left: defaultPadding,
                        top: defaultPadding * 3,
                        bottom: defaultPadding,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hello $displayName !',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: defaultPadding * 2,
                        top: defaultPadding * 2,
                        right: 16,
                        left: 16,
                      ),
                      child: SizedBox(
                        height: 42,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder:
                              (_, __) => const SizedBox(width: 12),
                          itemCount: productDataModel.categories.length,
                          itemBuilder: (context, index) {
                            final category = productDataModel.categories[index];
                            final isSelected =
                                category == productDataModel.selectedCategory;

                            return GestureDetector(
                              onTap: () {
                                productDataModel.selectCategory(category);
                              },
                              child: AnimatedContainer(
                                height: 42,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  gradient:
                                      isSelected
                                          ? LinearGradient(
                                            colors: [
                                              AppColor.primary,
                                              AppColor.primary.withAlpha(200),
                                              AppColor.primaryLight,
                                              AppColor.primaryLight.withAlpha(
                                                180,
                                              ),
                                            ],
                                          )
                                          : null,
                                  color:
                                      isSelected
                                          ? AppColor.primary
                                          : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 300),
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                    child: Text(category),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                    ),

                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 2,
                          duration: const Duration(milliseconds: 400),
                          child: SlideAnimation(
                            horizontalOffset: -50,
                            // delay: Duration(milliseconds: 50 * index),
                            child: FadeInAnimation(
                              child: OurProduct(
                                product: models[index],
                                press: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              DetailsScreen(product: models[index]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }, childCount: models.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: defaultPadding,
                        crossAxisSpacing: defaultPadding,
                        childAspectRatio: 0.635,
                      ),
                    ),
                  ),
                ],
              );

            case Status.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      productDataModel.state.message,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(height: defaultPadding),
                    ElevatedButton.icon(
                      onPressed: () {
                        Provider.of<ProductDataProvider>(
                          context,
                          listen: false,
                        ).getProducts();
                      },
                      label: Text(
                        'Try Again',
                        style: TextStyle(color: textColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
