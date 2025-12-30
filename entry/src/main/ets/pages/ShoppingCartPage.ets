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
import router from '@ohos.router';
import { BusinessError } from '@ohos.base';

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
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;

  // 1. 核心计算方法：计算总价并检查全选状态
  updateDataState() {
    let total = 0;
    let selectedCount = 0;

    this.cartItems.forEach(item => {
      if (item.selected) {
        const price = parseFloat(item.price.replace('¥', ''));
        total += price * item.quantity;
        selectedCount++;
      }
    });

    this.totalPrice = total;
    // 只有列表不为空且选中数量等于列表长度时，才是全选
    this.isAllSelected = (this.cartItems.length > 0 && selectedCount === this.cartItems.length);
  }

  // 获取当前选中数量
  getSelectedCount(): number {
    return this.cartItems.filter(item => item.selected).length;
  }

  // 切换全选
  toggleSelectAll(checked: boolean) {
    this.isAllSelected = checked;
    this.cartItems = this.cartItems.map(item => {
      item.selected = checked;
      return item;
    });
    this.updateDataState();
  }

  // 切换单选
  toggleItemSelect(index: number, checked: boolean) {
    this.cartItems[index].selected = checked;
    this.cartItems = [...this.cartItems]; // 强制ArkUI刷新视图
    this.updateDataState();
  }

  // 修改数量
  updateQuantity(index: number, delta: number) {
    const newQuantity = this.cartItems[index].quantity + delta;
    if (newQuantity >= 1 && newQuantity <= 99) {
      this.cartItems[index].quantity = newQuantity;
      this.cartItems = [...this.cartItems];
      this.updateDataState();
    }
  }

  // 删除选中项
  deleteSelectedItems() {
    this.cartItems = this.cartItems.filter(item => !item.selected);
    this.updateDataState();
  }

  // 一键清空购物车
  clearCart() {
    this.cartItems = [];
    this.updateDataState();
  }

  @Builder
  PageHeader() {
    Row() {
      Text('购物车')
        .fontSize(BIGGER_FONT_SIZE)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentThemeColors.primaryTextColor)

      if (this.cartItems.length > 0) {
        Text('全部清空')
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#FF4D4F') // 使用红色提示风险
          .onClick(() => this.clearCart())
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
  }

  @Builder
  CartItemBuilder(item: CartItem, index: number) {
    Row({ space: 12 }) {
      Checkbox()
        .select(item.selected)
        .selectedColor(this.currentThemeColors.accentColor)
        .onChange((value: boolean) => {
          this.toggleItemSelect(index, value);
        })

      Image(item.image)
        .width(80).height(80)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)

      Column({ space: 8 }) {
        Text(item.name)
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .maxLines(1)

        Text(item.price)
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor(this.currentThemeColors.accentColor)
          .fontWeight(FontWeight.Bold)

        Row() {
          Blank()
          Row({ space: 8 }) {
            Button('-')
              .width(28).height(28)
              .backgroundColor(item.quantity <= 1 ? '#F5F5F5' : this.currentThemeColors.accentColor)
              .fontColor(item.quantity <= 1 ? '#CCCCCC' : '#FFFFFF')
              .onClick(() => this.updateQuantity(index, -1))
              .enabled(item.quantity > 1)

            Text(item.quantity.toString()).fontSize(NORMAL_FONT_SIZE).width(30).textAlign(TextAlign.Center)

            Button('+')
              .width(28).height(28)
              .backgroundColor(this.currentThemeColors.accentColor)
              .fontColor('#FFFFFF')
              .onClick(() => this.updateQuantity(index, 1))
          }
        }.width('100%')
      }.alignItems(HorizontalAlign.Start).layoutWeight(1)
    }
    .width('100%').padding(12).backgroundColor('#FFFFFF').borderRadius(12)
  }

  @Builder
  EmptyCartBuilder() {
    Column({ space: 20 }) {
      Circle().width(100).height(100).fill('#F0F0F0')
      Text('购物车为空，去逛逛吧').fontSize(NORMAL_FONT_SIZE).fontColor('#999999')
      Button('去首页')
        .width(150).height(BUTTON_HEIGHT).backgroundColor(this.currentThemeColors.accentColor)
        .onClick(() => {
          router.replaceUrl({ url: 'pages/ListIndex' })
            .catch((err: BusinessError) => console.error(`跳转失败:${err.code}`))
        })
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      // 左侧：全选控制
      Row({ space: 4 }) {
        Checkbox()
          .select(this.isAllSelected)
          .selectedColor(this.currentThemeColors.accentColor)
          .onChange((value: boolean) => this.toggleSelectAll(value))
        Text('全选').fontSize(SMALL_FONT_SIZE)
      }

      Blank()

      // 右侧：功能区
      Row({ space: 12 }) {
        // 如果有商品选中，显示删除按钮，但不隐藏总价
        if (this.getSelectedCount() > 0) {
          Text('删除选中')
            .fontSize(SMALL_FONT_SIZE)
            .fontColor('#FF4D4F')
            .fontWeight(FontWeight.Medium)
            .onClick(() => this.deleteSelectedItems())
        }

        // 始终保留合计和结算部分
        Column() {
          Row() {
            Text('合计:').fontSize(SMALL_FONT_SIZE)
            Text('¥' + this.totalPrice.toFixed(2))
              .fontSize(NORMAL_FONT_SIZE)
              .fontColor(this.currentThemeColors.accentColor)
              .fontWeight(FontWeight.Bold)
          }
        }.alignItems(HorizontalAlign.End)

        Button('结算')
          .backgroundColor(this.getSelectedCount() > 0 ? this.currentThemeColors.accentColor : '#CCCCCC')
          .height(40)
          .width(80)
          .borderRadius(20)
          .fontSize(SMALL_FONT_SIZE)
          .enabled(this.getSelectedCount() > 0)
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
    .height(72)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 10, color: '#10000000', offsetY: -2 })
  }

  build() {
    Column() {
      this.PageHeader()

      if (this.cartItems.length === 0) {
        this.EmptyCartBuilder()
      } else {
        List({ space: 10 }) {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            ListItem() {
              this.CartItemBuilder(item, index)
            }
          }, (item: CartItem) => item.id.toString() + item.selected + item.quantity)
          // Key中包含selected和quantity，确保状态改变时，Checkbox和数量文字能精准刷新
        }
        .layoutWeight(1)
        .padding(10)

        this.BottomBar()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}