import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_shop/features/theme/presentation/widget/theme_fab.dart';
import 'package:coffee_shop/resourses/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/presentation/bloc/theme_bloc.dart';
import '../../theme/presentation/bloc/theme_event.dart';
import '../domain/entity/coffee_model.dart';

class CoffeeDetailsScreen extends StatelessWidget {
  const CoffeeDetailsScreen({required CoffeeModel coffee, super.key, required this.onBack}) : _coffeeModel = coffee;

  final CoffeeModel _coffeeModel;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
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
                          onPressed: onBack,
                          icon: Image.asset(AppImages.back, color: Theme.of(context).colorScheme.onSecondaryFixed)
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
                          child:
                          CachedNetworkImage(
                            imageUrl: _coffeeModel.imageUrl,
                            fit: BoxFit.contain,
                            errorWidget: (context, url, error) => Image.asset(AppImages.coffeeError),
                          )
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

      floatingActionButton: ThemeFab(
          onPressed: () {
            context.read<ThemeBloc>().add(ToggleTheme());
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
