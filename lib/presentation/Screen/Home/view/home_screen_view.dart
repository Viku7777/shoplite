// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoplite/data/local_data_source/local_data_source.dart';
import 'package:shoplite/domain/models/category_model.dart/category_model.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';
import 'package:shoplite/presentation/Components/common_textfields.dart';
import 'package:shoplite/presentation/Screen/Home/components/home_screen_components.dart';
import 'package:shoplite/presentation/Screen/Home/controller/fav_item_controller.dart';
import 'package:shoplite/presentation/Screen/Home/controller/home_controller.dart';
import 'package:shoplite/presentation/Screen/Home/view/search_view.dart';
import 'package:shoplite/presentation/Screen/Home/view/view_all_products.dart';
import 'package:shoplite/utils/app_const.dart';
import 'package:shoplite/utils/assets/app_images.dart';
import 'package:shoplite/utils/extensions/app_extensions.dart';
import 'package:shoplite/utils/shimmer/common_shimmer_effect.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class HomeScreenView extends ConsumerStatefulWidget {
  const HomeScreenView({super.key});

  @override
  ConsumerState<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends ConsumerState<HomeScreenView> {
  Box<CategoryModel> get categoryBox =>
      Hive.box<CategoryModel>(LocalDataSource.categoryBox);
  Box<ProductModels> get productBox =>
      Hive.box<ProductModels>(LocalDataSource.productBox);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeScreenAppbar(),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              var networkRef = ref.watch(
                AppConst.IS_DEVICE_CONNECT_WITH_INTERNET,
              );
              if (networkRef) {
                return SizedBox();
              } else {
                return HomeScreenComponents.noInternetFoundBanner();
              }
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                initServices();
              },
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                children: [
                  5.vs,
                  InkWell(
                    onTap: () => context.nextScreen(SearchView()),
                    child: CommonTextfields.simpleOutlineBorderTextField(
                      controller: TextEditingController(),
                      hint: "Search",
                      enabled: false,
                    ),
                  ),
                  10.vs,

                  Container(
                    width: double.infinity,
                    height: .22.sh,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage(AppImages.homeScreenSaleBanner),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: .5,
                        ),
                      ],
                    ),
                  ),
                  20.vs,
                  Text("Category", style: AppTextstyle.medium16),
                  10.vs,
                  HomeCategoryWidget(),

                  20.vs,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Latest Products", style: AppTextstyle.medium16),
                      GestureDetector(
                        onTap:
                            () => context.nextScreen(
                              ViewAllProducts(productBox: productBox),
                            ),
                        child: Row(
                          children: [
                            Text("View all", style: AppTextstyle.semibold13),
                            5.hs,
                            Icon(Icons.arrow_forward_ios, size: 12.sp),
                          ],
                        ),
                      ),
                    ],
                  ),
                  10.vs,
                  Consumer(
                    builder: (context, ref, child) {
                      var homeRef = ref.watch(homeStateProvider);
                      if (!homeRef.isloading && homeRef.products.isEmpty) {
                        return Text("No Item Found !!!");
                      } else {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              homeRef.isloading
                                  ? 5
                                  : homeRef.products.length > 10
                                  ? 10
                                  : homeRef.products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: .8,
                              ),
                          itemBuilder: (context, index) {
                            if (homeRef.isloading) {
                              return CommonShimmerEffect(
                                child: ProductCardWidget(
                                  addtoCartClick: (p0) {},
                                  product: ProductModels(
                                    id: 1,
                                    title: "",
                                    description: "",
                                    discountPercentage: 0,
                                    price: 0,
                                    rating: 0,
                                    shippingInformation: "",
                                    images: [],
                                    thumbnail: "",
                                  ),
                                ),
                              );
                            } else {
                              ProductModels product = homeRef.products[index];
                              return ProductCardWidget(
                                product: product,
                                addtoCartClick: (p0) {},
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                  20.vs,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    initServices();
    super.initState();
  }

  void initServices() async {
    Future.delayed(Duration.zero, () async {
      ref.read(favItemProvider.notifier).updateList();
      var homeRef = ref.read(homeStateProvider.notifier);
      await homeRef.getProducts(context: context, box: productBox);
      await homeRef.getCategories(
        context: context,
        box: categoryBox,
        showError: false,
      );
    });
  }
}
