import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';
import 'package:shoplite/presentation/Components/common_textfields.dart';
import 'package:shoplite/presentation/Screen/Home/components/home_screen_components.dart';
import 'package:shoplite/presentation/Screen/Home/controller/home_controller.dart';
import 'package:shoplite/utils/extensions/app_extensions.dart';
import 'package:shoplite/utils/shimmer/common_shimmer_effect.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search ", style: AppTextstyle.medium16),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            10.vs,
            CommonTextfields.simpleOutlineBorderTextField(
              controller: searchController,
              hint: "Search",
              onChanged: (p0) {
                if (p0.isNotEmpty) {
                  onSearchChanged(p0);
                }
              },
            ),
            10.vs,
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  var homeRef = ref.watch(homeStateProvider);
                  if (!homeRef.isloading && homeRef.search.isEmpty) {
                    return Center(child: Text("No Item Found !!!"));
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: homeRef.isloading ? 5 : homeRef.search.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                        }
                        ProductModels product = homeRef.search[index];

                        return ProductCardWidget(
                          product: product,
                          addtoCartClick: (p0) {},
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Timer? _debounce;

  void onSearchChanged(String query) {
    // cancel old timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // start new timer
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref
          .read(homeStateProvider.notifier)
          .getProductViaSearch(context: context, query: query);
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ref.read(homeStateProvider.notifier).clearSearchTime();
    });
    super.initState();
  }
}
