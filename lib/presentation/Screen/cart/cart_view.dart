import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoplite/domain/models/fav_product_model.dart/cart_fav_item_model.dart';
import 'package:shoplite/presentation/Components/success_order_bottom_sheet.dart';
import 'package:shoplite/presentation/Screen/Home/controller/fav_item_controller.dart';
import 'package:shoplite/presentation/Screen/cart/cart_components.dart';
import 'package:shoplite/utils/buttons/app_buttons.dart';
import 'package:shoplite/utils/extensions/app_extensions.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _FavouriteItemViewState();
}

class _FavouriteItemViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).primaryColorDark.withAlpha(50),
            ),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.r),
            topLeft: Radius.circular(15.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.vs,
            Text("Order Summary", style: AppTextstyle.medium16),
            5.vs,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Totals", style: AppTextstyle.medium16),
                ValueListenableBuilder(
                  valueListenable: cartBox.listenable(),

                  builder: (context, value, child) {
                    num totalAmount = 0;
                    List<CartFavItemModel> allItems = value.values.toList();
                    for (var element in allItems) {
                      int quantity = element.quantity;
                      num price = element.productModel.price;
                      totalAmount += quantity * price;
                    }
                    return Text(
                      "\$ ${totalAmount.toStringAsFixed(2)}",
                      style: AppTextstyle.medium16,
                    );
                  },
                ),
              ],
            ),
            10.vs,

            AppButtons.primaryButton(
              title: "Place Order",
              ontap: () {
                showModalBottomSheet(
                  scrollControlDisabledMaxHeightRatio: .45,
                  context: context,
                  builder: (context) {
                    return SuccessOrderBottomSheet();
                  },
                );
              },
            ),
            10.vs,
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Cart ", style: AppTextstyle.medium16),
        backgroundColor: Colors.transparent,
      ),
      body: ValueListenableBuilder(
        valueListenable: cartBox.listenable(),
        builder: (context, Box<CartFavItemModel> box, child) {
          List<CartFavItemModel> items =
              box.values.toList().where((e) => e.quantity != 0).toList();
          if (items.isEmpty) {
            return const Center(child: Text("No Item found !!"));
          } else {
            List<CartFavItemModel> items =
                box.values.toList().where((e) => e.quantity != 0).toList();

            return ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                CartFavItemModel product = items[index];
                final project = box.getAt(index)!;

                return CartProductWidget(
                  cartItem: product,
                  onTapDecrease: () {
                    project.quantity--;
                    project.save();
                  },
                  onTapIncrease: () {
                    project.quantity++;
                    project.save();
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
