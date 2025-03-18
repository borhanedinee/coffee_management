// lib/presentation/widgets/product_tile.dart
import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap; // Optional tap action (e.g., open dialog)
  final VoidCallback? onDelete; // Optional tap action (e.g., open dialog)
  final Widget? trailing; // Custom trailing widget (e.g., price, button)
  final TextStyle? titleStyle; // Custom title style
  final TextStyle? subtitleStyle; // Custom subtitle style
  final bool isFromStartDay;

  const ProductTile({
    super.key,
    required this.product,
    this.onTap,
    this.trailing,
    this.titleStyle,
    this.subtitleStyle,
    this.isFromStartDay = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        title: Text(
          product.name,
          style: titleStyle ?? Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          '${product.price.toInt()} DA',
        ),
        trailing: isFromStartDay
            ? Text(
                '${product.startQuantity ?? ''}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              )
            : IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete,
                ),
              ),
        onTap: onTap,
      ),
    );
  }
}
