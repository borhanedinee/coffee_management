// lib/presentation/widgets/product_tile.dart
import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap; // Optional tap action (e.g., open dialog)
  final Widget? trailing; // Custom trailing widget (e.g., price, button)
  final TextStyle? titleStyle; // Custom title style
  final TextStyle? subtitleStyle; // Custom subtitle style

  const ProductTile({
    super.key,
    required this.product,
    this.onTap,
    this.trailing,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        title: Text(
          product.name,
          style: titleStyle ?? Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          '${product.price.toInt()} DA',
        ),
        trailing: Text(
          '${product.startQuantity ?? 'll'}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        onTap: onTap,
      ),
    );
  }
}
