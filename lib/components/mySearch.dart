import 'package:flutter/material.dart';
import 'package:ghs_app/components/wordSuggestionList.dart';
// import 'package:english_words/english_words.dart' as words;
// reference form: https://ptyagicodecamp.github.io/implementing-search-action-in-appbar.html

//Search delegate
class SearchAppBarDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;

  SearchAppBarDelegate(List<String> words, List<String> history)
      : _words = words,
        _history = history,
        super();

  // Setting leading icon for the search bar.
  //Clicking on back arrow will take control to main page
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        this.close(context, this.query);
      },
    );
  }

  // Builds page to populate search results.
  @override
  Widget buildResults(BuildContext context) {
    this._history.contains(this.query)
        ? {
            this._history.remove(this.query),
            this._history.insert(0, this.query)
          }
        : this._history.insert(0, this.query);
    this.close(context, this.query);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(),
    );
  }

  // Suggestions list while typing search query - this.query.
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> allWords = [];
    allWords.addAll(_words);
    _words.forEach((element) {
      _history.contains(element) ? {} : allWords.add(element);
    });
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : allWords.where((word) => word.startsWith(query));

    return WordSuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        // this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isNotEmpty)
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
    ];
  }
}


//TODO i have changed buildResult method from showResult to close()