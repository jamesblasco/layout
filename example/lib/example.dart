import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

import 'grid_delegate.dart';

const kAlwaysDisplayDrawer = BreakpointValue(xs: false, md: true);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  void _incrementCounter() {
    setState(() {
      index++;
    });
  }

  void onIndexSelect(newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final alwaysDisplayDrawer = context.layout.breakpoint > LayoutBreakpoint.sm;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
      ),
      endDrawer:
          alwaysDisplayDrawer ? null : DrawerSheet(key: ValueKey('Drawer')),
      body: Row(
        children: [
          if (context.layout.breakpoint > LayoutBreakpoint.sm) ...[
            NavigationSideBar(
                selectedIndex: index, onIndexSelect: onIndexSelect),
            VerticalDivider(thickness: 1, width: 1),
          ],
          Expanded(key: ValueKey('HomePageBody'), child: HomeBody()),
          if (alwaysDisplayDrawer)
            DrawerSheet(
              key: ValueKey('Drawer'),
            ),
        ],
      ),
      bottomNavigationBar: context.layout.breakpoint < LayoutBreakpoint.md
          ? NavigationBottomBar(
              selectedIndex: index,
              onIndexSelect: onIndexSelect,
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: index < 2 ? _incrementCounter : null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class NavigationSideBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onIndexSelect;

  const NavigationSideBar({
    Key? key,
    required this.selectedIndex,
    required this.onIndexSelect,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onIndexSelect,
      labelType: NavigationRailLabelType.selected,
      destinations: [
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text('First'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.bookmark_border),
          selectedIcon: Icon(Icons.book),
          label: Text('Second'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.star_border),
          selectedIcon: Icon(Icons.star),
          label: Text('Third'),
        ),
      ],
    );
  }
}

class DrawerSheet extends StatefulWidget {
  const DrawerSheet({Key? key}) : super(key: key);
  @override
  _DrawerSheetState createState() => _DrawerSheetState();
}

class _DrawerSheetState extends State<DrawerSheet> {
  Map<String, bool?> checkboxes = {};

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Text('Filters'),
          ),
          CheckboxListTile(
            title: Text('Brand1'),
            value: checkboxes['New'] ?? false,
            onChanged: (value) => setState(() => checkboxes['New'] = value),
          ),
        ],
      ),
    );
  }
}

class NavigationBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onIndexSelect;

  const NavigationBottomBar({
    Key? key,
    required this.selectedIndex,
    required this.onIndexSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onIndexSelect,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'First',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          activeIcon: Icon(Icons.book),
          label: 'Second',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          activeIcon: Icon(Icons.star),
          label: 'Third',
        ),
      ],
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double spacing = BreakpointValue(xs: 0.0, sm: 10.0).resolve(context);

    return Scrollbar(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: CustomScrollView(
          slivers: [
            SliverGutter(),
            SliverToBoxAdapter(
              child: Margin(
                child: Text('Section Title'),
              ),
            ),
            SliverGutter(),
            SliverMargin(
              margin: context.layout.breakpoint == LayoutBreakpoint.xs
                  ? EdgeInsets.zero
                  : null,
              sliver: SliverGrid(
                delegate: SliverChildListDelegate.fixed(
                  List.generate(
                    100,
                    (index) => CardItem(index: index),
                  ),
                ),
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCountAndMainAxisExtent(
                  crossAxisCount: context.layout.value(
                    xs: 1,
                    sm: 2,
                    md: 2,
                    lg: 3,
                    xl: 4,
                  ),
                  mainAxisExtent: 60,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                ),
              ),
            ),
            SliverGutter(),
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final int index;

  const CardItem({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final responsiveCardDecoration = BreakpointValue(
      xs: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      sm: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
    return Container(
      decoration: responsiveCardDecoration.resolve(context),
      alignment: Alignment.center,
      child: Text('Item $index'),
    );
  }
}
