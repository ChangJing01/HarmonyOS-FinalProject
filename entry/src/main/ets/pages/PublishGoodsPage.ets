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
  BIGGER_FONT_SIZE
} from '../common/CommonConstants';
import { GoodsListItemType } from '../viewmodel/InitialData';
import { ListDataSource } from '../viewmodel/ListDataSource';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';
import router from '@ohos.router';
@Entry
@Component
export default struct PublishGoodsPage {
  @State goodsName: string = '';
  @State goodsDescription: string = '';
  @State goodsPrice: string = '';
  @State goodsImage: Resource = $r('app.media.goodsImg'); // 默认图片
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;

  private dataSource: ListDataSource = ListDataSource.getInstance();

  build() {
    Scroll() {
      Column({ space: 16 }) {
        // 标题
        Text($r('app.string.publish_goods'))
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 16 })

        // 商品名称
        Column({ space: 8 }) {
          Text('商品名称')
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)
          TextInput({ placeholder: '请输入商品名称', text: this.goodsName })
            .width(LAYOUT_WIDTH_OR_HEIGHT)
            .height(48)
            .backgroundColor(this.currentThemeColors.cardBackgroundColor)
            .borderRadius(8)
            .padding(8)
            .onChange((value: string) => {
              this.goodsName = value;
            })
        }

        // 商品描述
        Column({ space: 8 }) {
          Text('商品描述')
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)
          TextInput({ placeholder: '请输入商品描述', text: this.goodsDescription })
            .width(LAYOUT_WIDTH_OR_HEIGHT)
            .height(80)
            .backgroundColor(this.currentThemeColors.cardBackgroundColor)
            .borderRadius(8)
            .padding(8)
            .onChange((value: string) => {
              this.goodsDescription = value;
            })
        }

        // 商品价格
        Column({ space: 8 }) {
          Text('商品价格')
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)
          TextInput({ placeholder: '请输入商品价格', text: this.goodsPrice })
            .width(LAYOUT_WIDTH_OR_HEIGHT)
            .height(48)
            .backgroundColor(this.currentThemeColors.cardBackgroundColor)
            .borderRadius(8)
            .padding(8)
            .type(InputType.Number)
            .onChange((value: string) => {
              this.goodsPrice = value;
            })
        }

        // 商品图片（可选）
        Column({ space: 8 }) {
          Text('商品图片 (可选)')
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)
          Row({ space: 16 }) {
            Image(this.goodsImage)
              .width(100)
              .height(100)
              .borderRadius(8)
            Button('选择图片')
              .fontSize(NORMAL_FONT_SIZE)
              .backgroundColor(this.currentThemeColors.accentColor)
              .fontColor(Color.White)
              .borderRadius(8)
              .onClick(() => {
                // 选择图片逻辑（暂时使用默认图片）
                // 这里可以集成图片选择器
              })
          }
        }

        // 发布按钮
        Button('发布商品')
          .fontSize(NORMAL_FONT_SIZE)
          .backgroundColor(this.currentThemeColors.accentColor)
          .fontColor(Color.White)
          .width(LAYOUT_WIDTH_OR_HEIGHT)
          .height(48)
          .borderRadius(8)
          .margin({ top: 32 })
          .onClick(() => {
            this.publishGoods();
          })

        // 返回按钮
        Button('返回')
          .fontSize(NORMAL_FONT_SIZE)
          .backgroundColor(this.currentThemeColors.cardBackgroundColor)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .width(LAYOUT_WIDTH_OR_HEIGHT)
          .height(48)
          .borderRadius(8)
          .onClick(() => {
            router.back();
          })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .padding(16)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor(this.currentThemeColors.backgroundColor)
  }

  private publishGoods(): void {
    if (this.goodsName.trim() === '' || this.goodsPrice.trim() === '') {
      // 显示错误提示
      return;
    }

    const newItem = new GoodsListItemType(
      Date.now(),
      this.goodsImage,
      this.goodsName,
      this.goodsPrice
    );
    newItem.advertisingLanguage = this.goodsDescription || '暂无描述';
    newItem.evaluate = '新发布';

    this.dataSource.addNewItem(newItem);

    // 返回上一页
    router.back();
  }
}