import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoplite/data/local_data_source/local_data_source.dart';
import 'package:shoplite/domain/models/fav_product_model.dart/cart_fav_item_model.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';
import 'package:shoplite/presentation/Components/cached_network_image.dart';
import 'package:shoplite/presentation/Screen/Home/controller/fav_item_controller.dart';
import 'package:shoplite/utils/buttons/app_buttons.dart';
import 'package:shoplite/utils/extensions/app_extensions.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class ProductDetailedView extends ConsumerStatefulWidget {
  final ProductModels product;
  const ProductDetailedView({super.key, required this.product});

  @override
  ConsumerState<ProductDetailedView> createState() =>
      _ProductDetailedViewState();
}

class _ProductDetailedViewState extends ConsumerState<ProductDetailedView> {
  String currentImage = "";
  late ProductModels product;
  Box<CartFavItemModel> get cartBox =>
      Hive.box<CartFavItemModel>(LocalDataSource.cartBox);
  @override
  Widget build(BuildContext context) {
    // var productRef = ref.read(cartFavProductProvider.notifier);

    return Scaffold(
      appBar: CustomProductScreenAppbar(),
      persistentFooterButtons: [
        AppButtons.primaryButton(
          title: "Add to cart",
          ontap: () {
            var favProvider = ref.read(favItemProvider.notifier);
            favProvider.addItemToCart(product, context);
            // productRef.addItemInCart(product: product, context: context);
          },
        ),
        20.vs,
      ],
      body: ListView(
        children: [
          Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      widget.product.images
                          .map((e) => ShowNetworkImage(size: .5.sh, url: e))
                          .toList(),
                ),
              ),

              Positioned(
                right: 20.w,
                top: 20.h,
                child: IconButton(
                  onPressed: () {
                    var favProvider = ref.read(favItemProvider.notifier);
                    favProvider.addFav(product);
                  },
                  icon: Consumer(
                    builder: (context, ref, child) {
                      var favProvider = ref.watch(favItemProvider).favItems;
                      return Icon(
                        favProvider.any((e) => e.id == product.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      );
                    },
                  ),
                  iconSize: 35.sp,
                ),
              ),
            ],
          ),
          Divider(),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              10.vs,
              Text(product.title, style: AppTextstyle.medium16),
              5.vs,
              Row(
                children: [
                  Text(
                    "\$${(product.price + product.discountPercentage).toStringAsFixed(2)}",
                    style: AppTextstyle.medium16.copyWith(
                      color: Colors.red,
                      fontSize: 18.sp,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                    ),
                  ),
                  10.hs,
                  Text(
                    "${product.price}/-",
                    style: AppTextstyle.medium16.copyWith(fontSize: 20.sp),
                  ),
                ],
              ),
              12.vs,
              Text(
                "Description of product",
                style: AppTextstyle.semibold14.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              5.vs,
              Text(product.description),
              12.vs,
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    initDate();
    super.initState();
  }

  void initDate() {
    product = widget.product;
    currentImage = product.images.first;
  }
}

class CustomProductScreenAppbar extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomProductScreenAppbar({super.key});

  @override
  State<CustomProductScreenAppbar> createState() =>
      _CustomProductScreenAppbarState();

  @override
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomProductScreenAppbarState extends State<CustomProductScreenAppbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(top: 10.h),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                context.popScreen();
              },
              icon: Icon(Icons.arrow_back),
            ),
            10.hs,
            Text("Product Details", style: AppTextstyle.medium16),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
          ],
        ),
      ),
    );
  }
}
