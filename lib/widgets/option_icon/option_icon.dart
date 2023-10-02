import 'dart:async';

import 'package:flutter/material.dart';

import '../../services/storage.dart';

class OptionsIcons extends StatefulWidget {
  final String item;
  final StorageService storageService;

  const OptionsIcons({
    Key? key,
    required this.item,
    required this.storageService,
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

    // Réinitialiser le minuteur et programmer la réinitialisation
    if (isOptionsVisible) {
      _resetTimer.cancel();
      _resetTimer = Timer(const Duration(seconds: 3), () {
        setState(() {
          isOptionsVisible = false;
        });
      });
    } else {
      _resetTimer.cancel();
    }
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
              toggleOptionsVisibility();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              print("delete item : ${widget.item}");
              widget.storageService.deleteStorageItem(widget.item);
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