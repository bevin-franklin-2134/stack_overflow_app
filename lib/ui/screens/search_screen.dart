import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_overflow_app/bloc/get_search_result_event.dart';
import 'package:stack_overflow_app/bloc/search_bloc.dart';
import 'package:stack_overflow_app/helper/dialog_helper.dart';
import 'package:stack_overflow_app/helper/utils.dart';
import 'package:stack_overflow_app/models/item_model.dart';
import 'package:stack_overflow_app/ui/overlay/filter_overlay.dart';
import 'package:stack_overflow_app/ui/widget/details_widget.dart';
import 'package:stack_overflow_app/ui/widget/dialog_widget.dart';
import 'package:stack_overflow_app/ui/widget/search_widget.dart';

/// This widget represents a screen for searching and displaying search results.
/// It allows users to input search queries, apply filters, and view search results.
class SearchScreen extends StatefulWidget {
  /// Constructs a new instance of [SearchScreen].
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

/// The state of the [SearchScreen] widget.
class _SearchScreenState extends State<SearchScreen> {
  int page = 1; // Current page number for pagination
  TextEditingController controller =
      TextEditingController(); // Controller for the search input field
  ScrollController scrollController =
      ScrollController(); // Controller for the search results scroll view
  bool hasMore =
      false; // Flag indicating if there are more search results available
  String? sort; // The sorting parameter for search results
  String? order; // The ordering parameter for search results
  int? pageSize; // The page size parameter for search results

  @override
  void initState() {
    // Add a listener to the scroll controller to handle infinite scrolling
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        // If the user has scrolled to the bottom, load more search results
        if (hasMore) {
          _showToast(context);
        }
      }
    });

    super.initState();
  }

  /// to Load more Details for search results while pagination
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Text(
          'Load More',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        action: SnackBarAction(
            label: 'Click here',
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              scaffold.hideCurrentSnackBar;
              page += 1;
              _handleSearch(page: page);
            }),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  /// Shows the filter overlay dialog for applying search filters.
  void _showOverlay(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Theme.of(context).cardColor,
      builder: (context) {
        return FilterOverlay(
          sort: sort,
          order: order,
          pageSize: pageSize,
          applyFilter: (sort, order, pageSize) {
            // Apply the selected filter parameters
            this.sort = sort;
            this.pageSize = pageSize;
            this.order = order;
            _handleSearch();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build the search screen UI using BlocConsumer to listen to search state changes
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        // Update the hasMore flag and show an error alert if search fails
        hasMore = state.result?.hasMore ?? false;
        if (state.status == SearchStatus.FAIL) {
          showAlert(alertType: AlertType.ERROR, message: state.errorText);
        }
      },
      builder: (context, state) {
        // Build the search screen UI based on the current search state
        List<Items> items = (state.result?.items ?? []);
        if (state.status == SearchStatus.SUCCESS) {}
        if (state.status == SearchStatus.LOADING) {
          // Show a loading indicator while searching
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: state.result != null || items.isNotEmpty
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  // Search input field and filter button row
                  Row(
                    children: [
                      Expanded(
                        child: SearchWidget(
                          controller: controller,
                          handleSearch: _handleSearch,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Show the filter overlay dialog
                          _showOverlay(context);
                        },
                        icon: const Icon(Icons.filter_list),
                      )
                    ],
                  ), // Search results list or message
                  Visibility(
                    visible: state.result != null && items.isNotEmpty,
                    child: Flexible(
                      child: LayoutBuilder(builder: (context, constraints) {
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            // Build each search result item
                            return DetailsWidget(
                              item: items[index],
                              onChipTap: (tag) {
                                // Handle chip tap to refine search
                                controller.text = tag;
                                _handleSearch();
                              },
                              constraints: constraints,
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
              // Show a message if no search results are found
              if (state.result != null && items.isEmpty)
                Text(
                  'No data found',
                  style: Theme.of(context).textTheme.titleLarge,
                )
            ],
          ),
        );
      },
    );
  }

  /// Handles the search action with optional pagination parameters.
  void _handleSearch({int? page}) {
    this.page = page ?? 1; // Update the current page number
    // Dispatch a search event with the search parameters
    getSearchBloc()?.add(GetSearchResultEvent(
      searchText: controller.text,
      page: this.page,
      pageSize: pageSize,
      order: order,
      sort: sort,
    ));
  }
}
