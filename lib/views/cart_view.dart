import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_state.dart';
import '../core/constants/app_colors.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_text.dart';
import '../widgets/cart_item_card.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.h1('Shopping Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64.sp,
                    color: AppColors.secondary,
                  ),
                  SizedBox(height: 16.h),
                  AppText.h2(
                    'Your cart is empty',
                    style: TextStyle(color: AppColors.secondary),
                  ),
                  SizedBox(height: 8.h),
                  AppText.body(
                    'Add items to get started',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 24.h),
                  AppButton(
                    text: 'Start Shopping',
                    onPressed: () => Navigator.pop(context),
                    width: 200.w,
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(16.r),
                  itemCount: state.items.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final item = state.items.values.elementAt(index);
                    return CartItemCard(cartItem: item);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.body('Total Items:'),
                          AppText.body(
                            state.items.length.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.h2('Total Amount:'),
                          AppText.h2(
                            '\$${state.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      AppButton(
                        text: 'Proceed to Checkout',
                        onPressed: () {
                          // Implement checkout functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: AppText.body(
                                'Checkout functionality coming soon!',
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

