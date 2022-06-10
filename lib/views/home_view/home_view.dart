import 'package:flutter/material.dart';
import 'package:marvel_universe_path/models/character_data_container.dart';
import 'package:marvel_universe_path/views/home_view/home_viewmodel.dart';
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

class _PageLoadingWidget extends StatefulWidget {
  const _PageLoadingWidget({Key? key}) : super(key: key);

  @override
  __PageLoadingWidgetState createState() => __PageLoadingWidgetState();
}

class __PageLoadingWidgetState extends State<_PageLoadingWidget> {
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
              : const _ViewContent(),
        );
      },
    );
  }
}

class _ViewContent extends StatelessWidget {
  const _ViewContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, List<Character>>(
      selector: (_, model) => model.items,
      builder: (context, value, _) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final item = value[index];
            return ListTile(
              title: Text(item.name),
              leading: item.thumbnail != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(item.thumbnail!.path))
                  : null,
            );
          },
        );
      },
    );
  }
}
