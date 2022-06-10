import 'package:flutter/material.dart';
import 'package:marvel_universe_path/app/app_defaults.dart';
import 'package:marvel_universe_path/models/character_comics_container.dart';
import 'package:marvel_universe_path/models/character_data_container.dart';
import 'package:marvel_universe_path/views/detail_view/detail_viewmodel.dart';
import 'package:marvel_universe_path/widgets/box_container.dart';
import 'package:marvel_universe_path/widgets/custom_circular_progress_indicator.dart';
import 'package:marvel_universe_path/widgets/transition_switcher.dart';
import 'package:provider/provider.dart';

class DetailView extends StatelessWidget {
  final Character character;
  const DetailView({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailViewModel(character),
      builder: (context, _) {
        return const Scaffold(
          body: _ViewContent(),
        );
      },
    );
  }
}

class _ViewContent extends StatelessWidget {
  const _ViewContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = context.read<DetailViewModel>().character;
    return Stack(
      children: [
        if (data.thumbnail != null)
          Positioned.fill(
            child: Opacity(
              opacity: AppDefaults.kStandartOpacity,
              child: Image.network(
                "${data.thumbnail!.path}/portrait_incredible.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        const Positioned(
          left: AppDefaults.kStandartContentPadding,
          child: SafeArea(child: BackButton()),
        ),
        const Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppDefaults.kStandartPagePadding),
              child: _ContentHolderWidget(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContentHolderWidget extends StatelessWidget {
  const _ContentHolderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: AppDefaults.kStandartDetailViewTopPadding),
          const _HeaderWidget(),
          const _SectionDividerWidget(
            width: double.infinity,
            height: 2.0,
          ),
          const SizedBox(height: AppDefaults.kStandartContentPaddingLow),
          const _DescriptionWidget(),
          const SizedBox(height: AppDefaults.kStandartContentPaddingHigh),
          const _ComicsTitleWidget(),
          const _SectionDividerWidget(
            width: double.infinity,
            height: 2.0,
          ),
          const SizedBox(height: AppDefaults.kStandartContentPaddingLow),
          Expanded(
            child: BoxContainer(
              width: double.infinity,
              color: Theme.of(context).selectedRowColor,
              showShadow: false,
              child: const _ListHolderWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = context.read<DetailViewModel>().character;
    return Text(
      data.name,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 50),
      textAlign: TextAlign.center,
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = context.read<DetailViewModel>().character;
    return Text(
      data.description != null && data.description!.isNotEmpty
          ? data.description!
          : "No description available",
      style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}

class _ComicsTitleWidget extends StatelessWidget {
  const _ComicsTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Comics",
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class _SectionDividerWidget extends StatelessWidget {
  final double width;
  final double height;
  const _SectionDividerWidget({Key? key, this.height = 30, this.width = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDefaults.kStandartBorderRadius),
        color: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }
}

class _ListHolderWidget extends StatefulWidget {
  const _ListHolderWidget({Key? key}) : super(key: key);

  @override
  _ListHolderWidgetState createState() => _ListHolderWidgetState();
}

class _ListHolderWidgetState extends State<_ListHolderWidget> {
  @override
  void initState() {
    super.initState();
    context.read<DetailViewModel>().getData();
  }

  @override
  void dispose() {
    context.read<DetailViewModel>().disposeModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<DetailViewModel, bool>(
      selector: (_, model) => model.viewDidLoad,
      builder: (context, value, _) {
        return CustomTransitionSwitcher(
          child: !value
              ? const CustomCircularProgressIndicator()
              : const _ListViewWidget(),
        );
      },
    );
  }
}

class _ListViewWidget extends StatelessWidget {
  const _ListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DetailViewModel, List<ComicData>>(
      selector: (_, model) => model.items,
      builder: (context, value, _) {
        if (value.isEmpty) {
          return Text(
            "No comics available for this character",
            style: Theme.of(context).textTheme.bodyText1,
          );
        }
        return ListView.separated(
          itemCount: value.length,
          separatorBuilder: (_, __) => const _SectionDividerWidget(
            width: double.infinity,
            height: 2.0,
          ),
          itemBuilder: (context, index) {
            final item = value[index];
            return Padding(
              padding:
                  const EdgeInsets.all(AppDefaults.kStandartContentPaddingLow),
              child: ListTile(
                title: Text(item.title),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "${item.thumbnail.path}/portrait_small.jpg",
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
