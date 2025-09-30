import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoplite/domain/models/fav_product_model.dart/cart_fav_item_model.dart';
import 'package:shoplite/presentation/Components/cached_network_image.dart';
import 'package:shoplite/presentation/Screen/Home/controller/fav_item_controller.dart';
import 'package:shoplite/utils/extensions/app_extensions.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class CartProductWidget extends ConsumerStatefulWidget {
  final CartFavItemModel cartItem;
  final VoidCallback onTapIncrease;
  final VoidCallback onTapDecrease;

  const CartProductWidget({
    super.key,
    required this.cartItem,
    required this.onTapIncrease,
    required this.onTapDecrease,
  });

  @override
  ConsumerState<CartProductWidget> createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends ConsumerState<CartProductWidget> {
  late CartFavItemModel cartItem;
  ValueNotifier quantity = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    var cartRef = ref.read(favItemProvider.notifier);
    return Container(
      padding: EdgeInsets.all(6.sp),
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: .5),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ShowNetworkImage(
              size: 100,
              url: widget.cartItem.productModel.thumbnail,
            ),
          ),
          5.hs,
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        cartItem.productModel.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextstyle.medium16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cartRef.deleteProduct(cartItem);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
                3.vs,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "\$ ${cartItem.productModel.price.toStringAsFixed(2)}",
                      style: AppTextstyle.medium16,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        quantity.value += 1;
                        cartRef.increaseQuantity(cartItem);
                        widget.onTapIncrease();
                      },
                      icon: Icon(Icons.add_circle),
                    ),
                    ValueListenableBuilder(
                      valueListenable: quantity,
                      builder: (context, value, child) {
                        return Text(
                          quantity.value.toString(),
                          style: AppTextstyle.medium16,
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        int newvalue = quantity.value - 1;
                        if (newvalue != 0) {
                          quantity.value -= 1;
                          widget.onTapDecrease();
                        }
                      },
                      icon: Icon(Icons.remove_circle),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    cartItem = widget.cartItem;
    quantity.value = cartItem.quantity;
    super.initState();
  }
}
