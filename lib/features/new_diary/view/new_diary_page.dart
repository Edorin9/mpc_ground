import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mpc_ground_repository/mpc_ground_repository.dart';

import '../bloc/new_diary_bloc.dart';
import '../enums/message_status.dart';

class NewDiaryPage extends StatelessWidget {
  const NewDiaryPage({super.key});

  static const String name = '/new-diary';
  static WidgetBuilder route() => (context) => const NewDiaryPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewDiaryBloc(
        mpcGroundRepository: context.read<MpcGroundRepository>(),
        imagePicker: context.read<ImagePicker>(),
      ),
      child: const _NewDiaryView(),
    );
  }
}

class _NewDiaryView extends HookWidget {
  const _NewDiaryView();

  @override
  Widget build(BuildContext context) {
    final commentsController = useTextEditingController(text: '');
    final dateController = useTextEditingController(text: '');
    final areaController = useTextEditingController(text: '');
    final categoryController = useTextEditingController(text: '');
    final tagsController = useTextEditingController(text: '');
    final eventController = useTextEditingController(text: '');
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'New Diary',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
        body: _DiaryBody(
          commentsController: commentsController,
          dateController: dateController,
          areaController: areaController,
          categoryController: categoryController,
          tagsController: tagsController,
          eventController: eventController,
        ),
      ),
    );
  }
}

class _DiaryBody extends StatelessWidget {
  const _DiaryBody({
    required this.commentsController,
    required this.dateController,
    required this.areaController,
    required this.categoryController,
    required this.tagsController,
    required this.eventController,
  });

  final TextEditingController commentsController;
  final TextEditingController dateController;
  final TextEditingController areaController;
  final TextEditingController categoryController;
  final TextEditingController tagsController;
  final TextEditingController eventController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocListener<NewDiaryBloc, NewDiaryState>(
          listener: (context, state) {
            if (state.messageStatus != MessageStatus.none) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message ?? ''),
                  backgroundColor: state.messageStatus?.color,
                ),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Header(),
              _ScrollingContent(
                commentsController: commentsController,
                dateController: dateController,
                areaController: areaController,
                categoryController: categoryController,
                tagsController: tagsController,
                eventController: eventController,
              )
            ],
          ),
        ),
        const _Loader(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Row(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
            child: Icon(
              Icons.location_pin,
              color: Colors.grey,
            ),
          ),
          Text(
            '20041075 | TAP-North Strathfield',
            style: TextStyle(),
          )
        ],
      ),
    );
  }
}

class _ScrollingContent extends StatelessWidget {
  const _ScrollingContent({
    required this.commentsController,
    required this.dateController,
    required this.areaController,
    required this.categoryController,
    required this.tagsController,
    required this.eventController,
  });

  final TextEditingController commentsController;
  final TextEditingController dateController;
  final TextEditingController areaController;
  final TextEditingController categoryController;
  final TextEditingController tagsController;
  final TextEditingController eventController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey.shade50,
        child: ListView(
          children: [
            const _Title(),
            const _AddPhotosSection(),
            _CommentsSection(commentsController: commentsController),
            _DetailsSection(
              dateController: dateController,
              areaController: areaController,
              categoryController: categoryController,
              tagsController: tagsController,
            ),
            _EventSection(eventController: eventController),
            _NextButton(
              commentsController: commentsController,
              dateController: dateController,
              areaController: areaController,
              categoryController: categoryController,
              tagsController: tagsController,
              eventController: eventController,
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Text(
        'Add to site diary',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}

class _AddPhotosSection extends StatelessWidget {
  const _AddPhotosSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Photos to site diary',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Divider(height: 24),
            BlocBuilder<NewDiaryBloc, NewDiaryState>(
              builder: (context, state) {
                return GridView.builder(
                  itemCount: state.photos?.length ?? 0,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(
                      File(
                        state.photos?.elementAt(index) ?? '',
                      ),
                      fit: BoxFit.cover,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    context.read<NewDiaryBloc>().add(const AddPhotosClicked()),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Add a photo',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Include in photo gallery',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                BlocBuilder<NewDiaryBloc, NewDiaryState>(
                  builder: (context, state) {
                    return Checkbox(
                      value: state.isSaveChecked,
                      onChanged: (b) {
                        context.read<NewDiaryBloc>().add(
                              SavePhotosToggled(
                                isChecked: b == true,
                              ),
                            );
                      },
                      visualDensity: VisualDensity.compact,
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _CommentsSection extends StatelessWidget {
  const _CommentsSection({
    required this.commentsController,
  });

  final TextEditingController commentsController;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comments',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Divider(height: 24),
            TextField(
              controller: commentsController,
              decoration: InputDecoration(
                hintText: 'Comments',
                hintStyle: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({
    required this.dateController,
    required this.areaController,
    required this.categoryController,
    required this.tagsController,
  });

  final TextEditingController dateController;
  final TextEditingController areaController;
  final TextEditingController categoryController;
  final TextEditingController tagsController;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Divider(height: 24),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                hintText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                hintStyle: Theme.of(context).textTheme.caption,
              ),
              enabled: false,
            ),
            TextField(
              controller: areaController,
              decoration: InputDecoration(
                hintText: 'Area',
                hintStyle: Theme.of(context).textTheme.caption,
              ),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                hintText: 'Category',
                hintStyle: Theme.of(context).textTheme.caption,
              ),
            ),
            TextField(
              controller: tagsController,
              decoration: InputDecoration(
                hintText: 'Tags',
                hintStyle: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventSection extends StatelessWidget {
  const _EventSection({required this.eventController});

  final TextEditingController eventController;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Link to existing event?',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                BlocBuilder<NewDiaryBloc, NewDiaryState>(
                  builder: (context, state) {
                    return Checkbox(
                      value: state.isLinkEventChecked,
                      onChanged: (b) {
                        context.read<NewDiaryBloc>().add(
                              LinkEventToggled(
                                isChecked: b == true,
                              ),
                            );
                      },
                      visualDensity: VisualDensity.compact,
                    );
                  },
                )
              ],
            ),
            const Divider(height: 24),
            TextField(
              controller: eventController,
              decoration: InputDecoration(
                hintText: 'Event',
                hintStyle: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    required this.commentsController,
    required this.dateController,
    required this.areaController,
    required this.categoryController,
    required this.tagsController,
    required this.eventController,
  });

  final TextEditingController commentsController;
  final TextEditingController dateController;
  final TextEditingController areaController;
  final TextEditingController categoryController;
  final TextEditingController tagsController;
  final TextEditingController eventController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          context.read<NewDiaryBloc>().add(
                NextClicked(
                  comments: commentsController.text,
                  date: dateController.text,
                  area: areaController.text,
                  category: categoryController.text,
                  tags: tagsController.text,
                  event: eventController.text,
                ),
              );
        },
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Next',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewDiaryBloc, NewDiaryState>(
      builder: (context, state) {
        return state.isLoading
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black45,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.lightGreen,
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
