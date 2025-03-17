import 'package:flutter/material.dart';

class AddProductDialog extends StatelessWidget {
  final VoidCallback? onSave; // Callback for save action
  final VoidCallback? onCancel; // Callback for cancel action
  final TextEditingController nameController;
  final TextEditingController priceController;

  const AddProductDialog({
    super.key,
    this.onSave,
    this.onCancel,
    required this.nameController,
    required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'Add Product', // 'Add Product'
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      content: _ProductForm(
        nameController: nameController,
        priceController: priceController,
      ),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.pop(context),
          child: Text(
            'Cancel', // 'Cancel'
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        TextButton(
          onPressed: onSave,
          child: Text(
            'Save', // 'Save'
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }
}

// Extracted form widget for reusability
class _ProductForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;

  const _ProductForm({
    required this.nameController,
    required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTextField(
          controller: nameController,
          label: 'Product Name', // 'Product Name'
          hint: 'Enter product name', // 'Enter product name'
        ),
        const SizedBox(height: 15),
        _buildTextField(
          controller: priceController,
          label: 'Product Price', // 'Product Price'
          hint: 'Enter product price', // 'Enter product price'
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
