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

import * as commonConst from '../common/CommonConstants';
import { GoodsListItemType } from '../viewmodel/InitialData';
import { ListDataSource } from '../viewmodel/ListDataSource';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';
import router from '@ohos.router'; // 引入路由模块
import promptAction from '@ohos.promptAction';

@Component
export default struct GoodsList {
  // 👇 1. 链接全局对比列表，初始化为空数组
  @StorageLink('compareList') compareList: GoodsListItemType[] = [];
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;

  @Provide goodsListData: ListDataSource = new ListDataSource();
  private startTouchOffsetY: number = 0;
  private endTouchOffsetY: number = 0;

  // 判断商品是否已在对比列表中
  isInCompareList(item: GoodsListItemType): boolean {
    return this.compareList.some(compareItem => compareItem.id === item.id);
  }

  // 处理对比点击
  handleCompare(item: GoodsListItemType) {
    if (this.isInCompareList(item)) {
      // 如果已存在，则移除
      this.compareList = this.compareList.filter(compareItem => compareItem.id !== item.id);
    } else {
      // 如果不存在，判断是否超过限制 (比如最多2个)
      if (this.compareList.length >= 2) {
        promptAction.showToast({ message: '最多同时对比两个商品' });
        return;
      }
      // 加入对比
      this.compareList.push(item);
      promptAction.showToast({ message: '已加入对比' });
    }
  }


  build() {
    Stack({ alignContent: Alignment.BottomEnd }) { // 使用 Stack 以便放置悬浮按钮
      Row() {
        List({ space: commonConst.LIST_ITEM_SPACE }) {
          LazyForEach(this.goodsListData, (item: GoodsListItemType) => {
            ListItem() {
              Row() {
                // ... 原有的图片 Column ...
                Column() {
                  Image(item?.goodsImg)
                    .width(commonConst.LAYOUT_WIDTH_OR_HEIGHT)
                    .height(commonConst.LAYOUT_WIDTH_OR_HEIGHT)
                    .draggable(false)
                }
                .width(commonConst.GOODS_IMAGE_WIDTH)
                .height(commonConst.LAYOUT_WIDTH_OR_HEIGHT)

                Column() {
                  Text(item?.goodsName)
                    .fontSize(commonConst.NORMAL_FONT_SIZE)
                    .fontColor(this.currentThemeColors.primaryTextColor)

                  Text(item?.advertisingLanguage)
                    .fontColor(this.currentThemeColors.primaryTextColor)
                    .fontSize(commonConst.GOODS_EVALUATE_FONT_SIZE)
                    .margin({ right: commonConst.MARGIN_RIGHT })

                  Row() {
                    // 价格和评价
                    Column() {
                      Text(item?.evaluate)
                        .fontSize(commonConst.GOODS_EVALUATE_FONT_SIZE)
                        .fontColor(this.currentThemeColors.accentColor)
                      Text(item?.price)
                        .fontSize(commonConst.NORMAL_FONT_SIZE)
                        .fontColor(this.currentThemeColors.accentColor)
                    }
                    .alignItems(HorizontalAlign.Start)

                    // 👇 2. 新增：对比图标/按钮
                    Image(this.isInCompareList(item) ? $r('app.media.ic_compare_selected') : $r('app.media.ic_compare_unselected')) // 确保你有这个图标，或者用其他图标代替
                      .width(24)
                      .height(24)
                      .gesture(
                        TapGesture()
                          .onAction(() => {
                            // TapGesture 默认会消费事件，通常不会冒泡给父组件的 onClick
                            this.handleCompare(item);
                          })
                      )
                  }
                  .justifyContent(FlexAlign.SpaceBetween) // 改为两端对齐
                  .width('100%') // 占满宽度
                }
                .padding(commonConst.GOODS_LIST_PADDING)
                .width(commonConst.GOODS_FONT_WIDTH)
                .height(commonConst.LAYOUT_WIDTH_OR_HEIGHT)
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .justifyContent(FlexAlign.SpaceBetween)
              .height(commonConst.GOODS_LIST_HEIGHT)
              .width(commonConst.LAYOUT_WIDTH_OR_HEIGHT)
            }
            .onClick(() => {
              router.pushUrl({
                url: 'pages/GoodsDetailPage',
                params: {
                  goodsId: item.id,
                  goodsName: item.goodsName,
                  goodsPrice: item.price,
                  goodsImg: item.goodsImg
                }
              })
            })
          })
        }
        .width(commonConst.GOODS_LIST_WIDTH)
        .divider({ strokeWidth: 1, color: this.currentThemeColors.dividerColor })
      }
      .justifyContent(FlexAlign.Center)
      .width(commonConst.LAYOUT_WIDTH_OR_HEIGHT)

      // 👇 3. 新增：进入对比页面的悬浮入口
      if (this.compareList.length > 0) {
        Button(`开始对比 (${this.compareList.length})`)
          .backgroundColor(this.currentThemeColors.accentColor)
          .fontColor(Color.White)
          .margin({ bottom: 80, right: 20 }) // 调整位置
          .onClick(() => {
            if (this.compareList.length < 2) {
              promptAction.showToast({ message: '请至少选择两个商品进行对比' });
              return;
            }
            router.pushUrl({ url: 'pages/ComparisonPage' });
          })
      }
    }
    .width('100%')
    .height('100%')
  }
}