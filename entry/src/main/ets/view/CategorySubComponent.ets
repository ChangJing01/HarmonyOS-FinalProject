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
  SMALL_FONT_SIZE,
  CATEGORY_LIST_WIDTH,
  CATEGORY_ITEM_HEIGHT
} from '../common/CommonConstants';

export interface SubCategoryItem {
  id: number;
  name: Resource;
}

@Component
export default struct CategorySub {
  @Link selectedSubCategoryIndex: number;
  @Prop subCategories: SubCategoryItem[];

  @Builder
  SubCategoryItem(item: SubCategoryItem, index: number) {
    Column() {
      Text(item.name)
        .fontSize(this.selectedSubCategoryIndex === index ? NORMAL_FONT_SIZE : SMALL_FONT_SIZE)
        .fontColor(this.selectedSubCategoryIndex === index ? '#FF4D4F' : '#333333')
        .fontWeight(this.selectedSubCategoryIndex === index ? FontWeight.Medium : FontWeight.Normal)
    }
    .width(CATEGORY_LIST_WIDTH)
    .height(CATEGORY_ITEM_HEIGHT)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.selectedSubCategoryIndex === index ? '#FFF5F5' : '#FFFFFF')
    .borderRadius(4)
    .onClick(() => {
      this.selectedSubCategoryIndex = index;
    })
  }

  build() {
    Scroll() {
      Column({ space: 8 }) {
        ForEach(this.subCategories, (item: SubCategoryItem, index?: number) => {
          this.SubCategoryItem(item, index !== undefined ? index : 0)
        })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    }
    .scrollBar(BarState.Off)
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#F5F5F5')
  }
}