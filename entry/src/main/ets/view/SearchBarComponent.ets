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
  SMALL_ICON_SIZE,
  INPUT_HEIGHT,
  INPUT_BORDER_RADIUS,
  INPUT_PADDING
} from '../common/CommonConstants';

@Component
export default struct SearchBar {
  @Link searchText: string;
  @State placeholder: Resource = $r('app.string.search_placeholder');
  private onSearchClick?: () => void;
  private onClearClick?: () => void;

  build() {
    Row({ space: 8 }) {
      // 搜索图标
      Image($r('app.media.ic_search'))
        .width(SMALL_ICON_SIZE)
        .height(SMALL_ICON_SIZE)
        .margin({ left: INPUT_PADDING })

      // 搜索输入框
      TextInput({ text: this.searchText, placeholder: this.placeholder })
        .layoutWeight(1)
        .height(INPUT_HEIGHT)
        .fontSize(NORMAL_FONT_SIZE)
        .backgroundColor(Color.Transparent)
        .onChange((value: string) => {
          this.searchText = value;
        })
        .onSubmit(() => {
          if (this.onSearchClick) {
            this.onSearchClick();
          }
        })

      // 清空按钮
      if (this.searchText.length > 0) {
        Image($r('app.media.ic_clear'))
          .width(SMALL_ICON_SIZE)
          .height(SMALL_ICON_SIZE)
          .onClick(() => {
            this.searchText = '';
            if (this.onClearClick) {
              this.onClearClick();
            }
          })
      }

      // 搜索按钮
      Button($r('app.string.search'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor('#FFFFFF')
        .backgroundColor('#FF4D4F')
        .height(INPUT_HEIGHT - 8)
        .padding({ left: 16, right: 16 })
        .margin({ right: 8 })
        .onClick(() => {
          if (this.onSearchClick) {
            this.onSearchClick();
          }
        })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(INPUT_HEIGHT)
    .backgroundColor('#F5F5F5')
    .borderRadius(INPUT_BORDER_RADIUS)
    .alignItems(VerticalAlign.Center)
  }
}