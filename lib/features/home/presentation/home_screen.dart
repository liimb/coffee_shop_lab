import 'package:coffee_shop/features/home/presentation/bloc/theme/theme_bloc.dart';
import 'package:coffee_shop/features/home/presentation/bloc/theme/theme_event.dart';
import 'package:coffee_shop/features/home/presentation/bloc/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/category/category_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          switch (state) {
            case CategoryInitialState():
              return const Text("Начальное состояние");

            case CategoryLoadingState():
              return const CircularProgressIndicator();

            case CategoryLoadedState():
              final loadedState = state;
              final categories = loadedState.categories;
              return ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((e) => Text(e.slug)).toList(),
              );

            case CategoryErrorState():
              final errorState = state;
              return Text("Ошибка: ${errorState.message}");

            default:
              return const SizedBox();
          }
        },
      )
      ),

      floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 50,
                  height: 50,
                  child: BlocBuilder<ThemeBloc, ThemeState> (builder: (context, state) {
                    return FloatingActionButton(
                      onPressed: () {
                        context.read<ThemeBloc>().add(ToggleTheme());
                      },
                      heroTag: "themeFAB",
                      child: Image.asset(
                          context.read<ThemeBloc>().getThemeIcon(),
                          width: 25,
                          height: 25
                      ),
                    );
                  })
              ),
              FloatingActionButton.extended (
                  onPressed: () {

                  },
                  heroTag: "cartFAB",
                  icon: Image.asset("assets/images/cart_shopping.png", width: 25, height: 25),
                  label: Text("2200 руб", style: Theme.of(context).textTheme.displayLarge)
              ),
            ],
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
