import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';
import 'package:shoplite/presentation/Screen/Home/components/home_screen_components.dart';
import 'package:shoplite/presentation/Screen/Home/controller/home_controller.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

var isLoadingStateProvider = StateProvider<bool>((ref) {
  return false;
});

class ViewAllProducts extends ConsumerStatefulWidget {
  final Box<ProductModels> productBox;
  const ViewAllProducts({super.key, required this.productBox});

  @override
  ConsumerState<ViewAllProducts> createState() => _ViewAllProductsState();
}

class _ViewAllProductsState extends ConsumerState<ViewAllProducts> {
  final ScrollController scrollController = ScrollController();
  bool apiCalled = false; // to prevent multiple calls
  int currentIndex = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Products", style: AppTextstyle.medium16),
        backgroundColor: Colors.transparent,
      ),
      body: ValueListenableBuilder(
        valueListenable: widget.productBox.listenable(),
        builder: (context, Box<ProductModels> box, child) {
          if (box.isEmpty) {
            return const Center(child: Text("No Item found !!"));
          } else {
            return ListView(
              controller: scrollController,
              children: [
                GridView.builder(
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
                    ProductModels? product = box.getAt(index);

                    if (product == null) {
                      return SizedBox();
                    } else {
                      return ProductCardWidget(
                        product: product,
                        addtoCartClick: (p0) {},
                      );
                    }
                  },
                ),
                4.h.verticalSpace,
                Consumer(
                  builder: (context, ref, child) {
                    if (ref.watch(isLoadingStateProvider)) {
                      return Center(
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(6.sp),
                            child: Text(
                              "Load More ...",
                              style: AppTextstyle.medium16,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                // if (apiCalled) ...,
              ],
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() async {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double threshold = maxScroll * 0.75; // 75%

      if (currentScroll >= threshold && !apiCalled) {
        apiCalled = true; // prevent duplicate calls
        ref.read(isLoadingStateProvider.notifier).state = true;
        await ref
            .read(homeStateProvider.notifier)
            .getProducts(
              clearOldItems: false,
              context: context,
              box: widget.productBox,
              index: currentIndex,
            )
            .then((e) {
              currentIndex += 10;
            });
        apiCalled = false;
        ref.read(isLoadingStateProvider.notifier).state = false;
      }
    });
  }
}
