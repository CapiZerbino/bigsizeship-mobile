import 'package:bigsizeship_mobile/core/common/widgets/custom_text_field.dart';
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
            label: 'Tên người nhận',
            controller: widget.nameController,
            hintText: 'Tên người nhận',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập tên người nhận';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: widget.phoneNumberController,
            label: 'Số điện thoại',
            hintText: 'Số điện thoại',
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập số điện thoại';
              }
              // validate vietnam phone number
              if (!RegExp(r'(84|0[3|5|7|8|9])+([0-9]{8})\b').hasMatch(value)) {
                return 'Số điện thoại không hợp lệ';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: widget.addressController,
            hintText: 'Địa chỉ',
            label: 'Địa chỉ',
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
