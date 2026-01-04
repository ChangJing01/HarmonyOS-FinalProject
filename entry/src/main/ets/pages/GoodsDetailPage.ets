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
import { CartItem } from './ShoppingCartPage';
import promptAction from '@ohos.promptAction';
import { BrowsingHistoryItem, CommentItem, GoodsListItemType } from '../viewmodel/InitialData';
import {CustomToastDialog} from '../view/CustomDialog'

// 在组件外或类中定义一个图片资源池
const GOODS_IMAGES: Resource[] = [
  $r('app.media.goodsImg'),
  $r('app.media.goodsImg_2'),
  $r('app.media.goodsImg_3'),
  $r('app.media.goodsImg_4'),
];

// 在组件外或类中定义一个图片资源池
const GOODS_NAMES: Resource[] = [
  $r('app.string.goodsName'),
  $r('app.string.another_goodsName'),
];

// 在组件外或类中定义一个图片资源池
const GOODS_PRICES: Resource[] = [
  $r('app.string.price_199'),
  $r('app.string.price_265'),
  $r('app.string.price_810'),
  $r('app.string.price_999'),
];

@Entry
@Component
export default struct GoodsDetailPage {
  @State goodsName: string = (router.getParams() as Record<string, Object>)['goodsName'] as string;
  @State goodsPrice: string = (router.getParams() as Record<string, Object>)['goodsPrice'] as string;
  @State goodsImg: string | Resource = '';
  @State goodsId: number = 0;
  @State originalPrice: string = '¥299';
  @State salesCount: number = 0; // 改为数字计数器
  @State goodReviewCount: number = 0; // 好评计数器
  @State selectedQuantity: number = 1;
  @State commentText: string = ''; // 输入框内容
  @State commentList: CommentItem[] = []; // 当前商品的评论列表
  @State toastMessage: string = '';
  @State publishRating: number = 5;
  @State showPaymentDialog: boolean = false; // 支付对话框
  @State selectedPaymentMethod: string = 'alipay'; // 支付方式
  @State isPaying: boolean = false; // 是否正在支付
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomToastDialog({ message: this.toastMessage }),
    customStyle: true, // 允许完全自定义样式（去背景、去圆角等由我们自己控制）
    alignment: DialogAlignment.Bottom, // 底部显示
    offset: { dx: 0, dy: -80 } // 距离底部的偏移量
  })
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;
  @StorageLink('browsingHistory') browsingHistory: BrowsingHistoryItem[] = [];
  @StorageLink('goodsList') goodsList: GoodsListItemType[] = [];

  aboutToAppear(): void {
    // 获取路由参数
    const params = router.getParams() as Record<string, Object>;
    this.goodsImg = params['goodsImg'] as string | Resource;
    this.goodsId = params['goodsId'] as number;
    
    // 从商品列表中获取商品信息
    const goods = this.goodsList.find(item => item.id === this.goodsId);
    if (goods) {
      this.goodsImg = goods.goodsImg;
      this.goodsName = goods.goodsName as string;
      this.goodsPrice = goods.price as string;
      this.salesCount = goods.salesCount;
      this.goodReviewCount = goods.goodReviewCount;
    }
    
    // 记录浏览历史
    this.recordBrowsingHistory();

    this.commentList = [
      new CommentItem('用户A', '东西很不错，物流很快！', 5),
      new CommentItem('用户B', '性价比很高，推荐购买。', 4)
    ];
  }

  showCustomToast(msg: string) {
    this.toastMessage = msg;
    this.dialogController.open();
    // 2秒后自动关闭
    setTimeout(() => {
      try {
        this.dialogController.close();
      } catch (e) {}
    }, 2000);
  }

  private recordBrowsingHistory(): void {
    // 检查是否已经浏览过该商品（防止重复）
    const existingIndex = this.browsingHistory.findIndex(item => item.id === this.goodsId);
    
    if (existingIndex !== -1) {
      // 如果已存在，更新时间戳并移到最前面
      const existingItem = this.browsingHistory[existingIndex];
      existingItem.browsedTime = Date.now();
      this.browsingHistory.splice(existingIndex, 1);
      this.browsingHistory.unshift(existingItem);
    } else {
      // 如果不存在，创建新记录
      const newRecord = new BrowsingHistoryItem(
        this.goodsId,
        this.goodsImg,
        this.goodsName,
        this.goodsPrice,
        Date.now()
      );
      this.browsingHistory.unshift(newRecord);
    }
  }

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
      Image(this.goodsImg)
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .height(400)
        .objectFit(ImageFit.Cover)

      Image(this.goodsImg)
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .height(400)
        .objectFit(ImageFit.Cover)

      Image(this.goodsImg)
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
        Text(`${this.salesCount}人已购买`)
          .fontSize(SMALL_FONT_SIZE)
          .fontColor(this.currentThemeColors.secondaryTextColor)

        Text(`好评${this.goodReviewCount}`)
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
          Button() {Text('-')}
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

          Button() {Text('+')}
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

