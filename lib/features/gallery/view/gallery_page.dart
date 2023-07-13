import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../new_diary/view/new_diary_page.dart';
import '../bloc/gallery_bloc.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  static const String name = '/gallery';
  static WidgetBuilder route() => (context) => const GalleryPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'Photo Gallery',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: const _GalleryBody(),
      floatingActionButton: const _AddNewDiaryButton(),
    );
  }
}

class _GalleryBody extends StatelessWidget {
  const _GalleryBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<GalleryBloc, GalleryState>(
              builder: (context, state) {
                return GridView.builder(
                  itemCount: state.imagePaths.length,
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(
                      File(state.imagePaths[index]),
                      fit: BoxFit.cover,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AddNewDiaryButton extends StatelessWidget {
  const _AddNewDiaryButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        final galleryBloc = context.read<GalleryBloc>();
        await Navigator.pushNamed(context, NewDiaryPage.name);
        galleryBloc.add(const PageEntered());
      },
      elevation: 8,
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'New Diary',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
