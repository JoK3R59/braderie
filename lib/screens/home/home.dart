import 'package:flutter/material.dart';

import '../../models/storage_item.dart';
import '../../services/storage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final StorageService storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: FutureBuilder<Storage>(
        future: storageService.fetchStorage('65159249cf4854b312a7cce9'),
        builder: (context, snapshot) {
          print(snapshot);
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
            print('STORAGE : ${storage}');
            final List<StorageItem> storageItems = storage.storedObjects;
            print('STORAGE ITEMS : ${storageItems}');
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
                  child: const Text(
                    'En-tête de la page d\'accueil',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: storageItems.length,
                    itemBuilder: (context, index) {
                      final item = storageItems[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(
                            'Prix: \$${item.price.toStringAsFixed(2)}'),
                        onTap: () {
                          // Gérer le tap sur un élément de stockage ici
                          // Par exemple, naviguer vers une page de détails de stockage
                        },
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