//评论模块
  @Builder
  CommentSection() {
    Column() {
      // 标题栏 (保持不变)
      Text('商品评价 (' + this.commentList.length + ')')
        .fontSize(NORMAL_FONT_SIZE)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .width('100%')
        .padding({ left: 16, top: 16 })

      // 评论列表
      List() {
        ForEach(this.commentList, (item: CommentItem) => {
          ListItem() {
            Column({ space: 8 }) {
              // ... (头像、用户名称部分保持不变) ...
              Row() {
                Image(item.avatar).width(30).height(30).borderRadius(15).margin({ right: 10 })
                Text(item.user).fontSize(SMALL_FONT_SIZE).fontColor(this.currentThemeColors.secondaryTextColor)
                Blank()
                Text(item.time).fontSize(12).fontColor(this.currentThemeColors.secondaryTextColor)
              }.width('100%')

              Text(item.content)
                .fontSize(NORMAL_FONT_SIZE)
                .fontColor(this.currentThemeColors.primaryTextColor)
                .margin({ left: 40 })

              // 👇 【修改点 1】列表中的只读星星
              Row() {
                StarRating({
                  rating: item.rating,
                  isInteractive: false
                })
              }.margin({ left: 40 })
            }
            .padding(16)
            .alignItems(HorizontalAlign.Start)
          }
        })
      }
      .divider({ strokeWidth: 1, color: this.currentThemeColors.backgroundColor, startMargin: 16, endMargin: 16 })

      // 发布评论区域
      Column({ space: 10 }) {
        // 👇 【修改点 2】交互式打分星星
        Row() {
          Text('评分：')
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.secondaryTextColor)

          // 使用新组件
          StarRating({
            rating: this.publishRating, // 绑定父组件状态
            isInteractive: true,        // 开启交互
            onRatingChange: (val: number) => {
              // 接收子组件传回来的值，更新状态
              this.publishRating = val;
            }
          })
        }
        .width('100%')
        .padding({ left: 4 })

        // 输入框和按钮 (保持不变)
        Row({ space: 10 }) {
          TextInput({ text: this.commentText, placeholder: '看对眼了？写句评价吧~' })
            .layoutWeight(1)
            .height(40)
            .placeholderColor(this.currentThemeColors.secondaryTextColor)
            .backgroundColor(this.currentThemeColors.backgroundColor)
            .borderRadius(20)
            .onChange((val) => this.commentText = val)

          Button('发布')
            .height(36)
            .fontSize(14)
            .backgroundColor(this.currentThemeColors.accentColor)
            .fontColor(Color.White)
            .onClick(() => {
              this.handlePublishComment();
            })
        }
      }
      .padding(16)
      .width('100%')
      .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    }
    .margin({ top: 10 })
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .borderRadius(8)
  }


  // 发布评论的逻辑
  handlePublishComment() {
    if (this.commentText.trim() === '') {
      this.showCustomToast('请输入评价内容');
      return;
    }

    // 👇 [修改] 使用用户选择的 publishRating
    const newComment = new CommentItem('我', this.commentText, this.publishRating);

    this.commentList.unshift(newComment); // 加到最前面

    // 如果是5星好评，增加好评计数器
    if (this.publishRating === 5) {
      this.goodReviewCount++;
      // 更新商品列表中的数据
      const goodsIndex = this.goodsList.findIndex(item => item.id === this.goodsId);
      if (goodsIndex !== -1) {
        this.goodsList[goodsIndex].goodReviewCount++;
        this.goodsList = [...this.goodsList];
      }
    }

    this.showCustomToast('评价成功！');
    this.commentText = ''; // 清空输入框
    this.publishRating = 5; // 👇 [新增] 发布完成后重置为 5 星
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
          // 加入购物车
          // 从 AppStorage 获取当前的购物车列表（如果不存在则创建一个空数组）
          let currentCart: CartItem[] = AppStorage.get<CartItem[]>('cartItems') || [];

          // 检查商品是否已经在购物车里（通过商品ID判断）
          const index = currentCart.findIndex(item => item.id === this.goodsId);

          if (index > -1) {
            // 情况 A：商品已存在，数量加 1
            currentCart[index].quantity += 1;
          } else {
            // 情况 B：商品不存在，构造一个新的 CartItem 并添加
            let newItem: CartItem = {
              id: this.goodsId,
              name: this.goodsName,
              price: this.goodsPrice,
              quantity: 1,
              image: this.goodsImg,
              selected: true // 新加入的默认选中
            };
            currentCart.push(newItem);
          }

          // 将更新后的数组写回 AppStorage，触发全局同步
          // 使用 [...currentCart] 确保内存地址改变，触发 UI 刷新
          AppStorage.setOrCreate('cartItems', [...currentCart]);

          // 提示用户添加成功
          promptAction.showToast({
            message: '已加入购物车',
            duration: 2000
          });
        })

      Button($r('app.string.buy_now'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor(this.currentThemeColors.cardBackgroundColor)
        .backgroundColor(this.currentThemeColors.accentColor)
        .height(BUTTON_HEIGHT)
        .borderRadius(BUTTON_BORDER_RADIUS)
        .layoutWeight(1)
        .onClick(() => {
          // 立即购买逻辑 - 显示支付对话框
          this.showPaymentDialog = true;
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

  // 支付相关方法
  async processPayment(): Promise<void> {
    if (this.isPaying) return;
    this.isPaying = true;

    try {
      // 模拟支付延迟
      await new Promise<void>((resolve) => {
        setTimeout(() => resolve(), 2000);
      });

      // 支付成功
      this.isPaying = false;
      this.showPaymentDialog = false;
      
      // 增加销量计数器
      this.salesCount += this.selectedQuantity;
      
      // 更新商品列表中的数据
      const goodsIndex = this.goodsList.findIndex(item => item.id === this.goodsId);
      if (goodsIndex !== -1) {
        this.goodsList[goodsIndex].salesCount += this.selectedQuantity;
        this.goodsList = [...this.goodsList];
      }
      
      this.showCustomToast('支付成功！');
      this.selectedQuantity = 1; // 重置数量
      
    } catch (error) {
      this.isPaying = false;
      this.showCustomToast('支付失败，请重试');
    }
  }

  cancelPayment() {
    this.showPaymentDialog = false;
    this.selectedPaymentMethod = 'alipay';
  }

  // 计算总价
  getTotalPrice(): number {
    const priceStr = this.goodsPrice.replace('¥', '').replace(',', '');
    const price = parseFloat(priceStr);
    return price * this.selectedQuantity;
  }

  @Builder
  PaymentDialog() {
    Stack() {
      // 半透明背景
      Column()
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .height(LAYOUT_WIDTH_OR_HEIGHT)
        .backgroundColor('#80000000')
        .onClick(() => this.cancelPayment())

      // 支付面板
      Column({ space: 16 }) {
        Text('确认支付')
          .fontSize(BIGGER_FONT_SIZE)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .width('100%')
          .textAlign(TextAlign.Center)

        Divider().strokeWidth(1).color(this.currentThemeColors.dividerColor)

        // 支付金额
        Row({ space: 8 }) {
          Text('支付金额：')
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)
          Text('¥' + this.getTotalPrice().toFixed(2))
            .fontSize(24)
            .fontColor(this.currentThemeColors.accentColor)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 10, bottom: 10 })

        // 商品信息
        Row({ space: 12 }) {
          Image(this.goodsImg)
            .width(60)
            .height(60)
            .borderRadius(8)
          Column({ space: 4 }) {
            Text(this.goodsName)
              .fontSize(SMALL_FONT_SIZE)
              .fontColor(this.currentThemeColors.primaryTextColor)
              .maxLines(2)
            Text(`x${this.selectedQuantity}`)
              .fontSize(SMALL_FONT_SIZE)
              .fontColor(this.currentThemeColors.secondaryTextColor)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
        }
        .width('100%')
        .padding(12)
        .backgroundColor(this.currentThemeColors.cardBackgroundColor)
        .borderRadius(8)

        // 支付方式选择
        Column({ space: 12 }) {
          Row({ space: 12 }) {
            Radio({ value: 'alipay', group: 'paymentGroup' })
              .checked(this.selectedPaymentMethod === 'alipay')
              .onChange((isChecked: boolean) => {
                if (isChecked) this.selectedPaymentMethod = 'alipay';
              })
            Text('支付宝')
              .fontSize(NORMAL_FONT_SIZE)
              .fontColor(this.currentThemeColors.primaryTextColor)
              .layoutWeight(1)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.selectedPaymentMethod === 'alipay' ? this.currentThemeColors.tabUnselectedColor : this.currentThemeColors.cardBackgroundColor)
          .borderRadius(8)
          .onClick(() => this.selectedPaymentMethod = 'alipay')

          Row({ space: 12 }) {
            Radio({ value: 'wechat', group: 'paymentGroup' })
              .checked(this.selectedPaymentMethod === 'wechat')
              .onChange((isChecked: boolean) => {
                if (isChecked) this.selectedPaymentMethod = 'wechat';
              })
            Text('微信支付')
              .fontSize(NORMAL_FONT_SIZE)
              .fontColor(this.currentThemeColors.primaryTextColor)
              .layoutWeight(1)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.selectedPaymentMethod === 'wechat' ? this.currentThemeColors.tabUnselectedColor : this.currentThemeColors.cardBackgroundColor)
          .borderRadius(8)
          .onClick(() => this.selectedPaymentMethod = 'wechat')

          Row({ space: 12 }) {
            Radio({ value: 'unionpay', group: 'paymentGroup' })
              .checked(this.selectedPaymentMethod === 'unionpay')
              .onChange((isChecked: boolean) => {
                if (isChecked) this.selectedPaymentMethod = 'unionpay';
              })
            Text('华为支付')
              .fontSize(NORMAL_FONT_SIZE)
              .fontColor(this.currentThemeColors.primaryTextColor)
              .layoutWeight(1)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.selectedPaymentMethod === 'unionpay' ? this.currentThemeColors.tabUnselectedColor : this.currentThemeColors.cardBackgroundColor)
          .borderRadius(8)
          .onClick(() => this.selectedPaymentMethod = 'unionpay')
        }
        .width('100%')

        Divider().strokeWidth(1).color(this.currentThemeColors.dividerColor)

        // 按钮组
        Row({ space: 12 }) {
          Button('取消')
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)
            .backgroundColor(this.currentThemeColors.tabUnselectedColor)
            .layoutWeight(1)
            .height(48)
            .borderRadius(8)
            .enabled(!this.isPaying)
            .onClick(() => this.cancelPayment())

          Button(this.isPaying ? '支付中...' : '确认支付')
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor('#FFFFFF')
            .backgroundColor(this.currentThemeColors.accentColor)
            .layoutWeight(1)
            .height(48)
            .borderRadius(8)
            .enabled(!this.isPaying)
            .onClick(() => this.processPayment())
        }
        .width('100%')
      }
      .width('85%')
      .padding(24)
      .backgroundColor(this.currentThemeColors.backgroundColor)
      .borderRadius(16)
      .position({ x: '7.5%', y: '50%' })
      .translate({ y: '-50%' })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
  }

  build() {
    Stack() {
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
            //评价模块
            this.CommentSection()
            Text('').height(80)
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

      // 支付对话框
      if (this.showPaymentDialog) {
        this.PaymentDialog()
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
  }
}

// ================== 独立的星星组件 (解决刷新延迟问题) ==================
@Component
struct StarRating {
  // @Prop 装饰器：接收父组件传来的值，且当父组件值变化时自动刷新
  @Prop rating: number = 0

  // 是否允许交互
  isInteractive: boolean = false

  // 回调函数：通知父组件分数改变了
  onRatingChange: (value: number) => void = () => {}

  build() {
    Row() {
      ForEach([1, 2, 3, 4, 5], (starValue: number) => {
        Text(starValue <= this.rating ? '★' : '☆') // 实心 vs 空心
          .fontColor('#FF9800') // 橙色
          .fontSize(this.isInteractive ? 28 : 14) // 交互模式大一点
          .margin({ right: this.isInteractive ? 10 : 0 })
          .onClick(() => {
            if (this.isInteractive) {
              // 调用回调，把新分数传回给父组件
              this.onRatingChange(starValue)
            }
          })
      }, (item: number) => item.toString())
    }
  }
}




