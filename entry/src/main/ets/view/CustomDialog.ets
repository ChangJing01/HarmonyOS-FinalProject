/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * ...
 */

import { DEFAULT_THEME, ThemeColors } from '../common/Colors';

// ================== 自定义弹窗组件 ==================
@CustomDialog
export struct CustomToastDialog {
  // controller 是由 CustomDialogController 自动传入的，不需要手动赋值
  controller: CustomDialogController
  // 弹窗显示的文字内容
  message: string = ''

  // 链接全局主题色
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME

  build() {
    Column() {
      Text(this.message)
        .fontSize(16)
        .fontColor(Color.White)
        .margin({ top: 10, bottom: 10, left: 20, right: 20 })
    }
    // 使用主题色的强调色作为背景
    .backgroundColor(this.currentThemeColors.accentColor)
    .borderRadius(24)
    // 添加阴影让弹窗更有层次感
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.2)', offsetY: 4 })
    .onClick(() => {
      // 点击弹窗本体也可以关闭（可选体验）
      this.controller.close()
    })
  }
}