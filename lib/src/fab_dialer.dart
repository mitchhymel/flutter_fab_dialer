part of flutter_fab_dialer;

class FabDialer extends StatefulWidget {
  const FabDialer(this._fabMiniMenuItemList, this._fabColor, this._fabIcon);

  final List<FabMiniMenuItem> _fabMiniMenuItemList;
  final Color _fabColor;
  final Icon _fabIcon;

  @override
  FabDialerState createState() =>
      new FabDialerState(_fabMiniMenuItemList, _fabColor, _fabIcon);
}

class FabDialerState extends State<FabDialer> with TickerProviderStateMixin {
  FabDialerState(this._fabMiniMenuItemList, this._fabColor, this._fabIcon);

  int _angle = 90;
  bool _isRotated = true;
  final List<FabMiniMenuItem> _fabMiniMenuItemList;
  final Color _fabColor;
  final Icon _fabIcon;
  List<FabMenuMiniItemWidget> _fab_menu_items;

  AnimationController _controller;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _controller.reverse();

    setFabMenu(this._fabMiniMenuItemList);
    super.initState();
  }

  void setFabMenu(List<FabMiniMenuItem> fabMenuList) {
    List<FabMenuMiniItemWidget> _fab_menu_items = new List();
    for (int i = 0; i < _fabMiniMenuItemList.length; i++) {
      _fab_menu_items.add(new FabMenuMiniItemWidget(
        _fabMiniMenuItemList[i].heroTag,
        tooltip: _fabMiniMenuItemList[i].tooltip,
        text: _fabMiniMenuItemList[i].text,
        elevation: _fabMiniMenuItemList[i].elevation,
        icon: _fabMiniMenuItemList[i].icon,
        index: i,
        onPressed: _fabMiniMenuItemList[i].onPressed,
        textColor: _fabMiniMenuItemList[i].textColor,
        fabColor: _fabMiniMenuItemList[i].fabColor,
        chipColor: _fabMiniMenuItemList[i].chipColor,
        controller: _controller,
      ));
    }
    ;
    this._fab_menu_items = _fab_menu_items;
  }

  void _rotate() {
    setState(() {
      if (_isRotated) {
        _angle = 45;
        _isRotated = false;
        _controller.forward();
      } else {
        _angle = 90;
        _isRotated = true;
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _fab_menu_items,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new FloatingActionButton(
                    child: new RotationTransition(
                      turns: new AlwaysStoppedAnimation(_angle / 360),
                      child: _fabIcon,
                    ),
                    backgroundColor: _fabColor,
                    onPressed: _rotate)
              ],
            ),
          ],
        ));
  }
}
