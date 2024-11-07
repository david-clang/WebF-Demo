/*
 * Copyright (C) 2022-present The WebF authors. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:webf/webf.dart';

class FlutterButton extends WidgetElement {
  FlutterButton(BindingContext? context) : super(context);

  handlePressed(BuildContext context) {
    dispatchEvent(Event(EVENT_CLICK));
  }

  @override
  Map<String, dynamic> get defaultStyle => {'display': 'inline-block'};

  Widget buildButton(BuildContext context, String type, Widget child) {
    switch (type) {
      case 'primary':
        return ElevatedButton(
            onPressed: () => handlePressed(context), child: child);
      case 'default':
      default:
        return OutlinedButton(
            onPressed: () => handlePressed(context), child: child);
    }
  }

  @override
  void initializeProperties(Map<String, BindingObjectProperty> properties) {
    super.initializeProperties(properties);
    properties['type'] = BindingObjectProperty(
        getter: () => type, setter: (value) => type = value);
  }

  String get type => getAttribute('type') ?? 'default';
  set type(value) {
    internalSetAttribute('type', value?.toString() ?? '');
  }

  @override
  void initializeMethods(Map<String, BindingObjectMethod> methods) {
    super.initializeMethods(methods);
    methods['dispatchRemove'] = BindingObjectMethodSync(call: (args) async {
      dispatchEvent(Event('remove'));
    });
  }

  @override
  Widget build(BuildContext context, List<Widget> children) {
    return buildButton(context, type,
        children.isNotEmpty ? children[0] : SizedBox.fromSize(size: Size.zero));
  }
}
