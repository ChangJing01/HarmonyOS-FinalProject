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

@Component
export default struct GoodsList {
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;
  @Provide goodsListData: ListDataSource = ListDataSource.getInstance();
  @Prop layoutMode: 'list' | 'grid' = 'list'; // 添加布局模式属性
  private startTouchOffsetY: number = 0;
  private endTouchOffsetY: number = 0;

  private groupItems(data: ListDataSource): GoodsListItemType[][] {
    let rows: GoodsListItemType[][] = [];
    for (let i = 0; i < data.totalCount(); i += 2) {
      let row: GoodsListItemType[] = [];
      let item1 = data.getData(i);
      if (item1) row.push(item1);
      if (i + 1 < data.totalCount()) {
        let item2 = data.getData(i + 1);
        if (item2) row.push(item2);
      }
      if (row.length > 0) rows.push(row);
    }
    return rows;
  }

  @Builder
  GoodsItem(item: GoodsListItemType) {
    Column() {
      Image(item?.goodsImg)
        .width(140) // 网格布局中图片宽度调整为140
        .height(140) // 高度也调整为140
        .draggable(false)

      Text(item?.goodsName)
        .fontSize(commonConst.NORMAL_FONT_SIZE)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .margin({ top: 8 })

      Text(item?.advertisingLanguage)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .fontSize(commonConst.GOODS_EVALUATE_FONT_SIZE)
        .margin({ top: 4 })

      Row() {
        Text(item?.evaluate)
          .fontSize(commonConst.GOODS_EVALUATE_FONT_SIZE)
          .fontColor(this.currentThemeColors.accentColor)
        Text(item?.price)
          .fontSize(commonConst.NORMAL_FONT_SIZE)
          .fontColor(this.currentThemeColors.accentColor)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 4 })
    }
    .padding(8)
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .borderRadius(8)
    .width('48%') // 设置宽度为48%以适应两列布局
    .onClick(() => {
      router.pushUrl({
        url: 'pages/GoodsDetailPage',
        params: {
          goodsId: item.id,
          goodsName: item.goodsName,
          goodsPrice: item.price,
          goodsImg: item.goodsImg
        }
      });
    })
  }

  build() {
    if (this.layoutMode === 'list') {
      // 平铺布局（原有布局）
      Row() {
        List({ space: commonConst.LIST_ITEM_SPACE }) {
          LazyForEach(this.goodsListData, (item: GoodsListItemType) => {
            ListItem() {
              Row() {
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
                    Text(item?.evaluate)
                      .fontSize(commonConst.GOODS_EVALUATE_FONT_SIZE)
                      .fontColor(this.currentThemeColors.accentColor)
                      .width(commonConst.EVALUATE_WIDTH)
                    Text(item?.price).fontSize(commonConst.NORMAL_FONT_SIZE).fontColor(this.currentThemeColors.accentColor)
                  }
                  .justifyContent(FlexAlign.SpaceAround)
                  .width(commonConst.GOODS_LIST_WIDTH)
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
            .onTouch((event?: TouchEvent) => {
              if (event === undefined) {
                return;
              }
              switch (event.type) {
                case TouchType.Down:
                  this.startTouchOffsetY = event.touches[0].y;
                  break;
                case TouchType.Up:
                  this.startTouchOffsetY = event.touches[0].y;
                  break;
                case TouchType.Move:
                  if (this.startTouchOffsetY - this.endTouchOffsetY > 0) {
                    this.goodsListData.pushData();
                  }
                  break;
              }
            })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/GoodsDetailPage',
                params: {
                  goodsId: item.id,
                  goodsName: item.goodsName,
                  goodsPrice: item.price,
                  goodsImg: item.goodsImg
                }
              });
            })
          })
        }
        .width(commonConst.GOODS_LIST_WIDTH)
        .divider({
          strokeWidth: 1,
          color: this.currentThemeColors.dividerColor,
        })
      }
      .justifyContent(FlexAlign.Center)
      .width(commonConst.LAYOUT_WIDTH_OR_HEIGHT)
    } else {
      // 2列网格布局
      Column() {
        ForEach(this.groupItems(this.goodsListData), (row: GoodsListItemType[], index: number) => {
          Row({ space: 8 }) {
            this.GoodsItem(row[0])
            if (row.length > 1) {
              this.GoodsItem(row[1])
            } else {
              Blank()
            }
          }
          .padding({ left: 8, right: 8 })
        })
      }
      .width(commonConst.LAYOUT_WIDTH_OR_HEIGHT)
    }
  }
}