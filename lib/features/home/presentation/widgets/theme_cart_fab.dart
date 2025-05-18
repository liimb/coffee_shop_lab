import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme/theme_bloc.dart';
import '../bloc/theme/theme_event.dart';
import '../bloc/theme/theme_state.dart';

class ThemeCartFab extends StatelessWidget {
  const ThemeCartFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                label: Text("7979797979 руб", style: Theme.of(context).textTheme.displayLarge)
            ),
          ],
        )
    );
  }
}
