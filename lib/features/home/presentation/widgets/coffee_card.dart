import 'package:flutter/material.dart';
import '../../../../resourses/app_images.dart';
import '../../domain/entity/coffee_model.dart';

class CoffeeCard extends StatelessWidget {
  final CoffeeModel coffee;
  final VoidCallback onAdd;

  const CoffeeCard({
    super.key,
    required this.coffee,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final price = coffee.prices.first.value;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  coffee.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, url, error) => Image.asset(AppImages.coffeeError),
                ),
              ),

              SizedBox(height: 8),

              Text(
                coffee.name,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '$price ₽',
                style: Theme.of(context).textTheme.titleMedium
              ),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, size: 16),
                  onPressed: onAdd,
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                  splashRadius: 18,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
