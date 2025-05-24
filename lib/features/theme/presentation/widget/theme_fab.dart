import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/theme_bloc.dart';
import '../bloc/theme_state.dart';

class ThemeFab extends StatelessWidget {
  const ThemeFab({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50,
        height: 50,
        child: BlocBuilder<ThemeBloc, ThemeState> (
            builder: (context, state) {
              return FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: onPressed,
                heroTag: "themeFAB",
                child: Image.asset(
                    context.read<ThemeBloc>().getThemeIcon(),
                    width: 25,
                    height: 25
                ),
              );
            }
        )
    );
  }
}
