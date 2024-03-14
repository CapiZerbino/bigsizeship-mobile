import 'package:bigsizeship_mobile/core/common/widgets/rounded_button.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/district.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/province.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/ward.dart';
import 'package:bigsizeship_mobile/src/address/presentation/bloc/address_bloc.dart';
import 'package:bigsizeship_mobile/src/address/presentation/widgets/create_address_form.dart';
import 'package:bigsizeship_mobile/src/address/presentation/widgets/select_address_form.dart';
import 'package:bigsizeship_mobile/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({super.key});

  static const routeName = '/createAddress';

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  Province? selectedProvince;
  District? selectedDistrict;
  Ward? selectedWard;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo kho hàng'),
      ),
      body: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is CreateAddressSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  CreateAddressForm(
                    nameController: nameController,
                    phoneNumberController: phoneNumberController,
                    addressController: addressController,
                    formKey: formKey,
                  ),
                  const SizedBox(height: 10),
                  SelectAddressForm(
                    onSelected: (province, district, ward) {
                      setState(() {
                        selectedProvince = province;
                        selectedDistrict = district;
                        selectedWard = ward;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  if (state is CreateAddressLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    RoundedButton(
                      label: 'Tạo kho hàng',
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            selectedProvince != null &&
                            selectedDistrict != null &&
                            selectedWard != null) {
                          final userId = context
                              .read<AuthenticationBloc>()
                              .currentUser
                              ?.id;
                          context.read<AddressBloc>().add(
                                CreateAddressEvent(
                                  name: nameController.text,
                                  phoneNumber: phoneNumberController.text,
                                  address: addressController.text,
                                  province: selectedProvince!.name,
                                  district: selectedDistrict!.name,
                                  ward: selectedWard!.name,
                                  userId: userId ?? -1,
                                  provinceCode: selectedProvince!.provinceId,
                                  districtCode: selectedDistrict!.districtId,
                                  wardCode: selectedWard!.wardId,
                                  isDefault: false,
                                  addressType: AddressType.SENDER,
                                ),
                              );
                        }
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
