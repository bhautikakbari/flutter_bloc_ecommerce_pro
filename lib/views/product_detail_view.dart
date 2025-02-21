import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';
import '../core/constants/app_colors.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_text.dart';
import '../core/widgets/quantity_selector.dart';
import '../models/product.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;
  final String heroTag;

  const ProductDetailView({
    Key? key,
    required this.product,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: heroTag,
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.h1(product.name),
                  SizedBox(height: 8.h),
                  AppText.h2(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  AppText.body(product.description),
                  SizedBox(height: 24.h),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      final quantity = state.getQuantity(product.id);

                      if (quantity == 0) {
                        return AppButton(
                          text: 'Add to Cart',
                          onPressed: () {
                            context.read<CartBloc>().add(AddToCart(product));
                          },
                        );
                      }

                      return Row(
                        children: [
                          QuantitySelector(
                            quantity: quantity,
                            onIncrement: () {
                              context.read<CartBloc>().add(AddToCart(product));
                            },
                            onDecrement: () {
                              context.read<CartBloc>().add(RemoveFromCart(product));
                            },
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: AppText.body(
                              'Total: \$${(product.price * quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

