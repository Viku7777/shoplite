import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoplite/domain/models/fav_product_model.dart/cart_fav_item_model.dart';
import 'package:shoplite/domain/models/fav_product_model.dart/fav_items.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';
import 'package:shoplite/presentation/Screen/Home/components/home_screen_components.dart';
import 'package:shoplite/presentation/Screen/Home/controller/fav_item_controller.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class FavouriteItemView extends StatefulWidget {
  const FavouriteItemView({super.key});

  @override
  State<FavouriteItemView> createState() => _FavouriteItemViewState();
}

class _FavouriteItemViewState extends State<FavouriteItemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite ", style: AppTextstyle.medium16),
        backgroundColor: Colors.transparent,
      ),
      body: ValueListenableBuilder(
        valueListenable: favItemBox.listenable(),
        builder: (context, Box<FavItemsModel> box, child) {
          if (box.isEmpty) {
            return const Center(child: Text("No Item found !!"));
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(12.sp),
              shrinkWrap: true,
              itemCount: box.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) {
                ProductModels? product = box.getAt(index)?.productModel;
                if (product == null) {
                  return SizedBox();
                } else {
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
    );
  }
}
