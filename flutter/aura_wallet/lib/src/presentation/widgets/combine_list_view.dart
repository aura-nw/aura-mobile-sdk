import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CombinedListView<T> extends StatefulWidget {
  static const double _defaultEndReachedThreshold = 200;

  final List<T> data;
  final Widget Function(T) builder;
  final Future<void> Function(BuildContext) onRefresh;
  final void Function(BuildContext) onLoadMore;
  final double loadMoreThreshHold;
  final bool canLoadMore;
  final Widget Function()? buildEmpty;

  const CombinedListView({
    Key? key,
    required this.onRefresh,
    required this.onLoadMore,
    required this.data,
    required this.builder,
    required this.canLoadMore,
    this.loadMoreThreshHold = _defaultEndReachedThreshold,
    this.buildEmpty,
  }) : super(key: key);

  @override
  State<CombinedListView<T>> createState() => _CombinedListViewState<T>();
}

class _CombinedListViewState<T> extends State<CombinedListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      _scrollController.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final thresholdReached =
        _scrollController.position.extentAfter < widget.loadMoreThreshHold;

    if (thresholdReached && widget.canLoadMore) {
      widget.onLoadMore(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty && widget.buildEmpty != null) {
      return widget.buildEmpty!();
    }

    return CustomScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () => widget.onRefresh(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => widget.builder(widget.data[index]),
              childCount: widget.data.length,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: widget.canLoadMore
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
