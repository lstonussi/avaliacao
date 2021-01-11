import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate<String> {
  final List<String> _words;
  MySearchDelegate(List<String> words)
      : _words = words,
        super();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Voltar',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
        this.close(context, null);
      },
    );
  }

  // Widget of result page.
  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  // Suggestions lista enquanto digita (this.query).
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = _words
        .where((word) => word.toUpperCase().startsWith(query.toUpperCase()));

    return _SuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        showResults(context);
        this.close(context, this.query);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Limpar',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }
}

// Suggestions list widget displayed in the search page.
class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final bool getByName = false;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    //final controller = Get.find<RepoRepository>();
    final textTheme = Theme.of(context).textTheme.subtitle1;
    return ((query.isNotEmpty) && (suggestions.length == 0))
        ? Container(
            child: GestureDetector(
              child: Center(child: Text('$query não encontrado.')),
            ),
          )
        : ListView.builder(
            itemCount: query.isEmpty ? 0 : suggestions.length,
            itemBuilder: (BuildContext context, int i) {
              final String suggestion = suggestions[i];
              return ListTile(
                leading: Icon(Icons.radio_button_unchecked),
                title: RichText(
                  text: TextSpan(
                    text: query,
                    style: textTheme.copyWith(fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: suggestion.substring(query.length),
                        style: textTheme,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  onSelected(suggestion);
                },
              );
            },
          );
  }
}

class CustomLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'pt-BR';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      SynchronousFuture<MaterialLocalizations>(const CustomLocalization());

  @override
  bool shouldReload(CustomLocalizationDelegate old) => false;

  @override
  String toString() => 'CustomLocalization.delegate(pt_br)';
}

class CustomLocalization extends DefaultMaterialLocalizations {
  const CustomLocalization();

  @override
  String get searchFieldLabel => "My hint text";
}
