import 'package:bigsizeship_mobile/core/common/widgets/custom_dropdown_button_form_field.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/district.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/province.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/ward.dart';
import 'package:bigsizeship_mobile/src/address/presentation/bloc/address_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAddressForm extends StatefulWidget {
  SelectAddressForm({
    required this.onSelected,
    super.key,
  });

  void Function(Province? province, District? district, Ward? ward) onSelected;

  @override
  State<SelectAddressForm> createState() => _SelectAddressFormState();
}

class _SelectAddressFormState extends State<SelectAddressForm> {
  List<DropdownMenuItem<Province>> listProvince = [];
  List<DropdownMenuItem<District>> listDistrict = [];
  List<DropdownMenuItem<Ward>> listWard = [];

  Province? selectedProvince;
  District? selectedDistrict;
  Ward? selectedWard;

  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(const GetListProvincesEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressBloc, AddressState>(
      listener: (_, state) {
        if (state is GetListProvincesSuccess) {
          listProvince = state.provinces
              .map(
                (province) => DropdownMenuItem(
                  value: province,
                  child: Text(province.name),
                ),
              )
              .toList();
        } else if (state is GetListDistrictsSuccess) {
          listDistrict = state.districts
              .map(
                (district) => DropdownMenuItem(
                  value: district,
                  child: Text(district.name),
                ),
              )
              .toList();
        } else if (state is GetListWardsSuccess) {
          listWard = state.wards
              .map(
                (ward) => DropdownMenuItem(
                  value: ward,
                  child: Text(ward.name),
                ),
              )
              .toList();
        }
      },
      builder: (context, state) {
        return Column(
          children: <Widget>[
            CustomDropDownButtonFormField(
              items: listProvince,
              label: 'Tỉnh/Thành phố',
              hintText: 'Chọn tỉnh/thành phố',
              value: selectedProvince,
              validator: (province) {
                if (province == null) {
                  return 'Vui lòng chọn tỉnh/thành phố';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  listDistrict = [];
                  listWard = [];
                });
                selectedProvince = value;
                widget.onSelected(value, null, null);

                context.read<AddressBloc>().add(
                      GetListDistrictsEvent(
                        provinceId: value?.provinceId ?? '',
                      ),
                    );
              },
            ),
            const SizedBox(height: 10),
            CustomDropDownButtonFormField<District>(
              items: listDistrict,
              value: selectedDistrict,
              label: 'Quận/Huyện',
              hintText: 'Chọn quận/huyện',
              validator: (district) {
                if (district == null) {
                  return 'Vui lòng chọn quận/huyện';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  listWard = [];
                });
                selectedDistrict = value;
                widget.onSelected(selectedProvince, value, null);
                context.read<AddressBloc>().add(
                      GetListWardsEvent(
                        districtId: value?.districtId ?? '',
                      ),
                    );
              },
            ),
            const SizedBox(height: 10),
            CustomDropDownButtonFormField<Ward>(
              value: selectedWard,
              validator: (ward) {
                if (ward == null) {
                  return 'Vui lòng chọn phường/xã';
                }
                return null;
              },
              label: 'Phường/Xã',
              hintText: 'Chọn phường/xã',
              items: listWard,
              onChanged: (value) {
                selectedWard = value;
                widget.onSelected(selectedProvince, selectedDistrict, value);
              },
            ),
          ],
        );
      },
    );
  }
}
