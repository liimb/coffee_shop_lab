import 'package:flutter/material.dart';

import '../../../../resourses/app_images.dart';

class CartItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int count;
  final int price;

  const CartItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.count,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, url, error) => Image.asset(AppImages.coffeeError),
                ),
              ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: RichText(
              text: TextSpan(
                text: title,
                style: Theme.of(context).textTheme.labelMedium,
                children: [
                  if (count > 1)
                    TextSpan(
                      text: '  $count',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
          ),

          Text("${price.toDouble() / 100} ₽", style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
