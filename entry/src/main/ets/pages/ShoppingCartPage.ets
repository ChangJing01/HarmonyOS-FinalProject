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
  BIGGER_FONT_SIZE,
  SMALL_FONT_SIZE,
  BUTTON_HEIGHT,
  BUTTON_BORDER_RADIUS
} from '../common/CommonConstants';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';

interface CartItem {
  id: number;
  name: Resource;
  price: string;
  quantity: number;
  image: Resource;
  selected: boolean;
}

@Component
export default struct ShoppingCartPage {
  @State cartItems: CartItem[] = [
    {
      id: 1,
      name: $r('app.string.goodsName'),
      price: '¥199',
      quantity: 1,
      image: $r('app.media.goodsImg'),
      selected: false
    },
    {
      id: 2,
      name: $r('app.string.another_goodsName'),
      price: '¥265',
      quantity: 2,
      image: $r('app.media.goodsImg_2'),
      selected: false
    }
  ];
  @State isAllSelected: boolean = false;
  @State totalPrice: number = 0;
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;//使用 @StorageLink 确保当 PersonalPage 改变主题时，这里会自动刷新

  calculateTotalPrice() {
    this.totalPrice = 0;
    this.cartItems.forEach(item => {
      if (item.selected) {
        const price = parseFloat(item.price.replace('¥', ''));
        this.totalPrice += price * item.quantity;
      }
    });
  }

  toggleSelectAll() {
    this.isAllSelected = !this.isAllSelected;
    this.cartItems.forEach(item => {
      item.selected = this.isAllSelected;
    });
    this.calculateTotalPrice();
  }

  toggleItemSelect(index: number) {
    this.cartItems[index].selected = !this.cartItems[index].selected;
    this.isAllSelected = this.cartItems.every(item => item.selected);
    this.calculateTotalPrice();
  }

  updateQuantity(index: number, delta: number) {
    const newQuantity = this.cartItems[index].quantity + delta;
    if (newQuantity >= 1 && newQuantity <= 99) {
      this.cartItems[index].quantity = newQuantity;
      this.calculateTotalPrice();
    }
  }

  deleteSelectedItems() {
    this.cartItems = this.cartItems.filter(item => !item.selected);
    this.isAllSelected = false;
    this.calculateTotalPrice();
  }

  @Builder
  CartItemBuilder(item: CartItem, index: number) {
    Row({ space: 12 }) {
      // 选择框
      Checkbox()
        .select(item.selected)
        .selectedColor(this.currentThemeColors.accentColor)
        .onChange((value: boolean) => {
          this.toggleItemSelect(index);
        })

      // 商品图片
      Image(item.image)
        .width(80)
        .height(80)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)

      // 商品信息
      Column({ space: 8 }) {
        Text(item.name)
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(item.price)
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor(this.currentThemeColors.accentColor)
          .fontWeight(FontWeight.Bold)

        // 数量选择器
        Row({ space: 8 }) {
          Button('-')
            .width(28)
            .height(28)
            .fontSize(NORMAL_FONT_SIZE)
            .backgroundColor(item.quantity <= 1 ? this.currentThemeColors.tabUnselectedColor : this.currentThemeColors.accentColor)
            .fontColor(item.quantity <= 1 ? this.currentThemeColors.secondaryTextColor : this.currentThemeColors.accentColor)
            .enabled(item.quantity > 1)
            .onClick(() => {
              this.updateQuantity(index, -1);
            })

          Text(item.quantity.toString())
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)
            .width(32)
            .textAlign(TextAlign.Center)

          Button('+')
            .width(28)
            .height(28)
            .fontSize(NORMAL_FONT_SIZE)
            .backgroundColor(this.currentThemeColors.accentColor)
            .fontColor(this.currentThemeColors.primaryTextColor)
            .onClick(() => {
              this.updateQuantity(index, 1);
            })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding(12)
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .borderRadius(8)
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  EmptyCartBuilder() {
    Column({ space: 16 }) {
      // Image($r('app.media.ic_empty_cart'))
      //   .width(120)
      //   .height(120)
      // 空购物车图标
      Circle()
        .width(120)
        .height(120)
        .fill('#E0E0E0')

      Text($r('app.string.empty_cart'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor('#999999')

      Button($r('app.string.go_shopping'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor('#FFFFFF')
        .backgroundColor(this.currentThemeColors.accentColor)
        .height(BUTTON_HEIGHT)
        .borderRadius(BUTTON_BORDER_RADIUS)
        .width(200)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  BottomBar() {
    Row({ space: 12 }) {
      // 全选
      Row({ space: 8 }) {
        Checkbox()
          .select(this.isAllSelected)
          .selectedColor(this.currentThemeColors.accentColor)
          .onChange(() => {
            this.toggleSelectAll();
          })

        Text($r('app.string.select_all'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor(this.currentThemeColors.primaryTextColor)
      }

      // 总价
      Column({ space: 4 }) {
        Row({ space: 4 }) {
          Text($r('app.string.total'))
            .fontSize(SMALL_FONT_SIZE)
            .fontColor(this.currentThemeColors.secondaryTextColor)

          Text('¥' + this.totalPrice.toFixed(2))
            .fontSize(BIGGER_FONT_SIZE)
            .fontColor(this.currentThemeColors.accentColor)
            .fontWeight(FontWeight.Bold)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.End)

      // 结算按钮
      Button($r('app.string.checkout'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor('#FFFFFF')
        .backgroundColor(this.currentThemeColors.accentColor)
        .height(BUTTON_HEIGHT)
        .borderRadius(BUTTON_BORDER_RADIUS)
        .width(120)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(72)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .shadow({
      radius: 8,
      color: '#00000015', //'#00000015'
      offsetY: -2
    })
  }

  build() {
    Column() {
      if (this.cartItems.length === 0) {
        this.EmptyCartBuilder()
      } else {
        // 购物车列表
        List({ space: 8 }) {
          ForEach(this.cartItems, (item: CartItem, index?: number) => {
            ListItem() {
              this.CartItemBuilder(item, index !== undefined ? index : 0)
            }
          })
        }
        .layoutWeight(1)
        .padding(8)
        .backgroundColor(this.currentThemeColors.backgroundColor)

        // 底部操作栏
        this.BottomBar()
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor(this.currentThemeColors.backgroundColor)
  }
}