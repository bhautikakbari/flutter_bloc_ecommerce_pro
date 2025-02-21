import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';
import '../core/constants/app_colors.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_card.dart';
import '../core/widgets/app_text.dart';
import '../core/widgets/quantity_selector.dart';
import '../models/product.dart';
import '../views/product_detail_view.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailView(
          product: product,
          heroTag: 'product-${product.id}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(8.r),
      onTap: () => _navigateToDetail(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: 'product-${product.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          AppText.h2(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          AppText.body(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final quantity = state.getQuantity(product.id);

              if (quantity == 0) {
                return AppButton(
                  text: 'Add to Cart',
                  onPressed: () {
                    context.read<CartBloc>().add(AddToCart(product));
                  },
                  height: 40.h,
                );
              }

              return QuantitySelector(
                quantity: quantity,
                onIncrement: () {
                  context.read<CartBloc>().add(AddToCart(product));
                },
                onDecrement: () {
                  context.read<CartBloc>().add(RemoveFromCart(product));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

