import 'package:bigsizeship_mobile/core/common/widgets/rounded_button.dart';
import 'package:bigsizeship_mobile/src/address/presentation/widgets/create_address_form.dart';
import 'package:bigsizeship_mobile/src/address/presentation/widgets/select_address_form.dart';
import 'package:flutter/material.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({super.key});

  static const routeName = '/createAddress';

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  final nameController = TextEditingController(text: 'customer@gmail.com');
  final phoneNumberController = TextEditingController(text: 'bss123456');
  final addressController = TextEditingController(text: 'bss123456');
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo kho hàng'),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              CreateAddressForm(
                nameController: nameController,
                phoneNumberController: phoneNumberController,
                formKey: formKey,
                addressController: addressController,
              ),
              const SizedBox(height: 10),
              const SelectAddressForm(),
            ],
          ),
        ),
      ),
    );
  }
}
