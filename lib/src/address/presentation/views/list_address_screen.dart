import 'package:bigsizeship_mobile/core/resources/colours.dart';
import 'package:bigsizeship_mobile/core/services/injection_container.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';
import 'package:bigsizeship_mobile/src/address/presentation/bloc/address_bloc.dart';
import 'package:bigsizeship_mobile/src/address/presentation/views/create_address_screen.dart';
import 'package:bigsizeship_mobile/src/order/presentation/widgets/description_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListAddressesScreen extends StatefulWidget {
  const ListAddressesScreen({super.key});

  static const routeName = '/listAddresses';

  @override
  State<ListAddressesScreen> createState() => _ListAddressesScreenState();
}

class _ListAddressesScreenState extends State<ListAddressesScreen> {
  List<Address> listAddress = [];
  final _addressBloc = locator.get<AddressBloc>();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == 0) {
      _reloadData();
    }
  }

  void _reloadData() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
        listAddress.clear();
      });
      _addressBloc.add(const GetListAddressesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách kho hàng'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colours.primaryColour,
            ),
            onPressed: () {
              Navigator.pushNamed(context, CreateAddressScreen.routeName);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.local_dining,
              color: Colours.primaryColour,
            ),
            onPressed: () async {
              _reloadData();
            },
          ),
        ],
      ),
      body: BlocProvider<AddressBloc>(
        create: (_) => _addressBloc..add(const GetListAddressesEvent()),
        child: BlocConsumer<AddressBloc, AddressState>(
          listener: (_, state) {
            if (state is GetListAddressesSuccess) {
              listAddress = state.addresses;
            }
          },
          builder: (context, state) {
            if (state is GetListAddressesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetListAddressesSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  _reloadData();
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: listAddress.length,
                  itemBuilder: (context, index) {
                    _isLoading = false;
                    return AddressItem(
                      address: listAddress[index],
                      index: index,
                    );
                  },
                ),
              );
            } else if (state is GetListAddressesError) {
              return Center(
                child: Text(state.message),
              );
            }
            return const Center(
              child: Text('Có lỗi xảy ra'),
            );
          },
        ),
      ),
    );
  }
}

class AddressItem extends StatelessWidget {
  const AddressItem({
    super.key,
    required this.address,
    required this.index,
  });

  final Address address;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          'Kho hàng ${index + 1}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          children: [
            DescriptionItem(
              showIcon: false,
              icon: Icons.abc,
              label: 'Số điện thoại',
              value: address.phoneNumber,
            ),
            DescriptionItem(
              showIcon: false,
              icon: Icons.abc,
              label: 'Địa chỉ',
              value:
                  '${address.address}, ${address.ward}, ${address.address}, ${address.province}',
            ),
          ],
        ),
      ),
    );
  }
}
