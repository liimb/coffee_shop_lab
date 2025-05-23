import 'package:coffee_shop/features/theme/presentation/widget/theme_fab.dart';
import 'package:coffee_shop/resourses/app_images.dart';
import 'package:coffee_shop/uikit/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../domain/entity/coffee_model.dart';
import '../../theme/presentation/bloc/theme_bloc.dart';

class CoffeeDetailsScreen extends StatelessWidget {
  const CoffeeDetailsScreen({required CoffeeModel coffee, super.key}) : _coffeeModel = coffee;

  final CoffeeModel _coffeeModel;

  @override
  Widget build(BuildContext context) {

    final isLight = context.watch<ThemeBloc>().state.themeMode == ThemeMode.light; //TODO: убрать проверку темы

    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 40,
                      child: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Image.asset(AppImages.back, color: isLight ? AppColors.neutralDark : AppColors.white)
                      )
                  )
                ],
              ),

              const SizedBox(height: 8),

              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            _coffeeModel.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, url, error) => Image.asset(AppImages.coffeeError),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        _coffeeModel.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.start,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        _coffeeModel.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  )
              )
            ]
        ),
      ),

      floatingActionButton: ThemeFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
