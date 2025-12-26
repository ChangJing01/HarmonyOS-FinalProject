/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import {
  LAYOUT_WIDTH_OR_HEIGHT,
  NORMAL_FONT_SIZE,
  BIGGER_FONT_SIZE,
  SMALL_FONT_SIZE
} from '../common/CommonConstants';
import promptAction from '@ohos.promptAction';
import { ThemeType, getThemeColors, ThemeColors, DEFAULT_THEME } from '../common/Colors';

interface MenuItem {
  id:number;
  icon: Resource;
  title: Resource;
  showArrow: boolean;
}

@Component
export default struct PersonalPage {
  @State userName: string = '用户名';
  @State userAvatar: Resource = $r('app.media.ic_avatar');
  //与全局 AppStorage 建立双向同步
  // 当 themeType 改变时，UI 会自动刷新（如果有依赖它的 UI），且我们修改它会同步回全局
  @StorageLink('themeType') currentThemeType: ThemeType = ThemeType.LIGHT;
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;

  //为菜单项添加 id，方便识别 (id: 3 对应主题设置)
  private menuItems: MenuItem[] = [
    { id:1, icon: $r('app.media.ic_order'), title: $r('app.string.my_orders'), showArrow: true },
    { id:2, icon: $r('app.media.ic_history'), title: $r('app.string.browse_history'), showArrow: true },
    { id:3, icon: $r('app.media.ic_theme'), title: $r('app.string.theme_settings'), showArrow: true },
    { id:4, icon: $r('app.media.ic_compare'), title: $r('app.string.goods_compare'), showArrow: true },
    { id:5, icon: $r('app.media.ic_clear'), title: $r('app.string.clear_cache'), showArrow: true },
    { id:6, icon: $r('app.media.ic_about'), title: $r('app.string.about_us'), showArrow: true }
  ];

  @Builder
  UserInfoSection() {
    Row({ space: 16 }) {
      // 头像
      Image(this.userAvatar)
        .width(64)
        .height(64)
        .borderRadius(32)
        .backgroundColor('#F5F5F5')

      // 用户信息
      Column({ space: 8 }) {
        Text(this.userName)
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor('#333333')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.edit_profile'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#999999')
          .onClick(() => {
            // 编辑资料逻辑
          })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r('app.media.ic_arrow_right'))
        .width(20)
        .height(20)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
  }

  @Builder
  OrderStatistics() {
    Row() {
      Column({ space: 8 }) {
        Text('0')
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor('#333333')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.pending_payment'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .layoutWeight(1)

      Column({ space: 8 }) {
        Text('0')
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor('#333333')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.pending_shipment'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .layoutWeight(1)

      Column({ space: 8 }) {
        Text('0')
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor('#333333')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.pending_receipt'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .layoutWeight(1)

      Column({ space: 8 }) {
        Text('0')
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor('#333333')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.completed'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .layoutWeight(1)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .margin({ top: 8 })
  }

  @Builder
  MenuItemBuilder(item: MenuItem) {
    Row({ space: 12 }) {
      Image(item.icon)
        .width(24)
        .height(24)

      Text(item.title)
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor('#333333')
        .layoutWeight(1)

      if (item.showArrow) {
        Image($r('app.media.ic_arrow_right'))
          .width(16)
          .height(16)
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      // 菜单项点击逻辑
    })
  }

  //显示主题选择弹窗的方法
  showThemeDialog() {
    promptAction.showActionMenu({
      title: '选择应用主题',
      buttons: [
        { text: '默认白', color: '#333333' },
        { text: '深色模式', color: '#000000' },
        { text: '护眼模式', color: '#FF6B35' }
      ]
    }).then(data => {
      let selectedType: ThemeType;
      // 根据点击的按钮索引决定切换哪个主题
      switch (data.index) {
        case 0:
          selectedType = ThemeType.LIGHT;
          break;
        case 1:
          selectedType = ThemeType.DARK;
          break;
        case 2:
          selectedType = ThemeType.EYECARE;
          break;
        default:
          return;
      }

      // 核心逻辑：修改状态变量，AppStorage 会自动同步到全局
      this.currentThemeType = selectedType;
      this.currentThemeColors = getThemeColors(selectedType);

      // 可以在这里打印日志验证
      console.info('Theme changed to:', selectedType);
    });
  }


  build() {
    Scroll() {
      Column() {
        // 用户信息区域
        this.UserInfoSection()

        // 订单统计
        this.OrderStatistics()

        // 功能菜单列表
        Column() {
          ForEach(this.menuItems, (item: MenuItem) => {
            this.MenuItemBuilder(item)
            Divider()
              .strokeWidth(1)
              .color('#F0F0F0')
          })
        }
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .margin({ top: 8 })

        // 退出登录按钮
        Button($r('app.string.logout'))
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor('#FF4D4F')
          .backgroundColor('#FFFFFF')
          .width(LAYOUT_WIDTH_OR_HEIGHT)
          .height(48)
          .margin({ top: 16, bottom: 16 })
          .borderRadius(8)
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .padding(8)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#F5F5F5')
  }
}