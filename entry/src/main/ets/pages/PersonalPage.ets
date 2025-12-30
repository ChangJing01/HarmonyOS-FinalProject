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

interface MenuItem {
  icon: Resource;
  title: Resource;
  showArrow: boolean;
}

@Component
export default struct PersonalPage {
  @State userName: string = '用户名';
  @State userAvatar: Resource = $r('app.media.ic_avatar');

  private menuItems: MenuItem[] = [
    { icon: $r('app.media.ic_order'), title: $r('app.string.my_orders'), showArrow: true },
    { icon: $r('app.media.ic_history'), title: $r('app.string.browse_history'), showArrow: true },
    { icon: $r('app.media.ic_theme'), title: $r('app.string.theme_settings'), showArrow: true },
    { icon: $r('app.media.ic_compare'), title: $r('app.string.goods_compare'), showArrow: true },
    { icon: $r('app.media.ic_clear'), title: $r('app.string.clear_cache'), showArrow: true },
    { icon: $r('app.media.ic_about'), title: $r('app.string.about_us'), showArrow: true }
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