import 'package:flutter/material.dart';

import '../../models/storage_item.dart';
import '../../services/storage.dart';
import '../../widgets/option_icon/option_icon.dart';
import '../item_storage/storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StorageService storageService = StorageService();
  bool isOptionsVisible = false;

  toggleOptionsVisibility() {
    print("toggleOptionsVisibility");
    setState(() {
      isOptionsVisible = !isOptionsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build HOMEPAGE");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: FutureBuilder<Storage>(
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
                        'Quantité de votre inventaire: ${storage.storageCapacity.toStringAsFixed(2)}',
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
                            subtitle: Text(
                                'Prix: \$${item.price.toStringAsFixed(2)}'),
                            trailing: OptionsIcons(
                              isOptionsVisible: isOptionsVisible,
                              toggleOptionsVisibility: toggleOptionsVisibility,
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
      ),
    );
  }
}
