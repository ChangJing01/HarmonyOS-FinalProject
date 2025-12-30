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
  @Provide goodsListData: ListDataSource = new ListDataSource();
  private startTouchOffsetY: number = 0;
  private endTouchOffsetY: number = 0;

  build() {
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
            // 使用 router.pushUrl 跳转到详情页
            router.pushUrl({
              url: 'pages/GoodsDetailPage', // 目标页面的路径
              params: {
                goodsId: item.id, // 传递参数：将当前点击商品的 ID 传过去
                goodsName: item.goodsName,
                goodsPrice: item.price,
                goodsImg: item.goodsImg
              }
            })
          })
        })
      }
      .width(commonConst.GOODS_LIST_WIDTH)
      .divider({
        strokeWidth: 1, // 分割线粗细，单位 vp
        color: this.currentThemeColors.dividerColor, // 使用主题定义的分割线颜色
      })
    }
    .justifyContent(FlexAlign.Center)
    .width(commonConst.LAYOUT_WIDTH_OR_HEIGHT)
  }
}