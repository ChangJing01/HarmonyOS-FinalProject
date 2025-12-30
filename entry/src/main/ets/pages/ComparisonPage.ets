import router from '@ohos.router';
import { GoodsListItemType } from '../viewmodel/InitialData';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';

@Entry
@Component
struct ComparisonPage {
  @StorageLink('compareList') compareList: GoodsListItemType[] = [];
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;

  build() {
    Column() {
      // 1. 顶部导航栏
      Row() {
        Text('←')
          .fontSize(24)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .onClick(() => router.back())

        Text('商品对比')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 占位，保持标题居中
        Text('  ').fontSize(24)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .margin({ top: 36 }) // 避让状态栏

      // 2. 对比内容区域
      if (this.compareList.length < 2) {
        // 异常处理：数据不足
        Column() {
          Text('请选择两个商品进行对比')
        }.height('100%').justifyContent(FlexAlign.Center)
      } else {
        Row() {
          // 左侧商品
          this.GoodsColumn(this.compareList[0])

          // 中间分割线
          Divider().vertical(true).height('80%').color(Color.Gray)

          // 右侧商品
          this.GoodsColumn(this.compareList[1])
        }
        .width('100%')
        .layoutWeight(1)
        .alignItems(VerticalAlign.Top)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.currentThemeColors.backgroundColor)
  }

  // 抽取单个商品展示列
  @Builder
  GoodsColumn(item: GoodsListItemType) {
    Column({ space: 10 }) {
      // 图片
      Image(item.goodsImg)
        .width('80%')
        .aspectRatio(1)
        .objectFit(ImageFit.Contain)
        .margin({ top: 20 })

      // 名称
      Text(item.goodsName)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .textAlign(TextAlign.Center)

      Divider()

      // 价格
      Text('价格')
        .fontSize(14)
        .fontColor(Color.Gray)
      Text(item.price)
        .fontSize(20)
        .fontColor(this.currentThemeColors.accentColor)

      Divider()

      // 评价
      Text('用户评价')
        .fontSize(14)
        .fontColor(Color.Gray)
      Text(item.evaluate)
        .fontSize(16)
        .fontColor(this.currentThemeColors.primaryTextColor)

      // 这里可以添加更多对比项...
    }
    .width('50%')
    .height('100%')
    .padding(10)
  }
}