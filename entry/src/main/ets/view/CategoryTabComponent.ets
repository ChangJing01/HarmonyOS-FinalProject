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
  GOODS_EVALUATE_FONT_SIZE,
  MAX_LINES_TEXT
} from '../common/CommonConstants';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';

export interface CategoryData {
  id: number;
  name: Resource;
  subCategories: SubCategoryData[];
}

export interface SubCategoryData {
  id: number;
  name: Resource;
}

@Component
export default struct CategoryTab {
  @Link selectedCategoryIndex: number;
  @Link selectedSubCategoryIndex: number;
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;
  private categoryData: CategoryData[] = [
    {
      id: 0,
      name: $r('app.string.selected'),
      subCategories: [
        { id: 0, name: $r('app.string.sub_all') },
        { id: 1, name: $r('app.string.sub_hot') },
        { id: 2, name: $r('app.string.sub_new') }
      ]
    },
    {
      id: 1,
      name: $r('app.string.mobile_phone'),
      subCategories: [
        { id: 0, name: $r('app.string.sub_all') },
        { id: 1, name: $r('app.string.sub_android') },
        { id: 2, name: $r('app.string.sub_ios') }
      ]
    },
    {
      id: 2,
      name: $r('app.string.clothes'),
      subCategories: [
        { id: 0, name: $r('app.string.sub_all') },
        { id: 1, name: $r('app.string.sub_mens') },
        { id: 2, name: $r('app.string.sub_womens') }
      ]
    },
    {
      id: 3,
      name: $r('app.string.wear'),
      subCategories: [
        { id: 0, name: $r('app.string.sub_all') },
        { id: 1, name: $r('app.string.sub_casual') },
        { id: 2, name: $r('app.string.sub_formal') }
      ]
    },
    {
      id: 4,
      name: $r('app.string.home_furnishing'),
      subCategories: [
        { id: 0, name: $r('app.string.sub_all') },
        { id: 1, name: $r('app.string.sub_furniture') },
        { id: 2, name: $r('app.string.sub_decor') }
      ]
    }
  ];

  @Builder
  TabItem(item: CategoryData, index: number) {
    Column() {
      Text(item.name)
        .fontSize(this.selectedCategoryIndex === index ? BIGGER_FONT_SIZE : NORMAL_FONT_SIZE)
        .fontColor(this.selectedCategoryIndex === index ? this.currentThemeColors.primaryTextColor : this.currentThemeColors.secondaryTextColor)
        .maxLines(MAX_LINES_TEXT)
        .minFontSize(this.selectedCategoryIndex === index ? NORMAL_FONT_SIZE : GOODS_EVALUATE_FONT_SIZE)
        .maxFontSize(this.selectedCategoryIndex === index ? BIGGER_FONT_SIZE : NORMAL_FONT_SIZE)
        .fontWeight(this.selectedCategoryIndex === index ? FontWeight.Bold : FontWeight.Normal)

      if (this.selectedCategoryIndex === index) {
        Divider()
          .width(40)
          .height(3)
          .color(this.currentThemeColors.accentColor)
          .margin({ top: 4 })
      }
    }
    .padding({ left: 12, right: 12 })
    .height(56)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.selectedCategoryIndex = index;
      this.selectedSubCategoryIndex = 0;
    })
  }

  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categoryData, (item: CategoryData, index?: number) => {
          this.TabItem(item, index !== undefined ? index : 0)
        })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .padding({ left: 8, right: 8 })
    }
    .scrollable(ScrollDirection.Horizontal)  // 明确设置横向滚动
    .scrollBar(BarState.Off)
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(56)
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
  }
}