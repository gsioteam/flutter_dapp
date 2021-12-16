# flutter_dapp

A runtime application plugin for flutter. Using [js_script](https://github.com/gsioteam/js_script) for logic script, and [xml_layout](https://github.com/gsioteam/xml_layout) for UI template.

## Usage

```dart
DApp(
    // Load main.js and main.xml as the entry widget
    entry: '/main',
    fileSystems: [
        // A file wrap for reading script and template
        fileSystem,
    ],
)
```

## XML Tags

### scaffold

- Attribute
    - appBar `PreferredSizeWidget`
    - body `Widget`
    - floatingActionButton `Widget`
    - drawer `Widget`
    - endDrawer `Widget`
    - bottomNavigationBar `Widget`
    - bottomSheet `Widget`
    - background `Color`
    - resizeToAvoidBottomInset `bool`
- Child Same as the `body` attribute.

### row

- Attributes:
    - mainAxisAlignment `MainAxisAlignment` default: *MainAxisAlignment.start*
    - mainAxisSize `MainAxisSize` default: *MainAxisSize.max*
    - crossAxisAlignment `CrossAxisAlignment` default: *CrossAxisAlignment.center*
    - verticalDirection `VerticalDirection` *VerticalDirection.down*
    - textDirection `TextDirection`
    - textBaseline `TextBaseline`
- Children `Widget` 

### column

- Attributes:
    - mainAxisAlignment `MainAxisAlignment` default: *MainAxisAlignment.start*
    - mainAxisSize `MainAxisSize` default: *MainAxisSize.max*
    - crossAxisAlignment `CrossAxisAlignment` default: *CrossAxisAlignment.center*
    - verticalDirection `VerticalDirection` *VerticalDirection.down*
    - textDirection `TextDirection`
    - textBaseline `TextBaseline`
- Children `Widget` 

### center

- Attributes:
    - widthFactor `double`
    - heightFactor `double`
- Child `Widget`

### button

- Attributes:
    - onPressed `Void Function`
    - onLongPress `Void Function`
    - type `DButtonType` default: *DButtonType.elevated*
    - minimumSize `Size`
    - tapTargetSize `MaterialTapTargetSize`
    - padding `EdgeInsets`
    - color `Color`
- Child `Widget`

### widget

- Description:
    - Load another dapp widget.
- Attibutes:
    - src `String` 
    - data `any`. Pass to the `load` function as the first argument.

### appbar

- Attributes:
    - leading `Widget`
    - actions `List<Widget>`
    - bottom `PreferredSizeWidget`
    - brightness `Brightness`
    - background `Color`
    - color `Color`
    - height `double` default: `56`
- Child `Widget`

### list-view

- Attributes:
    - builder `Widget Function(context, index)` 
    - itemCount `int` default: `0`
- Children `Widget` available when builder is null.

### list-item

- Description:
    - Almost same as `ListTile` in dart, could be used in list-view.
- Attributes:
    - leading `Widget`
    - title `Widget`
    - subtitle `Widget`
    - trailing `Widget`
    - onTap `Void Function`
    - dense `bool`
    - padding `EdgeInsets`
    - color `Color`

### img

- Description:
    - `image` tag is same as `img` tag
- Attributes:
    - src `String`
    - width `double`
    - height `double`
    - fit `BoxFit` default: *BoxFit.contain*
    - headers `Map` 
        - http headers, available when `src` is net image.
    - gaplessPlayback `bool` default: *false*

### callback

- Description:
    - Generate a `Void Function`, and pass custom arguments
- Attributes:
    - function `String` the function name in script.
    - args `List` the arguments.

### refresh

- Descrition:
    - Drag down to refresh and load more widget.
- Attributes:
    - loading `bool` 
    - onRefresh `Void Function`
    - onLoadMore `Void Function`
    - refreshInset `double` default: *36*
- Child `Widget` the scrollable widget.

### tabs

- Descrition:
    - Wrap of `DefaultTabController`
- Attributes:
    - scrollable `bool` default: *false*
    - elevation `double` default: *0*
    - background `Color` 
- Children `TabItem`

### tab

- Descrition:
    - Generate a `TabItem`
- Attributes:
    - title `String`
    - icon `Widget`
- Child `Widget`

### input

- Attributes:
    - placeholder `String`
    - text `String`
    - autofocus `bool` default: *false*
    - onChange `Void Function(String newText)`
    - onSubmit `Void Function(String text)`
    - onFocus `Void Function`
    - onBlur `Void Function`
    - style `TextStyle`

### icon

- Attributes:
    - size `double`
    - color `Color`
- Child `IconData`

### textstyle

- Description:
    - Generate a `TextStyle`
- Attributes:
    - color `Color`
    - background `Color`
    - size `double`

### stack

- Attributes:
    - alignment `Alignment` default: *Alignment.topLeft*
    - textDirection `TextDirection`
    - fit `StackFit` default: *StackFit.loose*
    - clip `Clip` default: *Clip.hardEdge*
- Children `Widget`

### view

- Description:
    - Generate a `Container`
- Attributes:
    - width `double`
    - height `double`
    - color `Color`
    - animate `bool` default: *false*
    - duration `Duration` avaiable when `animate` is true
    - clip `Clip` default: *Clip.none*
    - border `Border` 
    - radius `BorderRadius`
    - gradient `Gradient`
    - padding `EdgeInsets`
    - alignment `Alignment`
    - margin `EdgeInsets`

### Border

- Attributes:
    - top `BorderSide` default: *BorderSide.none*
    - right `BorderSide` default: *BorderSide.none*
    - bottom `BorderSide` default: *BorderSide.none*
    - left `BorderSide` default: *BorderSide.none*

### Border.all

- Attributes:
    - color `Color` default: *Colors.black*
    - width `double` default: *1.0*
    - style `BorderStyle` default: *BorderStyle.none*

### Border.symmetric

- Attributes:
    - vertical `BorderSide` default: *BorderSide.none*
    - horizontal `BorderSide` default: *BorderSide.none*

### LinearGradient

- Attributes:
    - begin `Alignment` default: *Alignment.centerRight*
    - end `Alignment` default: *Alignment.centerRight*
    - colors `List<Color>` 
    - stops `List<double>`
    - mode `TileMode` default: *TileMode.clamp*

### RadialGradient

- Attributes:
    - center `Alignment` default: *Alignment.center*
    - radius `double` default: *0.5*
    - colors `List<Color>` 
    - stops `List<double>`
    - mode `TileMode` default: *TileMode.clamp*
    - focal `Alignment`
    - focalRadius `double` default: *0*

### slivers

- Description:
    - Wrap of `CustomScrollView`
- Attributes:
    - direction `Axis` default: *Axis.vertical*
    - reverse `bool` default: *false*
- Children `Widget`

### sliver-list-view

- Attrbutes:
    - builder `Widget Function(context, index)`
    - itemCount `int` default: *0*
- Children `Widget` available when builder is null.

### sliver-appbar

- Attrbutes:
    - leading `Widget`
    - actions `List<Widget>`
    - bottom `PreferredSizeWidget`
    - brightness `Brightness`
    - background `Color`
    - color `Color`
    - floating `bool` default: *false*
    - expandedHeight `double`
- Child `Widget` as the title of AppBar

### FlexibleSpaceBar

- Attributes:
    - padding `EdgeInsets`
    - background `Widget`
    - center `bool`
    - mode `CollapseMode` default: *CollapseMode.parallax*
- Child `Widget` as the title

### sliver-container

- Child `Widget`

### text

- Attributes:
    - lines `int` 
    - overflow `TextOverflow`
- Children `InlineSpan` or text 

### span

- Description:
    - Generate a `TextSpan` when child is text or `List<TextSpan>`, Generate a `WidgetSpan` when child is Widget.

### Expanded

- Attributes:
    - flex `int` default: *1*

### Divider

- Attributes:
    - type `String` options: `vertical`, `horizontal`
    - width `double` available when type is `vertical`
    - height `double` available when type is `horizontal`
    - thickness `double`
    - indent `double`
    - endIndent `double`

### menu-button

- Description:
    - A wrap of `PopupMenuButton` in flutter
- Attributes:
    - onSelected `PopupMenuItemSelected`
    - onCanceled `PopupMenuCanceled`
    - items `List<PopupMenuEntry>`
    - padding `EdgeInsets` default: *EdgeInsets.all(8.0)*
    - tooltip `String`
    - elevation `double`
    - icon `Widget`
    - iconSize`double`
    - offset `Offset` default: *Offset.zero*
    - enabled `bool` default: *true*
    - color `Color`
- Child `Widget`

### menu-item

- Description:
    - A wrap of `PopupMenuItem` in flutter
- Attributes:
    - value `any`
    - enabled `bool` default: *true*
    - height `double` default: *kMinInteractiveDimension*
    - padding `EdgeInsets` 
    - style `TextStyle`
    - color `Color`
    - size `double`
- Child `Widget`

### menu-divider

- Description:
    - A wrap of `PopupMenuDivider` in flutter
- Attributes:
    - height `double` default: *16*

### switch

- Description:
    - A wrap of `AnimatedSwitcher` in flutter
- Attributes:
    - duration `Duration` default: *Duration(milliseconds: 300)*
    - axis `Axis` default: *Axis.vertical*
- Child `Widget`

### grid-view

- Description:
    - A wrap of `GridView` in flutter
- Attributes:
    - builder `IndexedWidgetBuilder`
    - itemCount `int` default: *0*  Available when `builder` is not null
    - padding `EdgeInsets` default: *EdgeInsets.zero*
    - crossAxisCount `int` default: *4*
    - childAspectRatio `double` default: *1*
- Children `Widget` Available when `builder` is null

### sliver-grid-view

- Description:
    - A wrap of `SliverGridView` in flutter
- Attributes:
    - builder `IndexedWidgetBuilder`
    - itemCount `int` default: *0*  Available when `builder` is not null
    - crossAxisCount `int` default: *4*
    - childAspectRatio `double` default: *1*
- Children `Widget` Available when `builder` is null

## Extended inline method

### js(method, arguments...)

```xml
<if candidate="js(isFavorate)">
    <view color="red"/>
</if>
```

- Description:
    - Call method define in the js script.

### array(arguments...)

```xml
<callback function="getItem" array="array(arg1, arg2)"/>
```

- Description:
    - Convert arguments to a `List`.

### length(list)

- Description:
    - Get length of list.

### isNull(obj)
### isNotNull(obj)
### switch(test, a, b)

- Description:
    - return `a` if `test` equal true, otherwise return `b`.