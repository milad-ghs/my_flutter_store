import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/core/constant.dart';
import 'package:store/models/our_product.dart';
import 'package:store/models/product_model.dart';
import 'package:store/network/response_model.dart';
import 'package:shimmer/shimmer.dart';
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
    super.build(context);
    return Scaffold(
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
                        'Home',
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
                        bottom: defaultPadding,
                        top: defaultPadding / 2,
                      ),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2,
                          ),
                          itemCount: productDataModel.categories.length,
                          itemBuilder: (context, index) {
                            final category = productDataModel.categories[index];
                            final isSelected =
                                category == productDataModel.selectedCategory;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2,
                              ),
                              child: ChoiceChip(
                                showCheckmark: false,
                                label: Text(category),
                                selected: isSelected,
                                onSelected: (_) {
                                  productDataModel.selectCategory(category);
                                },
                                selectedColor: secondaryColor,
                                backgroundColor: Colors.grey[200],
                                labelStyle: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
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
                        return OurProduct(
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
            default:
              return Container();
          }
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
