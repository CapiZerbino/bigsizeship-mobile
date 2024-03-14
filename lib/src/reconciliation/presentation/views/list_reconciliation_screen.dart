import 'package:flutter/material.dart';

class ListReconciliationScreen extends StatefulWidget {
  const ListReconciliationScreen({super.key});

  static const routeName = '/listReconciliation';

  @override
  State<ListReconciliationScreen> createState() =>
      _ListReconciliationScreenState();
}

class _ListReconciliationScreenState extends State<ListReconciliationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách đối soát'),
      ),
      body: const Center(
        child: Text('Danh sách đối soát'),
      ),
    );
  }
}
