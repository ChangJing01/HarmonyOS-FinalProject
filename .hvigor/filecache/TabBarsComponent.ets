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

import { initTabBarData } from '../viewmodel/InitialData';
import {
  LAYOUT_WIDTH_OR_HEIGHT,
  NORMAL_FONT_SIZE,
  BIGGER_FONT_SIZE,
  MAX_FONT_SIZE,
  MAX_OFFSET_Y,
  REFRESH_TIME,
  GOODS_EVALUATE_FONT_SIZE,
  MAX_LINES_TEXT
} from '../common/CommonConstants';
import GoodsList from './GoodsListComponent';
import PutDownRefresh from './PutDownRefreshLayout';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';

@Component
export default struct TabBar {
  private currentOffsetY: number = 0;
  private timer: number = 0;
  @State tabsIndex: number = 0;
  @State refreshStatus: boolean = false;
  @State refreshText: Resource = $r('app.string.refresh_text');
  @Link layoutMode: 'list' | 'grid';
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;

  putDownRefresh(event?: TouchEvent): void {
    if (event === undefined) {
      return;
    }
    switch (event.type) {
      // Record the y-coordinate pressed by the finger.
      case TouchType.Down:
        this.currentOffsetY = event.touches[0].y;
        break;
      case TouchType.Move:
      // Determine whether to refresh based on the drop-down offset.
        this.refreshStatus = event.touches[0].y - this.currentOffsetY > MAX_OFFSET_Y;
        break;
      case TouchType.Cancel:
        break;
      case TouchType.Up:
      // Only simulation effect, no data request.
        this.timer = setTimeout(() => {
          this.refreshStatus = false;
        }, REFRESH_TIME);
        break;
      default:
        break;
    }
  }

  aboutToDisappear() {
    clearTimeout(this.timer);
  }

  build() {
    Column() {
      // 顶部导航栏：tabs 和 布局切换按钮
      Row() {
        // Tabs 部分
        Scroll() {
          Row({ space: 12 }) {
            // 精选 tab
            Text($r('app.string.selected'))
              .fontSize(this.tabsIndex === 0 ? BIGGER_FONT_SIZE : NORMAL_FONT_SIZE)
              .fontColor(this.tabsIndex === 0 ? this.currentThemeColors.primaryTextColor : this.currentThemeColors.secondaryTextColor)
              .onClick(() => {
                this.tabsIndex = 0;
              })

            // 其他 tabs
            ForEach(initTabBarData, (item: Resource, index?: number) => {
              Text(item)
                .fontSize(this.tabsIndex === (index !== undefined ? index + 1 : 1) ? BIGGER_FONT_SIZE : NORMAL_FONT_SIZE)
                .fontColor(this.tabsIndex === (index !== undefined ? index + 1 : 1) ? this.currentThemeColors.primaryTextColor : this.currentThemeColors.secondaryTextColor)
                .onClick(() => {
                  this.tabsIndex = index !== undefined ? index + 1 : 1;
                })
            })
          }
          .padding({ left: 8, right: 8 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        // 布局切换按钮
        Text(this.layoutMode === 'list' ? '⊞' : '☰')
          .fontSize(16)
          .fontColor(this.currentThemeColors.secondaryTextColor)
          .width(40)
          .height(56)
          .textAlign(TextAlign.Center)
          .backgroundColor(this.currentThemeColors.cardBackgroundColor)
          .onClick(() => {
            this.layoutMode = this.layoutMode === 'list' ? 'grid' : 'list';
          })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(56)
      .backgroundColor(this.currentThemeColors.cardBackgroundColor)

      // 内容区域
      Scroll() {
        if (this.tabsIndex === 0) {
          // 精选 tab 显示商品列表
          Column() {
            if (this.refreshStatus) {
              PutDownRefresh({ refreshText: $refreshText })
            }
            GoodsList({
              layoutMode: this.layoutMode
            })
            Text($r('app.string.to_bottom')).fontSize(NORMAL_FONT_SIZE).fontColor($r('app.color.gray'))
          }
        } else {
          // 其他 tab 显示对应内容
          Column() {
            Text(initTabBarData[this.tabsIndex - 1]).fontSize(MAX_FONT_SIZE)
          }
          .justifyContent(FlexAlign.Center)
          .width(LAYOUT_WIDTH_OR_HEIGHT)
          .height(LAYOUT_WIDTH_OR_HEIGHT)
        }
        .width(LAYOUT_WIDTH_OR_HEIGHT)
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .layoutWeight(1)
      .onTouch((event?: TouchEvent) => {
        this.putDownRefresh(event);
      })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
  }
}