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

import router from '@ohos.router';
import {
  LAYOUT_WIDTH_OR_HEIGHT,
  NORMAL_FONT_SIZE,
  BIGGER_FONT_SIZE,
  MAX_FONT_SIZE,
  SMALL_FONT_SIZE,
  NAV_BAR_HEIGHT,
  BUTTON_HEIGHT,
  BUTTON_BORDER_RADIUS
} from '../common/CommonConstants';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';

@Entry
@Component
export default struct GoodsDetailPage {
  @State goodsName: string = (router.getParams() as Record<string, Object>)['goodsName'] as string;
  @State goodsPrice: string = (router.getParams() as Record<string, Object>)['goodsPrice'] as string;
  @State originalPrice: string = '¥299';
  @State salesCount: string = '6662人已购买';
  @State rating: string = '95%好评';
  @State selectedQuantity: number = 1;
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;//使用 @StorageLink 确保当 PersonalPage 改变主题时，这里会自动刷新


  @Builder
  TopNavigationBar() {
    Row() {
      // Image($r('app.media.ic_back'))
      //   .width(24)
      //   .height(24)
      //   .onClick(() => {
      //     // 返回上一页
      //   })
      // 返回按钮
      Text('←')
        .fontSize(24)
        .fontColor(this.currentThemeColors.primaryTextColor)   //'#333333'
        .onClick(() => {
          router.back();
        })

      Text($r('app.string.goods_detail'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // Image($r('app.media.ic_share'))
      //   .width(24)
      //   .height(24)
      // 分享按钮
      Text('⋯')
        .fontSize(24)
        .fontColor(this.currentThemeColors.primaryTextColor)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(NAV_BAR_HEIGHT)
    .padding({ left: 16, right: 16 })
    .backgroundColor(this.currentThemeColors.backgroundColor)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  GoodsImageSwiper() {
    Swiper() {
      Image($r('app.media.goodsImg'))
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .height(400)
        .objectFit(ImageFit.Cover)

      Image($r('app.media.goodsImg_2'))
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .height(400)
        .objectFit(ImageFit.Cover)

      Image($r('app.media.goodsImg_3'))
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .height(400)
        .objectFit(ImageFit.Cover)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(400)
    .autoPlay(true)
    .interval(3000)
    .indicator(true)
    .loop(true)
  }

  @Builder
  GoodsInfoSection() {
    Column({ space: 12 }) {
      // 价格
      Row({ space: 8 }) {
        Text(this.goodsPrice)
          .fontSize(MAX_FONT_SIZE)
          .fontColor(this.currentThemeColors.accentColor)
          .fontWeight(FontWeight.Bold)

        Text(this.originalPrice)
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor(this.currentThemeColors.secondaryTextColor)
          .decoration({ type: TextDecorationType.LineThrough })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .alignItems(VerticalAlign.Bottom)

      // 商品名称
      Text(this.goodsName)
        .fontSize(BIGGER_FONT_SIZE)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .fontWeight(FontWeight.Bold)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width(LAYOUT_WIDTH_OR_HEIGHT)

      // 销量和评价
      Row({ space: 16 }) {
        Text(this.salesCount)
          .fontSize(SMALL_FONT_SIZE)
          .fontColor(this.currentThemeColors.secondaryTextColor)

        Text(this.rating)
          .fontSize(SMALL_FONT_SIZE)
          .fontColor(this.currentThemeColors.secondaryTextColor)
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding(16)
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .borderRadius(8)
  }

  @Builder
  QuantitySelector() {
    Column() {
      Row() {
        Text($r('app.string.quantity'))
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .layoutWeight(1)

        Row({ space: 12 }) {
          Button('-')
            .width(32)
            .height(32)
            .fontSize(BIGGER_FONT_SIZE)
            .backgroundColor(this.selectedQuantity <= 1 ? this.currentThemeColors.tabUnselectedColor : this.currentThemeColors.tabSelectedColor)
            .fontColor(this.selectedQuantity <= 1 ? this.currentThemeColors.secondaryTextColor : this.currentThemeColors.cardBackgroundColor)
            .enabled(this.selectedQuantity > 1)
            .onClick(() => {
              if (this.selectedQuantity > 1) {
                this.selectedQuantity--;
              }
            })

          Text(this.selectedQuantity.toString())
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)
            .width(40)
            .textAlign(TextAlign.Center)

          Button('+')
            .width(32)
            .height(32)
            .fontSize(BIGGER_FONT_SIZE)
            .backgroundColor(this.currentThemeColors.accentColor)
            .fontColor(this.currentThemeColors.cardBackgroundColor)
            .onClick(() => {
              if (this.selectedQuantity < 99) {
                this.selectedQuantity++;
              }
            })
        }
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(56)
      .alignItems(VerticalAlign.Center)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding({ left: 16, right: 16 })
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .borderRadius(8)
    .margin({ top: 8 })
  }

  @Builder
  GoodsDescription() {
    Column({ space: 12 }) {
      Text($r('app.string.goods_description'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .width(LAYOUT_WIDTH_OR_HEIGHT)

      Text($r('app.string.advertising_language'))
        .fontSize(SMALL_FONT_SIZE)
        .fontColor(this.currentThemeColors.secondaryTextColor)
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .lineHeight(24)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding(16)
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .borderRadius(8)
    .margin({ top: 8 })
  }

  @Builder
  BottomActionBar() {
    Row({ space: 12 }) {
      Column({ space: 4 }) {
        // Image($r('app.media.ic_favorite'))
        //   .width(24)
        //   .height(24)
        // 收藏图标
        Text('♡')
          .fontSize(20)
          .fontColor(this.currentThemeColors.secondaryTextColor)

        Text($r('app.string.favorite'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor(this.currentThemeColors.secondaryTextColor)
      }
      .onClick(() => {
        // 收藏逻辑
      })

      Button($r('app.string.add_to_cart'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor(this.currentThemeColors.cardBackgroundColor)
        .backgroundColor('#FF9800')
        .height(BUTTON_HEIGHT)
        .borderRadius(BUTTON_BORDER_RADIUS)
        .layoutWeight(1)
        .onClick(() => {
          // 加入购物车逻辑
        })

      Button($r('app.string.buy_now'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor(this.currentThemeColors.cardBackgroundColor)
        .backgroundColor(this.currentThemeColors.accentColor)
        .height(BUTTON_HEIGHT)
        .borderRadius(BUTTON_BORDER_RADIUS)
        .layoutWeight(1)
        .onClick(() => {
          // 立即购买逻辑
        })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(72)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .shadow({
      radius: 8,
      color: '#00000015',
      offsetY: -2
    })
  }

  build() {
    Column() {
      // 顶部导航栏
      this.TopNavigationBar()

      // 可滚动内容区域
      Scroll() {
        Column() {
          // 商品图片轮播
          this.GoodsImageSwiper()

          // 商品信息
          this.GoodsInfoSection()

          // 数量选择器
          this.QuantitySelector()

          // 商品描述
          this.GoodsDescription()
        }
        .width(LAYOUT_WIDTH_OR_HEIGHT)
      }
      .layoutWeight(1)
      .backgroundColor(this.currentThemeColors.backgroundColor)

      // 底部操作栏
      this.BottomActionBar()
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor(this.currentThemeColors.backgroundColor)
    .padding({top : 34})
  }
}