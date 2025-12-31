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

export interface CartItem {
  id: number;
  name: Resource;
  price: Resource;
  quantity: number;
  image: Resource;
  selected: boolean;
}

@Component
export default struct ShoppingCartPage {
  @StorageLink('isLoggedIn') isLoggedIn: boolean = false;
  @StorageLink('cartItems') @Watch('onCartChange') cartItems: CartItem[] = [
    {
      id: 1,
      name: $r('app.string.goodsName'),
      price: $r('app.string.price_199'),
      quantity: 1,
      image: $r('app.media.goodsImg'),
      selected: false
    },
    {
      id: 2,
      name: $r('app.string.another_goodsName'),
      price: $r('app.string.price_265'),
      quantity: 2,
      image: $r('app.media.goodsImg_2'),
      selected: false
    }
  ];
  @State isAllSelected: boolean = false;
  @State totalPrice: number = 0;
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;//使用 @StorageLink 确保当 PersonalPage 改变主题时，这里会自动刷新

  // 监听到变化后的处理函数
  onCartChange() {
    console.info('购物车数据发生变化，重新校验状态');
    // 1. 自动同步全选状态
    if (this.cartItems.length > 0) {
      this.isAllSelected = this.cartItems.every(item => item.selected);
    } else {
      this.isAllSelected = false;
    }
    // 2. 自动重新计算总价
    this.calculateTotalPrice();
  }

  // 组件加载时也运行一次
  aboutToAppear() {
    this.onCartChange();
  }

  // 添加商品
  // 此方法可以被外部调用（商品详情页）来向数组添加数据
  addItem(item: CartItem) {
    const index = this.cartItems.findIndex(i => i.id === item.id);
    if (index > -1) {
      // 如果商品已存在，增加数量
      this.cartItems[index].quantity += 1;
    } else {
      // 如果不存在，添加新项
      this.cartItems.push(item);
    }
    this.cartItems = [...this.cartItems]; // 触发 UI 刷新
    this.isAllSelected = this.cartItems.every(i => i.selected);
    this.calculateTotalPrice();
  }

  // 删除单个物品
  deleteItem(id: number) {
    this.cartItems = this.cartItems.filter(item => item.id !== id);
    // 删除后重新判断全选状态
    this.isAllSelected = this.cartItems.length > 0 ? this.cartItems.every(item => item.selected) : false;
    this.calculateTotalPrice();
  }

  // 确保每次计算都是基于最新状态
  calculateTotalPrice() {
    let total = 0;
    // 获取资源管理器
    const resManager = getContext(this).resourceManager;

    this.cartItems.forEach(item => {
      if (item.selected && item.price) {
        try {
          // 1. 将 Resource 对象转换为 string
          // getStringSync 是同步方法，可以直接在循环里用
          let priceStr: string = resManager.getStringSync(item.price);

          // 2. 清洗字符串，只保留数字和小数点（逻辑同前）
          const priceNum = parseFloat(priceStr.replace(/[^\d.]/g, ''));

          // 3. 累加总价
          if (!isNaN(priceNum)) {
            total += priceNum * item.quantity;
          }
        } catch (error) {
          console.error("资源解析失败，请检查 Resource 是否有效", error);
        }
      }
    });

    // 更新总价状态
    this.totalPrice = total;
  }

  // 全选逻辑
  toggleSelectAll(checked: boolean) {
    // 如果当前逻辑状态已经和传入的 checked 一致，说明是单选触发的状态回流，直接拦截，不执行批量操作
    if (this.isAllSelected === checked) {
      return;
    }

    this.isAllSelected = checked;
    this.cartItems = this.cartItems.map(item => {
      item.selected = checked;
      return item;
    });
    this.calculateTotalPrice();
  }

  // 单选逻辑：使用 Checkbox 传递的最新 value
  toggleItemSelect(index: number, checked: boolean) {
    // 先更新当前项状态
    this.cartItems[index].selected = checked;

    // 计算最新的全选状态
    const newAllSelected = this.cartItems.every(item => item.selected);

    // 更新全选状态（这可能会触发 BottomBar 中 Checkbox 的 onChange）
    this.isAllSelected = newAllSelected;

    // 强制刷新数组并计算价格
    this.cartItems = [...this.cartItems];
    this.calculateTotalPrice();
  }

  // 数量更新逻辑
  updateQuantity(index: number, delta: number) {
    const newQuantity = this.cartItems[index].quantity + delta;
    if (newQuantity >= 1 && newQuantity <= 99) {
      this.cartItems[index].quantity = newQuantity;
      this.cartItems = [...this.cartItems]; // 触发更新
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
          this.toggleItemSelect(index, value);
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

        // 数量选择器 + 删除按钮
        Row() {
          // 左侧数量调节
          Row({ space: 8 }) {
            Button() {Text('-')}
              .width(28)
              .height(28)
              .fontSize(NORMAL_FONT_SIZE)
              .backgroundColor(item.quantity <= 1 ? this.currentThemeColors.tabUnselectedColor : this.currentThemeColors.accentColor)
              .fontColor(item.quantity <= 1 ? this.currentThemeColors.secondaryTextColor : this.currentThemeColors.primaryTextColor)
              .enabled(item.quantity > 1)
              .onClick(() => this.updateQuantity(index, -1))

            Text(item.quantity.toString())
              .fontSize(NORMAL_FONT_SIZE)
              .fontColor(this.currentThemeColors.primaryTextColor)
              .width(32)
              .textAlign(TextAlign.Center)

            Button() {Text('+')}
              .width(28)
              .height(28)
              .fontSize(NORMAL_FONT_SIZE)
              .backgroundColor(this.currentThemeColors.accentColor)
              .fontColor(this.currentThemeColors.primaryTextColor)
              .onClick(() => this.updateQuantity(index, 1))
          }
          .backgroundColor(this.currentThemeColors.backgroundColor) // 给数量选择器加个浅色背景底色
          .borderRadius(6)

          Blank() // 自动撑开中间空白

          // 删除按钮
          Button() {
            //
            Text('删除')
              .fontSize(20)
              .fontColor(Color.Red)
              .fontWeight(FontWeight.Bold)
          }
          .width(64)
          .height(32)
          .backgroundColor(Color.Transparent)
          .border({ width: 1, color: '#FF4D4F' }) // 红色边框
          .borderRadius(6)
          .onClick(() => {
            this.deleteItem(item.id);
          })
        }
        .width('100%') // 撑满父容器宽度
        .alignItems(VerticalAlign.Center)
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
      Image($r('app.media.ic_cart_normal'))
        .width(120)
        .height(120) // 空购物车图标

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
        .onClick(() => {
          router.replaceUrl({
            url: 'pages/ListIndex'
          });
        })
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
          .onChange((value: boolean) => {
            this.toggleSelectAll(value);
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
    if (!this.isLoggedIn) {
      // 未登录时显示登录提示
      Column() {
        Text('请先登录')
          .fontSize(18)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 16 })

        Text('登录后可以查看和管理您的购物车')
          .fontSize(14)
          .fontColor(this.currentThemeColors.secondaryTextColor)
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(LAYOUT_WIDTH_OR_HEIGHT)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.currentThemeColors.backgroundColor)
    } else {
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
}