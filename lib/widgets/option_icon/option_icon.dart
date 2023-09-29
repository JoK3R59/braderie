import 'package:flutter/material.dart';

class OptionsIcons extends StatefulWidget {
  const OptionsIcons({Key? key}) : super(key: key);

  @override
  OptionsIconsState createState() => OptionsIconsState();
}
class OptionsIconsState extends State<OptionsIcons> {
  bool isOptionsVisible = false;

  toggleOptionsVisibility() {
    print("toggleOptionsVisibility");
    setState(() {
      isOptionsVisible = !isOptionsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build OPTIONSICONS");
    return AnimatedCrossFade(
      key: const ValueKey('optionsIcons'),
      firstChild: IconButton(
        icon: const Icon(Icons.more_vert),
        // Icône d'options
        onPressed: () {
          // Afficher les icônes de suppression et de modification
          // Vous pouvez gérer la visibilité ici en fonction de l'état
          // Par exemple, en utilisant un gestionnaire d'état global ou local.
          toggleOptionsVisibility();
        },
      ),
      secondChild: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            // Icône de modification
            onPressed: () {
              // Action à effectuer lors de la modification de l'élément
              // Par exemple, ouvrir une page de modification
              toggleOptionsVisibility();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            // Icône de suppression
            onPressed: () {
              // Action à effectuer lors de la suppression de l'élément
              // Par exemple, afficher une boîte de dialogue de confirmation
            },
          ),
        ],
      ),
      crossFadeState: isOptionsVisible
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }
}