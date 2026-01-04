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

import CategoryTab, { CategoryData, SubCategoryData } from '../view/CategoryTabComponent';
import CategorySub from '../view/CategorySubComponent';
import GoodsList from '../view/GoodsListComponent';
import { GoodsCategory } from '../viewmodel/InitialData';
import {
  LAYOUT_WIDTH_OR_HEIGHT
} from '../common/CommonConstants';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';

@Component
export default struct CategoryPage {
  @State selectedCategoryIndex: number = 0;
  @State selectedSubCategoryIndex: number = 0;
  @State showSubCategory: boolean = true;
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

  getSubCategoriesForCurrentTab(): SubCategoryData[] {
    return this.categoryData[this.selectedCategoryIndex].subCategories;
  }

  getCurrentSubCategoryName(): Resource {
    const subCategories = this.getSubCategoriesForCurrentTab();
    return subCategories[this.selectedSubCategoryIndex].name;
  }

  // 获取当前选中分类对应的GoodsCategory
  getCurrentCategory(): GoodsCategory | null {
    const categoryMap = [
      null,                      // 0: 精选 - 显示全部
      GoodsCategory.PHONE,       // 1: 手机
      GoodsCategory.CLOTHES,     // 2: 服饰
      GoodsCategory.WEAR,        // 3: 穿搭
      GoodsCategory.FURNITURE    // 4: 家具
    ];
    return categoryMap[this.selectedCategoryIndex];
  }

  build() {
    Column() {
      // 一级分类 Tab（横向）
      Row() {
        CategoryTab({
          selectedCategoryIndex: $selectedCategoryIndex,
          selectedSubCategoryIndex: $selectedSubCategoryIndex
        })
          .layoutWeight(1)

        // 切换左侧栏显示/隐藏按钮
        Text(this.showSubCategory ? '◀' : '▶')
          .fontSize(16)
          .fontColor(this.currentThemeColors.secondaryTextColor)
          .width(40)
          .height(56)
          .textAlign(TextAlign.Center)
          .backgroundColor(this.currentThemeColors.cardBackgroundColor)
          .onClick(() => {
            this.showSubCategory = !this.showSubCategory;
          })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)

      // 二级分类和商品列表（左右分栏）
      Row() {
        // 左侧：二级子分类（可隐藏）
        CategorySub({
          selectedSubCategoryIndex: $selectedSubCategoryIndex,
          subCategories: this.getSubCategoriesForCurrentTab()
        })
          .width(this.showSubCategory ? '25%' : '0%')
          .visibility(this.showSubCategory ? Visibility.Visible : Visibility.Hidden)

        // 右侧：商品列表（根据选中的分类显示）
        // 使用条件渲染确保切换分类时重新创建GoodsList组件
        if (this.selectedCategoryIndex === 0) {
          // 精选 - 显示所有商品的随机列表
          GoodsList({
            shuffle: true
          })
            .layoutWeight(1)
        } else if (this.selectedCategoryIndex === 1) {
          // 手机
          GoodsList({
            category: GoodsCategory.PHONE
          })
            .layoutWeight(1)
        } else if (this.selectedCategoryIndex === 2) {
          // 服饰
          GoodsList({
            category: GoodsCategory.CLOTHES
          })
            .layoutWeight(1)
        } else if (this.selectedCategoryIndex === 3) {
          // 穿搭
          GoodsList({
            category: GoodsCategory.WEAR
          })
            .layoutWeight(1)
        } else if (this.selectedCategoryIndex === 4) {
          // 家具
          GoodsList({
            category: GoodsCategory.FURNITURE
          })
            .layoutWeight(1)
        }
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .layoutWeight(1)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor(this.currentThemeColors.backgroundColor)
  }
}