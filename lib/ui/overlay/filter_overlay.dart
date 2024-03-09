import 'package:flutter/material.dart';
import 'package:stack_overflow_app/ui/widget/button_widget.dart';

class FilterOverlay extends StatefulWidget {
  /// Callback function to apply filters.
  final void Function(String? sort, String? order, int? pageSize) applyFilter;

  /// The selected sort option.
  final String? sort;

  /// The selected order option.
  final String? order;

  /// The selected page size.
  final int? pageSize;

  /// Constructor for the [FilterOverlay].
  const FilterOverlay({
    Key? key,
    required this.applyFilter,
    this.sort,
    this.pageSize,
    this.order,
  }) : super(key: key);

  @override
  _FilterOverlayState createState() =>
      _FilterOverlayState(pageSize, order, sort);
}

class _FilterOverlayState extends State<FilterOverlay> {
  String? selectedSort;
  String? selectedOrder;
  int? pageSize;

  /// Constructor for the [_FilterOverlayState].
  _FilterOverlayState(int? pageSize, String? order, String? sort) {
    selectedSort = sort ?? 'activity';
    selectedOrder = order ?? 'desc';
    this.pageSize = pageSize ?? 10;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.black54,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'Sort By:',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedSort,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSort = newValue!;
                                  });
                                },
                                items: <String>[
                                  'activity',
                                  'creation',
                                  'votes',
                                  'relevance'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text('Order:',
                          style: Theme.of(context).textTheme.bodyLarge),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedOrder,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedOrder = newValue!;
                                  });
                                },
                                items: <String>[
                                  'asc',
                                  'desc'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Page Size:',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: TextField(
                          controller:
                              TextEditingController(text: pageSize.toString()),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Enter page size',
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 0, 10, 0)),
                          onChanged: (value) {
                            setState(() {
                              pageSize = int.tryParse(value) ?? 10;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWidget(
                        buttonText: 'Apply',
                        onChange: () {
                          widget.applyFilter(
                              selectedSort, selectedOrder, pageSize);
                          Navigator.of(context).pop();
                        },
                      ),
                      ButtonWidget(
                        buttonText: 'Clear',
                        onChange: () {
                          widget.applyFilter(null, null, null);
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
