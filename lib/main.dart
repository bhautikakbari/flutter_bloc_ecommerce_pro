import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'blocs/cart/cart_bloc.dart';
import 'blocs/product/product_bloc.dart';
import 'core/constants/app_colors.dart';
import 'repositories/product_repository.dart';
import 'views/product_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProductBloc(
                repository: ProductRepository(),
              ),
            ),
            BlocProvider(
              create: (context) => CartBloc(),
            ),
          ],
          child: MaterialApp(
            title: 'Flutter E-Commerce',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.background,
            ),
            home: const ProductListView(),
          ),
        );
      },
    );
  }
}

