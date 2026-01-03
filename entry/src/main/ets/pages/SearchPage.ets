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
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';

@Component
export default struct SearchPage {
  @State @Watch('onSearchTextChanged') searchText: string = '';
  @State isSearching: boolean = false;
  @State showSuggestions: boolean = false;
  @State searchHistory: string[] = ['手机', '笔记本', '耳机', '键盘'];
  @State hotSearchList: string[] = ['华为手机', '苹果手机', '小米手机', '蓝牙耳机', '机械键盘'];
  @State suggestions: string[] = [];
  @State searchResults: number = 0;

  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;

  private suggestionLibrary: string[] = [
    '华为 Mate 60', '华为 P60', '华为 平板', '华为 FreeBuds',
    '苹果 iPhone 15', '苹果 MacBook Pro', '小米 14 Ultra',
    '机械键盘 蓝牙双模', '入耳式耳机', '无线鼠标'
  ];

  onSearchTextChanged() {
    const query = this.searchText.trim();
    if (query.length > 0) {
      this.suggestions = this.suggestionLibrary.filter(item =>
      item.toLowerCase().includes(query.toLowerCase())
      );
      this.isSearching = false;
      this.showSuggestions = true;
    } else {
      this.showSuggestions = false;
      this.suggestions = [];
      this.isSearching = false;
    }
  }

  handleSearch(fixedText?: string) {
    let target = (fixedText !== undefined) ? fixedText : this.searchText;
    const query = target.trim();

    if (query.length === 0) return;

    this.searchText = query;

    // 模拟真实过滤统计
    const matched = this.suggestionLibrary.filter(item =>
    item.toLowerCase().includes(query.toLowerCase())
    );
    this.searchResults = matched.length;

    // 历史记录逻辑
    if (!this.searchHistory.includes(query)) {
      this.searchHistory.unshift(query);
      if (this.searchHistory.length > 10) this.searchHistory.pop();
    }

    this.isSearching = true;
    this.showSuggestions = false;
  }

  handleClear() {
    this.searchText = '';
    this.isSearching = false;
    this.showSuggestions = false;
    this.suggestions = [];
    this.searchResults = 0;
  }

  deleteHistoryItem(index: number) {
    this.searchHistory.splice(index, 1);
  }

  @Builder
  SuggestionListBuilder() {
    List() {
      ForEach(this.suggestions, (item: string) => {
        ListItem() {
          Row() {
            Image($r('app.media.ic_search_gray'))
              .width(18).height(18).margin({ right: 12 })
              .fillColor(this.currentThemeColors.secondaryTextColor)

            Text() {
              if (item.toLowerCase().includes(this.searchText.toLowerCase())) {
                Span(item.substring(0, item.toLowerCase().indexOf(this.searchText.toLowerCase())))
                Span(item.substring(
                  item.toLowerCase().indexOf(this.searchText.toLowerCase()),
                  item.toLowerCase().indexOf(this.searchText.toLowerCase()) + this.searchText.length
                ))
                  .fontColor(this.currentThemeColors.accentColor)
                  .fontWeight(FontWeight.Bold)
                Span(item.substring(item.toLowerCase().indexOf(this.searchText.toLowerCase()) + this.searchText.length))
              } else {
                Span(item)
              }
            }
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)
            .layoutWeight(1)

            Image($r('app.media.ic_arrow_left_top'))
              .width(14).height(14).opacity(0.3)
          }
          .width(LAYOUT_WIDTH_OR_HEIGHT)
          .height(52)
          .padding({ left: 16, right: 16 })
          .onClick(() => {
            this.handleSearch(item);
          })
        }
      }, (item: string) => item)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor(this.currentThemeColors.backgroundColor)
    .divider({ strokeWidth: 0.5, color: this.currentThemeColors.dividerColor, startMargin: 46 })
  }

