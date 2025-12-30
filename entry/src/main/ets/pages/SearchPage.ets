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

import SearchBar from '../view/SearchBarComponent';
import GoodsList from '../view/GoodsListComponent';
import {
  LAYOUT_WIDTH_OR_HEIGHT,
  NORMAL_FONT_SIZE,
  SMALL_FONT_SIZE,
  NAV_BAR_HEIGHT
} from '../common/CommonConstants';

@Component
export default struct SearchPage {
  @State searchText: string = '';
  @State isSearching: boolean = false;
  @State searchHistory: string[] = ['手机', '笔记本', '耳机', '键盘'];
  @State hotSearchList: string[] = ['华为手机', '苹果手机', '小米手机', '蓝牙耳机', '机械键盘'];
  @State searchResults: number = 0;

  handleSearch() {
    if (this.searchText.trim().length === 0) {
      return;
    }

    // 添加到搜索历史
    if (!this.searchHistory.includes(this.searchText)) {
      this.searchHistory.unshift(this.searchText);
      if (this.searchHistory.length > 10) {
        this.searchHistory.pop();
      }
    }

    this.isSearching = true;
    // 模拟搜索结果数量
    this.searchResults = Math.floor(Math.random() * 100) + 20;
  }

  handleClear() {
    this.searchText = '';
    this.isSearching = false;
  }

  clearHistory() {
    this.searchHistory = [];
  }

  @Builder
  SearchHistoryBuilder() {
    Column() {
      // 搜索历史标题
      Row() {
        Text($r('app.string.search_history'))
          .fontSize(NORMAL_FONT_SIZE)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)

        Text($r('app.string.clear_history'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#999999')
          .onClick(() => {
            this.clearHistory();
          })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // 搜索历史列表
      if (this.searchHistory.length > 0) {
        List() {
          ForEach(this.searchHistory, (item: string) => {
            ListItem() {
              Row() {
                Image($r('app.media.ic_history'))
                  .width(20)
                  .height(20)

                Text(item)
                  .fontSize(NORMAL_FONT_SIZE)
                  .fontColor('#666666')
                  .margin({ left: 12 })
                  .layoutWeight(1)

                Image($r('app.media.ic_arrow_right'))
                  .width(16)
                  .height(16)
              }
              .width(LAYOUT_WIDTH_OR_HEIGHT)
              .height(48)
              .padding({ left: 16, right: 16 })
              .onClick(() => {
                this.searchText = item;
                this.handleSearch();
              })
            }
          })
        }
        .divider({ strokeWidth: 1, color: '#F0F0F0' })
      } else {
        Text($r('app.string.no_search_history'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#999999')
          .margin({ top: 24 })
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#FFFFFF')
    .margin({ top: 8 })
  }

  @Builder
  HotSearchBuilder() {
    Column() {
      // 热门搜索标题
      Text($r('app.string.hot_search'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // 热门搜索标签
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.hotSearchList, (item: string) => {
          Text(item)
            .fontSize(SMALL_FONT_SIZE)
            .fontColor('#666666')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .backgroundColor('#F5F5F5')
            .borderRadius(16)
            .margin({ right: 8, bottom: 8 })
            .onClick(() => {
              this.searchText = item;
              this.handleSearch();
            })
        })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .padding({ left: 16, right: 16, bottom: 16 })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#FFFFFF')
    .margin({ top: 8 })
  }

  @Builder
  SearchResultBuilder() {
    Column() {
      // 搜索结果提示
      Row() {
        Text($r('app.string.search_result_prefix'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')

        Text(this.searchResults.toString())
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#FF4D4F')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.search_result_suffix'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(NAV_BAR_HEIGHT)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F5F5F5')

      // 搜索结果列表
      GoodsList()
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .layoutWeight(1)
  }

  build() {
    Column() {
      // 顶部搜索栏
      Row() {
        SearchBar({
          searchText: $searchText,
          onSearchClick: () => {
            this.handleSearch();
          },
          onClearClick: () => {
            this.handleClear();
          }
        })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(NAV_BAR_HEIGHT)
      .padding({ left: 8, right: 8 })
      .backgroundColor('#FFFFFF')

      // 内容区域
      if (this.isSearching) {
        // 显示搜索结果
        this.SearchResultBuilder()
      } else {
        // 显示搜索历史和热门搜索
        Scroll() {
          Column() {
            this.SearchHistoryBuilder()
            this.HotSearchBuilder()
          }
          .width(LAYOUT_WIDTH_OR_HEIGHT)
        }
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .layoutWeight(1)
        .backgroundColor('#F5F5F5')
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#F5F5F5')
  }
}