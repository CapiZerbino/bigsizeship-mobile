import 'package:bigsizeship_mobile/core/resources/colours.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';
import 'package:bigsizeship_mobile/src/address/presentation/bloc/address_bloc.dart';
import 'package:bigsizeship_mobile/src/address/presentation/views/create_address_screen.dart';
import 'package:bigsizeship_mobile/src/address/presentation/widgets/address_item.dart';
import 'package:bigsizeship_mobile/src/authentication/presentation/bloc/authentication_bloc.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int? userId;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    userId = context.read<AuthenticationBloc>().currentUser?.id;
    context.read<AddressBloc>().add(
          GetListAddressesEvent(
            addressType: AddressType.SENDER,
            userId: userId ?? 0,
          ),
        );
    super.initState();
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
      context.read<AddressBloc>().add(
            GetListAddressesEvent(
              addressType: AddressType.SENDER,
              userId: userId ?? 0,
            ),
          );
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
              Icons.replay,
              color: Colours.primaryColour,
            ),
            onPressed: () async {
              _reloadData();
            },
          ),
        ],
      ),
      body: BlocConsumer<AddressBloc, AddressState>(
        listener: (_, state) {
          if (state is GetListAddressesSuccess) {
            listAddress = state.addresses;
          } else if (state is ReloadListAddress) {
            _reloadData();
          }
        },
        builder: (context, state) {
          if (state is GetListAddressesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetListAddressesError) {
            return Center(
              child: Text(state.message),
            );
          }
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
        },
      ),
    );
  }
}