  @Builder
  SearchHistoryBuilder() {
    Column() {
      Row() {
        Text($r('app.string.search_history'))
          .fontSize(NORMAL_FONT_SIZE).fontWeight(FontWeight.Bold)
          .fontColor(this.currentThemeColors.primaryTextColor).layoutWeight(1)

        Text($r('app.string.clear_history'))
          .fontSize(SMALL_FONT_SIZE).fontColor(this.currentThemeColors.secondaryTextColor)
          .onClick(() => { this.searchHistory = []; })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      if (this.searchHistory.length > 0) {
        List() {
          ForEach(this.searchHistory, (item: string, index: number) => {
            ListItem() {
              Row() {
                Image($r('app.media.ic_history')).width(20).height(20)

                Text(item)
                  .fontSize(NORMAL_FONT_SIZE).fontColor(this.currentThemeColors.primaryTextColor)
                  .margin({ left: 12 }).layoutWeight(1)

                // 按钮区域：通过 hitTestBehavior 拦截点击事件，防止触发外层 Row 的 onClick
                Row() {
                  Image($r('app.media.ic_search_cancel'))
                    .width(20).height(20)
                    .fillColor(this.currentThemeColors.secondaryTextColor)
                    .opacity(0.5)
                }
                .padding(8)
                .hitTestBehavior(HitTestMode.Block) // 拦截命中测试
                .onClick(() => {
                  this.deleteHistoryItem(index);
                })
              }
              .width(LAYOUT_WIDTH_OR_HEIGHT)
              .height(48)
              .padding({ left: 16, right: 16 })
              .onClick(() => {
                this.handleSearch(item);
              })
            }
          }, (item: string, index: number) => item + index) // 修正点：显式声明 index 参数
        }
        .divider({ strokeWidth: 1, color: this.currentThemeColors.dividerColor })
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor(this.currentThemeColors.backgroundColor).margin({ top: 8 })
  }

  @Builder
  HotSearchBuilder() {
    Column() {
      Text($r('app.string.hot_search'))
        .fontSize(NORMAL_FONT_SIZE).fontWeight(FontWeight.Bold)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .width(LAYOUT_WIDTH_OR_HEIGHT).padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.hotSearchList, (item: string) => {
          Text(item)
            .fontSize(SMALL_FONT_SIZE).fontColor(this.currentThemeColors.secondaryTextColor)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .backgroundColor(this.currentThemeColors.backgroundColor)
            .borderRadius(16).margin({ right: 8, bottom: 8 })
            .onClick(() => { this.handleSearch(item); })
        }, (item: string) => item)
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT).padding({ left: 16, right: 16, bottom: 16 })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor(this.currentThemeColors.cardBackgroundColor).margin({ top: 8 })
  }

  @Builder
  SearchResultBuilder() {
    Column() {
      Row() {
        Text($r('app.string.search_result_prefix'))
          .fontSize(SMALL_FONT_SIZE).fontColor(this.currentThemeColors.secondaryTextColor)
        Text(this.searchResults.toString())
          .fontSize(SMALL_FONT_SIZE).fontColor(this.currentThemeColors.accentColor)
          .fontWeight(FontWeight.Bold).margin({ left: 4, right: 4 })
        Text($r('app.string.search_result_suffix'))
          .fontSize(SMALL_FONT_SIZE).fontColor(this.currentThemeColors.secondaryTextColor)
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT).height(NAV_BAR_HEIGHT)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.currentThemeColors.backgroundColor)

      GoodsList()
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT).layoutWeight(1)
  }

  build() {
    Column() {
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
      .width(LAYOUT_WIDTH_OR_HEIGHT).height(NAV_BAR_HEIGHT)
      .padding({ left: 8, right: 8 })
      .backgroundColor(this.currentThemeColors.cardBackgroundColor)

      if (this.isSearching) {
        this.SearchResultBuilder()
      } else if (this.showSuggestions && this.suggestions.length > 0) {
        this.SuggestionListBuilder()
      } else {
        Scroll() {
          Column() {
            this.SearchHistoryBuilder()
            this.HotSearchBuilder()
          }
          .width(LAYOUT_WIDTH_OR_HEIGHT)
        }
        .width(LAYOUT_WIDTH_OR_HEIGHT).layoutWeight(1)
        .backgroundColor(this.currentThemeColors.cardBackgroundColor)
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT).height('100%')
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
  }
}