# Animated Expandable Fab

A Flutter package for easily creating animated expandable fabs.

<img src="https://raw.githubusercontent.com/tajaouart/animated_expandable_fab/main/animated_expandable_fab.gif" height="600"/>


## Description

Animated Expandable Fab is a package for creating beautiful and customizable expandable floating action buttons. This package provides an easy-to-use widget, `ExpandableFab`, which can be used to create expandable fabs with various animations, icons, and children.

## Features

- Customizable distance, direction, and animation of expansion
- Customizable open and close icons
- Support for multiple children
- Support for closing the fab on child button press

## Getting started

To use this package, add `animated_expandable_fab` as a dependency in your `pubspec.yaml` file.

```dart
dependencies:
animated_expandable_fab: ^1.0.0
```

## Usage

To use the `ExpandableFab` widget, simply add it to your widget tree as a child of a `Scaffold` widget. You can customize the distance, direction, and animation of the expansion by passing in the appropriate parameters. You can also add children to the fab by passing in a list of widgets.


```dart
Scaffold(
    floatingActionButton: ExpandableFab(
    distance: 100,
    openIcon: Icon(Icons.add),
    closeIcon: Icon(Icons.close),
    children: [
        ActionButton(
        child: Text("Child 1"),
        onPressed: () {},
        ),
        ActionButton(
        child: Text("Child 2"),
        onPressed: () {},
        ),
     ],
),)
```

## Additional information

If you have any issues or feature requests, please file them in the [issue tracker](https://github.com/tajaouart/animated_expandable_fab/issues).
