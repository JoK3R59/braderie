import 'package:flutter/material.dart';

import '../../models/storage_item.dart';
import '../../screens/item_storage/storage.dart';
import '../../services/storage.dart';
import '../option_icon/option_icon.dart';

class ListItemStorage extends StatefulWidget {
  const ListItemStorage({Key? key}) : super(key: key);

  @override
  ListItemStorageState createState() => ListItemStorageState();
}

class ListItemStorageState extends State<ListItemStorage> {
  final StorageService storageService = StorageService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Storage>(
      future: storageService.fetchStorage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Affichez un indicateur de chargement en attendant les données
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Gérez les erreurs ici (par exemple, affichez un message d'erreur)
          return Center(
            child: Text('Erreur : ${snapshot.error}'),
          );
        } else if (!snapshot.hasData) {
          // Gérez le cas où aucune donnée n'est disponible
          return const Center(
            child: Text('Aucune donnée disponible.'),
          );
        } else {
          // Affichez les données récupérées ici
          final Storage storage = snapshot.data!;
          final List<StorageItem> storageItems = storage.storedObjects;
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Bienvenue, ${storage.userName}',
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Quantité de votre inventaire: ${storage.storedObjects.length.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: storageItems.length,
                  itemBuilder: (context, index) {
                    final item = storageItems[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(item.name),
                          subtitle:
                              Text('Prix: \$${item.price.toStringAsFixed(2)}'),
                          trailing: OptionsIcons(
                            item: item.id,
                            onDelete: () {
                              storageService.deleteStorageItem(item.id).then((_) {
                                setState(() {
                                  storageItems.removeAt(index);
                                });
                              });
                            },
                            onEdit: () {
                              print('Edit item');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StorageItemDetailPage(storageItem: item,isEditMode: true),
                                ),
                              );
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StorageItemDetailPage(storageItem: item),
                              ),
                            );
                          },
                        ),
                        const Divider(
                          height: 6.0,
                          color: Colors.blueGrey,
                          indent: 32.0,
                          endIndent: 32.0,
                          thickness: 0.5,
                        ), // Ajoute une ligne de séparation
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
