import 'dart:async';

import 'package:flutter/material.dart';

class OptionsIcons extends StatefulWidget {
  final String item;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const OptionsIcons({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<OptionsIcons> createState() => OptionsIconsState();
}

class OptionsIconsState extends State<OptionsIcons> {
  bool isOptionsVisible = false;
  late final String item;
  late Timer _resetTimer;

  OptionsIconsState() {
    _resetTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        isOptionsVisible = false;
      });
    });
  }

  toggleOptionsVisibility() {
    setState(() {
      isOptionsVisible = !isOptionsVisible;
    });

    if (isOptionsVisible) {
      resetTimer();
    } else {
      _resetTimer.cancel();
    }
  }

  resetTimer() {
    _resetTimer.cancel();
    _resetTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        isOptionsVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      key: const ValueKey('optionsIcons'),
      firstChild: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          toggleOptionsVisibility();
        },
      ),
      secondChild: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              widget.onEdit();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _resetTimer.cancel();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirmation"),
                    content: const Text(
                        "Êtes-vous sûr de vouloir supprimer cet élément ?"),
                    actions: [
                      TextButton(
                        child: const Text("Annuler"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          resetTimer();
                        },
                      ),
                      TextButton(
                        child: const Text("Supprimer"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onDelete();
                        },
                      ),
                    ],
                  );
                },
              );
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
