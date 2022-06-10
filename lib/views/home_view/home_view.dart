import 'package:flutter/material.dart';
import 'package:marvel_universe_path/app/app_defaults.dart';
import 'package:marvel_universe_path/models/character_data_container.dart';
import 'package:marvel_universe_path/views/home_view/home_viewmodel.dart';
import 'package:marvel_universe_path/widgets/box_container.dart';
import 'package:marvel_universe_path/widgets/custom_circular_progress_indicator.dart';
import 'package:marvel_universe_path/widgets/transition_switcher.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.kStandartPagePadding),
        child: Column(
          children: const [
            _MarverLogoWidget(),
            SizedBox(height: AppDefaults.kStandartPagePadding),
            Expanded(child: _ListHolderWidget())
          ],
        ),
      ),
    );
  }
}

class _MarverLogoWidget extends StatelessWidget {
  const _MarverLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDefaults.kStandartBorderRadius),
        image: const DecorationImage(
          image: AssetImage('assets/images/marvel_logo.png'),
        ),
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
    context.read<HomeViewModel>().getData();
  }

  @override
  void dispose() {
    context.read<HomeViewModel>().disposeModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, bool>(
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
    return Selector<HomeViewModel, List<Character>>(
      selector: (_, model) => model.items,
      builder: (context, value, _) {
        return ListView.builder(
          controller: context.read<HomeViewModel>().controller,
          itemCount: value.length,
          itemBuilder: (context, index) {
            final item = value[index];
            return Padding(
              padding:
                  const EdgeInsets.all(AppDefaults.kStandartContentPaddingLow),
              child: BoxContainer(
                color: Theme.of(context).selectedRowColor,
                showShadow: false,
                child: ListTile(
                  title: Text(item.name),
                  leading: item.thumbnail != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            "${item.thumbnail!.path}/portrait_small.jpg",
                          ),
                        )
                      : null,
                  onTap: () => context
                      .read<HomeViewModel>()
                      .navigateToDetailView(context, item),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).iconTheme.color,
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
