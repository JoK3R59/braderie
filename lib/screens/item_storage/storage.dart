import 'package:flutter/material.dart';

import '../../models/storage_item.dart';

class StorageItemDetailPage extends StatelessWidget {
  final StorageItem storageItem;
  final bool
      isEditMode; // Paramètre booléen pour activer/désactiver la modification

  const StorageItemDetailPage(
      {super.key, required this.storageItem, this.isEditMode = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode
            ? 'Modifier l\'objet de stockage'
            : 'Détails de l\'objet de stockage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isEditMode ? editOnly(storageItem) : readOnly(storageItem),
      ),
    );
  }
}

Widget readOnly(storageItem) {
  return Column(
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
        height: 200.0,
        width: 200,
        fit: BoxFit.cover,
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
    ],
  );
}

Widget editOnly(storageItem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        initialValue: storageItem.name,
        decoration: const InputDecoration(labelText: 'Nom de l\'objet'),
        onChanged: (newValue) {
          // Mettez à jour le nom de l'objet en temps réel
          // Vous pouvez stocker la valeur dans un StatefulWidget ou utiliser un gestionnaire d'état comme Provider ou Bloc.
        },
      ),
      TextFormField(
        initialValue: storageItem.price.toString(),
        decoration: const InputDecoration(labelText: 'Prix'),
        keyboardType: TextInputType.number,
        onChanged: (newValue) {
          // Mettez à jour le prix en temps réel
        },
      ),
      TextFormField(
        initialValue: storageItem.quantity.toString(),
        decoration: const InputDecoration(labelText: 'Quantité'),
        keyboardType: TextInputType.number,
        onChanged: (newValue) {
          // Mettez à jour la quantité en temps réel
        },
      ),
      TextFormField(
        initialValue: storageItem.description,
        decoration: const InputDecoration(labelText: 'Description'),
        maxLines: 3,
        onChanged: (newValue) {
          // Mettez à jour la description en temps réel
        },
      ),
      TextFormField(
        initialValue: storageItem.condition,
        decoration: const InputDecoration(labelText: 'État'),
        onChanged: (newValue) {
          // Mettez à jour l'état en temps réel
        },
      ),
      // Vous pouvez ajouter d'autres champs de saisie pour d'autres détails ici
      ElevatedButton(
        onPressed: () {
          // Implémentez la logique de sauvegarde des modifications ici
        },
        child: const Text('Enregistrer les modifications'),
      ),
    ],
  );
}
