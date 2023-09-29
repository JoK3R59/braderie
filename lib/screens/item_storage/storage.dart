import 'package:flutter/material.dart';

import '../../models/storage_item.dart';

class StorageItemDetailPage extends StatelessWidget {
  final StorageItem storageItem;

  const StorageItemDetailPage({super.key, required this.storageItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de l\'objet de stockage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storageItem.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Image.network(
              storageItem.photo,
              height: 200.0, // Ajustez la hauteur selon vos besoins
              width: double.infinity, // Utilisez toute la largeur disponible
              fit: BoxFit.cover, // Ajustez l'image pour couvrir la zone
            ),
            const SizedBox(height: 16.0),
            Text(
              'Prix: \$${storageItem.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'Quantité: ${storageItem.quantity}',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'Description: ${storageItem.description}',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'État: ${storageItem.condition}',
              style: const TextStyle(fontSize: 18.0),
            ),
            // Ajoutez d'autres informations sur l'objet de stockage ici
          ],
        ),
      ),
    );
  }
}