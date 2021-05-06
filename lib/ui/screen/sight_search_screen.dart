import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/redux/my_store.dart';
import 'package:places/data/redux/search/search_action.dart';
import 'package:places/data/redux/search/search_state.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/image_loader.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/error_view.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
import 'package:places/ui/screen/widget/search_bar.dart';
import 'package:places/ui/svg_icon.dart';
import 'package:provider/provider.dart';

class SightSearchScreen extends StatefulWidget {
  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Список интересных мест',
        bottom: SearchBar(
          controller: controller,
          focusNode: focusNode,
          onSearch: (searchString) => StoreProvider.of<MyState>(context)
              .dispatch(SearchStringAction(searchString)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StoreConnector<MyState, SearchState>(
          converter: (store) => store.state,
          builder: (_, state) => state is SearchNoSearchState
              ? _History((string) {
                  controller.text = string;
                  focusNode.requestFocus();
                })
              : state is SearchLoadingState
                  ? _Searching()
                  : state is SearchErrorState
                      ? Center(child: ErrorView())
                      : state is SearchNotFoundState
                          ? _NotFound()
                          : state is SearchResultState
                              ? _Found(state.places)
                              : throw UnsupportedError('Wrong state: $state'),
        ),
      ),
      bottomNavigationBar: BottomNavigationView.list(),
    );
  }
}

class _Found extends StatelessWidget {
  const _Found(this.found);

  final Iterable<Place> found;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        for (final sight in found) _Sight(sight),
      ]),
    );
  }
}

class _Sight extends StatefulWidget {
  const _Sight(
    this.sight, {
    Key? key,
  }) : super(key: key);

  final Place sight;

  @override
  _SightState createState() => _SightState();
}

class _SightState extends State<_Sight> {
  late final ImageLoader loader;

  @override
  void initState() {
    super.initState();
    loader = ImageLoader(widget.sight.url, onProgress: () => setState(() {}));
  }

  @override
  void dispose() {
    loader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SightDetailsScreen(widget.sight),
        ),
      ),
      child: SizedBox(
        height: 78,
        child: Row(
          children: [
            Ink(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: loader.provider,
                  fit: BoxFit.cover,
                ),
              ),
              child: (loader.loaded)
                  ? null
                  : Center(
                      child: CircularProgressIndicator(value: loader.progress),
                    ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sight.name,
                    style: theme.text.text.withColor(theme.color.title),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.sight.category.name,
                    style: theme.text.small.withColor(theme.color.secondary2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 48,
            width: 48,
            child: SvgIcon(
              MyIcons.Search,
              color: theme.color.inactiveBlack,
            ),
          ),
          Text(
            'Ничего не найдено.',
            style: theme.text.subTitle.withColor(theme.color.inactiveBlack),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 260,
            child: Text(
              'Попробуйте изменить параметры поиска',
              style: theme.text.small,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _Searching extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: CircularProgressIndicator(),
    );
  }
}

class _History extends StatefulWidget {
  final void Function(String) onSelected;

  _History(this.onSelected);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<_History> {
  @override
  Widget build(BuildContext context) {
    final history = Provider.of<PlaceInteractor>(context).searchHistory;

    if (history.strings.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 6),
          child: Text('ВЫ ИСКАЛИ', style: theme.text.superSmallInactive),
        ),
        SingleChildScrollView(
            child: Column(children: [
          for (final s in history.strings)
            InkWell(
              onTap: () => widget.onSelected(s),
              child: Row(children: [
                Expanded(
                  child: Text(
                    s,
                    style: theme.text.text.withColor(theme.color.secondary2),
                  ),
                ),
                IconButton(
                  icon: SvgIcon(
                    MyIcons.Delete,
                    color: theme.color.secondary2,
                  ),
                  onPressed: () => setState(() => history.remove(s)),
                ),
              ]),
            ),
        ])),
        TextButton(
          child: Text('Очистить историю'),
          style: theme.textButtonGreen,
          onPressed: () => setState(() => history.clear()),
        ),
      ],
    );
  }
}
