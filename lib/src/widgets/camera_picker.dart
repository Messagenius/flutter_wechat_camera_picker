// Copyright 2019 The FlutterCandies author. All rights reserved.
// Use of this source code is governed by an Apache license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wechat_picker_library/wechat_picker_library.dart'
    show buildTheme;

import '../../wechat_camera_picker.dart';

/// The camera picker widget.
/// 拍照选择器。
///
/// The picker provides create an [AssetEntity] through the [CameraController].
/// 该选择器可以通过 [CameraController] 创建 [AssetEntity]。
class CameraPicker extends StatefulWidget {
  const CameraPicker({
    super.key,
    this.pickerConfig = const CameraPickerConfig(),
    this.createPickerState,
    this.locale,
    this.onXFileCaptured,
    this.showGalleryButton = false,
    this.onGalleryButtonPressed,
    this.onBack,
  });

  /// {@macro wechat_camera_picker.CameraPickerConfig}
  final CameraPickerConfig pickerConfig;

  /// Creates a customized [CameraPickerState].
  /// 构建一个自定义的 [CameraPickerState]。
  final CameraPickerState Function()? createPickerState;

  /// The [Locale] to determine text delegates for the picker.
  final Locale? locale;

  final Future<bool> Function({
    required XFile file,
    required CameraPickerViewType viewType,
    Duration? duration,
  })? onXFileCaptured;

  final bool showGalleryButton;

  final void Function(BuildContext context)? onGalleryButtonPressed;

  final void Function()? onBack;

  /// Static method to create [AssetEntity] through camera.
  /// 通过相机创建 [AssetEntity] 的静态方法
  static Future<AssetEntity?> pickFromCamera(
    BuildContext context, {
    CameraPickerConfig pickerConfig = const CameraPickerConfig(),
    CameraPickerState Function()? createPickerState,
    bool useRootNavigator = true,
    CameraPickerPageRoute<AssetEntity> Function(Widget picker)?
        pageRouteBuilder,
    Locale? locale,
    Future<bool> Function({
      required XFile file,
      required CameraPickerViewType viewType,
      Duration? duration,
    })? onXFileCaptured,
    bool? showGalleryButton,
    void Function(BuildContext context)? onGalleryButtonPressed,
    void Function()? onBack,
  }) {
    final Widget picker = CameraPicker(
      pickerConfig: pickerConfig,
      createPickerState: createPickerState,
      locale: locale,
      onXFileCaptured: onXFileCaptured,
      showGalleryButton: showGalleryButton ?? false,
      onGalleryButtonPressed: onGalleryButtonPressed,
      onBack: onBack,
    );
    return Navigator.of(
      context,
      rootNavigator: useRootNavigator,
    ).push<AssetEntity>(
      pageRouteBuilder?.call(picker) ??
          CameraPickerPageRoute<AssetEntity>(builder: (_) => picker),
    );
  }

  /// Build a dark theme according to the theme color.
  /// 通过主题色构建一个默认的暗黑主题
  static ThemeData themeData(
    Color themeColor, {
    bool light = false,
  }) {
    return buildTheme(themeColor, light: light);
  }

  @override
  CameraPickerState createState() =>
      // ignore: no_logic_in_create_state
      createPickerState?.call() ?? CameraPickerState();
}
