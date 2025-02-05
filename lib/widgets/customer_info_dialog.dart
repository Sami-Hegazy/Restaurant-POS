import 'package:flutter/material.dart';
import 'package:restaurant_pos/generated/l10n.dart';
import '../models/order_model.dart';

class CustomerInfoDialog extends StatefulWidget {
  const CustomerInfoDialog({super.key});

  @override
  State<CustomerInfoDialog> createState() => _CustomerInfoDialogState();
}

class _CustomerInfoDialogState extends State<CustomerInfoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: const Color(0xff1f2029),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).customerInfo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: S.of(context).name,
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrangeAccent),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).nameRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: S.of(context).phone,
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrangeAccent),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                style: const TextStyle(color: Colors.white),
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: S.of(context).address,
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrangeAccent),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(S.of(context).cancel),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          CustomerInfo(
                            name: _nameController.text,
                            phone: _phoneController.text.isEmpty
                                ? null
                                : _phoneController.text,
                            address: _addressController.text.isEmpty
                                ? null
                                : _addressController.text,
                          ),
                        );
                      }
                    },
                    child: Text(S.of(context).submit),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
