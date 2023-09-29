import 'package:flutter/material.dart';

import '../../widgets/storage/list_item_storage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: ListItemStorage(),
    );
  }
}
