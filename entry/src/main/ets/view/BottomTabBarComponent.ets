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
  BOTTOM_TAB_BAR_HEIGHT,
  TAB_ICON_SIZE,
  TAB_FONT_SIZE,
  LAYOUT_WIDTH_OR_HEIGHT
} from '../common/CommonConstants';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';

export interface TabBarItem {
  title: Resource;
  icon: Resource;
  selectedIcon: Resource;
  index: number;
}

@Component
export default struct BottomTabBar {
  @Link currentIndex: number;
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;//使用 @StorageLink 确保当 PersonalPage 改变主题时，这里会自动刷新

  private tabBarData: TabBarItem[] = [
    {
      title: $r('app.string.home'),
      icon: $r('app.media.ic_home_normal'),
      selectedIcon: $r('app.media.ic_home_selected'),
      index: 0
    },
    {
      title: $r('app.string.category'),
      icon: $r('app.media.ic_category_normal'),
      selectedIcon: $r('app.media.ic_category_selected'),
      index: 1
    },
    {
      title: $r('app.string.shopping_cart'),
      icon: $r('app.media.ic_cart_normal'),
      selectedIcon: $r('app.media.ic_cart_selected'),
      index: 2
    },
    {
      title: $r('app.string.personal'),
      icon: $r('app.media.ic_personal_normal'),
      selectedIcon: $r('app.media.ic_personal_selected'),
      index: 3
    }
  ];

  @Builder
  TabBarItemBuilder(item: TabBarItem) {
    Column({ space: 4 }) {
      Image(this.currentIndex === item.index ? item.selectedIcon : item.icon)
        .width(TAB_ICON_SIZE)
        .height(TAB_ICON_SIZE)
        .objectFit(ImageFit.Contain)

      Text(item.title)
        .fontSize(TAB_FONT_SIZE)
        .fontColor(this.currentIndex === item.index ? this.currentThemeColors.tabSelectedColor : this.currentThemeColors.tabUnselectedColor)
        .fontWeight(this.currentIndex === item.index ? FontWeight.Medium : FontWeight.Normal)
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = item.index;
    })
  }

  build() {
    Row() {
      ForEach(this.tabBarData, (item: TabBarItem) => {
        this.TabBarItemBuilder(item)
      })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(BOTTOM_TAB_BAR_HEIGHT)
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .shadow({
      radius: 8,
      color: '#00000015',
      offsetY: -2
    })
  }
}