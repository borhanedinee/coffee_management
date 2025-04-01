// lib/presentation/widgets/product_tile.dart
import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap; // Optional tap action (e.g., open dialog)
  final VoidCallback? onDelete; // Optional tap action (e.g., open dialog)
  final bool isFromManageProducts;

  const ProductTile({
    super.key,
    required this.product,
    this.onTap,
    this.isFromManageProducts = false,
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
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          '${product.price.toInt()} DA',
        ),
        trailing: !isFromManageProducts
            ? Column(
                children: [
                  Text(
                    product.startQuantity != null
                        ? 'start quantity : ${product.startQuantity}'
                        : '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    product.endQuantity != null
                        ? 'end quantity : ${product.endQuantity}'
                        : '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
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
