import 'package:bigsizeship_mobile/core/services/injection_container.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/district.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/province.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/ward.dart';
import 'package:bigsizeship_mobile/src/address/presentation/bloc/address_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// reassignment locator

class SelectAddressForm extends StatefulWidget {
  const SelectAddressForm({super.key});

  @override
  State<SelectAddressForm> createState() => _SelectAddressFormState();
}

class _SelectAddressFormState extends State<SelectAddressForm> {
  final _addressBloc = locator.get<AddressBloc>();

  List<DropdownMenuItem<Province>> listProvince = [];
  List<DropdownMenuItem<District>> listDistrict = [];
  List<DropdownMenuItem<Ward>> listWard = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _addressBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressBloc>(
      create: (_) =>
          locator.get<AddressBloc>()..add(const GetListProvincesEvent()),
      child: BlocConsumer<AddressBloc, AddressState>(
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
              DropdownButtonFormField<Province>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  // overwriting the default padding helps with that puffy look
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                items: listProvince,
                onChanged: (value) {
                  setState(() {
                    listDistrict = [];
                    listWard = [];
                  });
                  _addressBloc.add(
                    GetListDistrictsEvent(provinceId: value?.provinceId ?? ''),
                  );
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<District>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  // overwriting the default padding helps with that puffy look
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                items: listDistrict,
                onChanged: (value) {
                  setState(() {
                    listWard = [];
                  });
                  _addressBloc.add(
                    GetListWardsEvent(districtId: value?.districtId ?? ''),
                  );
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<Ward>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  // overwriting the default padding helps with that puffy look
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                items: listWard,
                onChanged: (value) {},
              ),
            ],
          );
        },
      ),
    );
  }
}
