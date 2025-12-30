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

import TabBar from '../view/TabBarsComponent';
import BottomTabBar from '../view/BottomTabBarComponent';
import CategoryPage from './CategoryPage';
import ShoppingCartPage from './ShoppingCartPage';
import PersonalPage from './PersonalPage';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';
import {
  LAYOUT_WIDTH_OR_HEIGHT,
  NAV_BAR_HEIGHT
} from '../common/CommonConstants';

@Entry
@Component
struct ListIndex {
  @State currentTabIndex: number = 0;
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;//使用 @StorageLink 确保当 PersonalPage 改变主题时，这里会自动刷新


  @Builder
  NavigationTitle() {
    Row() {
      Text(this.getPageTitle())
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .margin({top:34})
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(NAV_BAR_HEIGHT)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
  }

  getPageTitle(): Resource {
    switch (this.currentTabIndex) {
      case 0:
        return $r('app.string.shopping_mall');
      case 1:
        return $r('app.string.category');
      case 2:
        return $r('app.string.shopping_cart');
      case 3:
        return $r('app.string.personal');
      default:
        return $r('app.string.shopping_mall');
    }
  }

  @Builder
  PageContent() {
    if (this.currentTabIndex === 0) {
      // 首页内容
      Column() {
        TabBar()
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(LAYOUT_WIDTH_OR_HEIGHT)
    } else if (this.currentTabIndex === 1) {
      // 分类页面
      CategoryPage()
    } else if (this.currentTabIndex === 2) {
      // 购物车页面
      ShoppingCartPage()
    } else if (this.currentTabIndex === 3) {
      // 个人中心页面
      PersonalPage()
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      this.NavigationTitle()

      // 主内容区域
      Stack() {
        this.PageContent()
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .layoutWeight(1)

      // 底部 Tab Bar
      BottomTabBar({ currentIndex: $currentTabIndex })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor(this.currentThemeColors.backgroundColor) //$r('app.color.primaryBgColor')
  }
}