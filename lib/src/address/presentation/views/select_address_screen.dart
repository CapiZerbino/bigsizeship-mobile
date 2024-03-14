import 'package:bigsizeship_mobile/core/services/injection_container.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/district.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/province.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/ward.dart';
import 'package:bigsizeship_mobile/src/address/presentation/bloc/address_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  static const routeName = '/selectAddress';

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen>
    with TickerProviderStateMixin {
  static const List<Tab> listTabs = <Tab>[
    Tab(text: 'Tỉnh/Thành phố'),
    Tab(text: 'Quận/Huyện'),
    Tab(text: 'Phường/Xã'),
  ];

// init selected province, district, ward
  Province? selectedProvince;
  District? selectedDistrict;
  Ward? selectedWard;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: listTabs.length,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void handleSelectProvince(Province province) {
    print(province);
    setState(() {
      selectedProvince = province;
      _tabController.animateTo(1);
    });
  }

  void handleSelectDistrict(District district) {
    print(district);
    setState(() {
      selectedDistrict = district;
      _tabController.animateTo(2);
    });
  }

  void handleSelectWard(Ward ward) {
    print(ward);
    setState(() {
      selectedWard = ward;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn địa chỉ'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Material(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                tabs: listTabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ProvinceTabContent(
                    onSelect: handleSelectProvince,
                  ),
                  DistrictTabContent(
                    onSelect: handleSelectDistrict,
                    provinceId: selectedProvince?.provinceId,
                  ),
                  WardTabContent(
                    onSelect: handleSelectDistrict,
                    districtId: selectedDistrict?.districtId,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProvinceTabContent extends StatefulWidget {
  const ProvinceTabContent({required this.onSelect, super.key});
  final Function onSelect;

  @override
  State<ProvinceTabContent> createState() => _ProvinceTabContentState();
}

class _ProvinceTabContentState extends State<ProvinceTabContent> {
  final _addressBloc = locator.get<AddressBloc>();
  List<Province> listProvinces = [];

  @override
  void initState() {
    super.initState();
    _addressBloc.add(const GetListProvincesEvent());
  }

  @override
  void dispose() {
    _addressBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _addressBloc,
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (_, state) {
          if (state is GetListProvincesSuccess) {
            listProvinces = state.provinces;
          }
        },
        builder: (context, state) {
          if (state is GetListAddressesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetListProvincesSuccess) {
            return ListView.builder(
              itemCount: listProvinces.length,
              itemBuilder: (context, index) {
                final province = listProvinces[index];
                return ListTile(
                  title: Text(province.name),
                  onTap: () {
                    widget.onSelect(province);
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('Error fetching data'),
            );
          }
        },
      ),
    );
  }
}

class DistrictTabContent extends StatefulWidget {
  DistrictTabContent({
    required this.onSelect,
    this.provinceId,
    super.key,
  });
  final Function onSelect;
  String? provinceId;

  @override
  State<DistrictTabContent> createState() => _DistrictTabContentState();
}

class _DistrictTabContentState extends State<DistrictTabContent> {
  final _addressBloc = locator.get<AddressBloc>();
  List<District> listDistricts = [];

  @override
  void initState() {
    super.initState();
    if (widget.provinceId != null) {
      _addressBloc
          .add(GetListDistrictsEvent(provinceId: widget.provinceId ?? ''));
    }
  }

  @override
  void dispose() {
    _addressBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _addressBloc,
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (_, state) {
          if (state is GetListDistrictsSuccess) {
            listDistricts = state.districts;
          }
        },
        builder: (context, state) {
          if (state is GetListAddressesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetListDistrictsSuccess) {
            return ListView.builder(
              itemCount: listDistricts.length,
              itemBuilder: (context, index) {
                final district = listDistricts[index];
                return ListTile(
                  title: Text(district.name),
                  onTap: () {
                    widget.onSelect(district);
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('Error fetching data'),
            );
          }
        },
      ),
    );
  }
}

class WardTabContent extends StatefulWidget {
  WardTabContent({
    required this.onSelect,
    this.districtId,
    super.key,
  });
  final Function onSelect;
  String? districtId;

  @override
  State<WardTabContent> createState() => _WardTabContentState();
}

class _WardTabContentState extends State<WardTabContent> {
  final _addressBloc = locator.get<AddressBloc>();
  List<Ward> listWards = [];

  @override
  void initState() {
    super.initState();
    if (widget.districtId != null) {
      _addressBloc.add(GetListWardsEvent(districtId: widget.districtId ?? ''));
    }
  }

  @override
  void dispose() {
    _addressBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _addressBloc,
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (_, state) {
          if (state is GetListWardsSuccess) {
            listWards = state.wards;
          }
        },
        builder: (context, state) {
          if (state is GetListAddressesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetListWardsSuccess) {
            return ListView.builder(
              itemCount: listWards.length,
              itemBuilder: (context, index) {
                final ward = listWards[index];
                return ListTile(
                  title: Text(ward.name),
                  onTap: () {
                    widget.onSelect(ward);
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('Error fetching data'),
            );
          }
        },
      ),
    );
  }
}
