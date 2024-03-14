import 'package:bigsizeship_mobile/core/common/widgets/custom_text_field.dart';
import 'package:bigsizeship_mobile/core/common/widgets/rounded_button.dart';
import 'package:bigsizeship_mobile/src/address/presentation/views/select_address_screen.dart';
import 'package:flutter/material.dart';

class CreateAddressForm extends StatefulWidget {
  const CreateAddressForm({
    required this.nameController,
    required this.phoneNumberController,
    required this.addressController,
    required this.formKey,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final TextEditingController addressController;

  final GlobalKey<FormState> formKey;

  @override
  State<CreateAddressForm> createState() => _CreateAddressFormState();
}

class _CreateAddressFormState extends State<CreateAddressForm> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: widget.nameController,
            hintText: 'Tên người nhận',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: widget.phoneNumberController,
            hintText: 'Số điện thoại',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: widget.addressController,
            hintText: 'Địa chỉ',
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
