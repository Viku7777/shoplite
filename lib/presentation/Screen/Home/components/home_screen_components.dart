import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';
import 'package:shoplite/main.dart';
import 'package:shoplite/presentation/Components/cached_network_image.dart';
import 'package:shoplite/presentation/Screen/Auth/controller/auth_controller.dart';
import 'package:shoplite/presentation/Screen/Home/controller/fav_item_controller.dart';
import 'package:shoplite/presentation/Screen/Home/controller/home_controller.dart';
import 'package:shoplite/presentation/Screen/Home/view/product_detailed_view.dart';
import 'package:shoplite/presentation/Screen/cart/cart_view.dart';
import 'package:shoplite/presentation/Screen/favourite/favourite.dart';
import 'package:shoplite/utils/buttons/app_buttons.dart';
import 'package:shoplite/utils/extensions/app_extensions.dart';
import 'package:shoplite/utils/shimmer/common_shimmer_effect.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class HomeScreenComponents {
  static Widget noInternetFoundBanner() {
    return Container(
      height: 40.h,
      color: Colors.red,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off_outlined),
          12.hs,
          Text(
            "No Internet Found !!",
            style: AppTextstyle.semibold14.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHomeScreenAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomHomeScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          children: [
            Text("Welcome Back", style: AppTextstyle.medium16),
            Spacer(),
            IconButton(
              onPressed: () {
                context.nextScreen(CartView());
              },
              icon: Icon(Icons.shopping_cart),
            ),
            IconButton(
              onPressed: () {
                context.nextScreen(FavouriteItemView());
              },
              icon: Icon(Icons.favorite),
            ),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      themeNotifier.value =
                          themeNotifier.value == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light;
                    },
                    child: Text(
                      themeNotifier.value == ThemeMode.light
                          ? "Dark Mode"
                          : "Light Mode",
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      logoutFuncation(context);
                    },
                    child: Text("Logout"),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var categoryRef = ref.watch(homeStateProvider);
        if (categoryRef.isloading) {
          return CommonShimmerEffect(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    [1, 2, 3, 4, 5]
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Column(
                              children: [
                                CircleAvatar(child: Icon(Icons.category)),
                                5.vs,
                                Container(
                                  height: 10,
                                  width: 55.w,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  categoryRef.categories
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Column(
                            children: [
                              CircleAvatar(child: Icon(Icons.category)),
                              5.vs,
                              SizedBox(
                                width: 55.w,
                                child: Text(
                                  e.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          );
        }
      },
    );
  }
}

class ProductCardWidget extends ConsumerWidget {
  final Function(int) addtoCartClick;
  const ProductCardWidget({
    super.key,
    required this.product,
    required this.addtoCartClick,
  });

  final ProductModels product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        context.nextScreen(ProductDetailedView(product: product));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColorDark.withAlpha(50),
              blurRadius: 4,
              spreadRadius: .5,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ShowNetworkImage(size: 100.sp, url: product.thumbnail),
            ),
            5.vs,
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: AppTextstyle.semibold13,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("\$ ${product.price}/-", style: AppTextstyle.medium16),
                  2.vs,
                  SizedBox(
                    height: 30.h,
                    child: AppButtons.primaryButton(
                      title: "Add to cart",
                      ontap: () {
                        var favProvider = ref.read(favItemProvider.notifier);
                        favProvider.addItemToCart(product, context);
                      },
                    ),
                  ),

                  2.vs,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
