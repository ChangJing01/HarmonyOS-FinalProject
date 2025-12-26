# working



# 分析

你好！我已经仔细阅读了你上传的《移动互联网编程实践》课程大作业说明及评分标准。

既然你的小组选择了 **“商城” (Mall)** 作为选题，我为你整理了该选题的核心开发要求、关键技术点以及高分策略，帮助你清晰地开展工作。

### 1. 核心开发环境与技术栈

- 

  **操作系统**：HarmonyOS Next 

- 

  **开发工具**：DevEco Studio 

- 

  **编程语言**：必须使用 **ArkTS**，严禁混用 JS/Java 。

- 

  **调试环境**：鸿蒙真机或模拟器 。

### 2. “商城”选题的具体功能要求

根据文档，你们需要开发一个包含商品浏览、分类、搜索和筛选功能的商城应用。

**A. 页面架构与布局**

- **整体结构**：使用 `Navigation` 实现标题，使用 `Tabs` 做内容分类 。
- **五大模块**：页面需分为“精选”、“手机”、“服饰”、“穿搭”、“家居” 5个 Tab 。
  - **特殊要求**：“精选”模块需单独编写代码，其余4个模块可使用 `ForEach` 遍历生成，但样式必须保持一致 。
- **组件层级**：Tab页内需包含 `SelectedComponent` (精选组件)、`Banner` (轮播图)、`WaterfallList` (瀑布流列表)、`RefreashLayout` (刷新布局) 。

**B. 核心交互与性能指标**

- **长列表渲染**：使用 `Scroll` 嵌套 `List`，并结合 `LazyForEach` 实现懒加载 。

  - **加载策略**：首屏推荐加载 20 条，后续增量加载 20 条；当剩余 6 条商品时提前拉取新数据 。
  - **性能指标**：滑动过程中保持帧率 **≥40fps**，中间不掉帧 。

- **下拉刷新**：使用 `TouchEvent` 判断下拉偏移量，需处理**网络延迟**等异常情况的动画表现 。

- **到底提示**：使用 Scroll 的 `edgeEffect` 控制回弹效果（系统级弹簧），并提示“已经到底了” 。

  

### 3. 项目交付物清单 (提交要求)

除了代码，文档和管理过程在评分中占比很高（约50%），请务必注意以下材料的准备：

1. **需求分析文档**：含用例图、类图、状态图，明确功能与非功能需求 。

   

2. **架构设计文档**：含构件图、活动图、顺序图，覆盖数据库和接口设计 。

   

3. **系统测试报告**：提供测试计划、用例及**量化结果**（如FPS测试截图证明达到了40fps） 。

   

4. **项目管理文档**：假设项目期为2个月，需包含计划表、分工说明、进度跟踪及风险管理 。

5. **代码与原型**：提交完整的代码和数据文件 。

6. **个人与小组总结**：

   - 组长：提供成员角色分工及工作情况说明 。

   - 全员：每人一份 400 字以内的个人实践心得 。

     

7. **功能展示视频**：录制视频展示功能的完整实现 。

8. **项目申请书**：(注意：文档提及需在11月底前提交) 包含分工、背景、亮点和技术路线 。

   

   

### 4. 拿分策略建议 (基于评分标准)

- **可视化你的设计 (30分+20分)**：评分标准非常看重 UML 图表（用例图、类图、顺序图等）。不要只写文字，一定要画规范的 UML 图 。

- **量化测试指标 (10分)**：在测试报告中，不要只写“测试通过”，要明确列出性能数据（例如：列表滑动平均帧率 42fps，响应时间 xx ms），这对应评分标准中的“量化验证” 。

- **争取创新分 (10分)**：基础要求是“仿照”，但如果能增加文档未提及的创意功能（如复杂的图像处理、自定义的高级动画、或者更智能的推荐算法），可以拿到创新分 。

  **异常处理 (10分)**：文档特意强调了“下拉动画遇到网络延迟如何应对” 。在代码中模拟弱网环境并展示你们的处理逻辑（如 Loading 状态、超时提示），这能体现系统的稳定性 。

### 下一步

作为 Computer Science 的博士生，我相信你在架构设计和算法实现上没有问题。**你现在希望我先协助你进行哪一部分的工作？**

- **A. 架构辅助**：帮你梳理“商城”的类图结构或 UML 序列图逻辑（如懒加载的时序）。
- **B. 代码实现**：提供 `LazyForEach` 或下拉刷新组件的 ArkTS 代码框架。
- **C. 文档撰写**：协助草拟需求分析文档或项目管理计划的大纲。
- **D. 创新点脑暴**：结合你的研究背景（如数字化），构思一些能加分的创新功能。



# 代码



文件列表：

`entry/src/main/ets/pages`:



CategoryPage.ets

```
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

import CategoryTab, { CategoryData, SubCategoryData } from '../view/CategoryTabComponent';
import CategorySub from '../view/CategorySubComponent';
import GoodsList from '../view/GoodsListComponent';
import {
  LAYOUT_WIDTH_OR_HEIGHT
} from '../common/CommonConstants';

@Component
export default struct CategoryPage {
  @State selectedCategoryIndex: number = 0;
  @State selectedSubCategoryIndex: number = 0;
  @State showSubCategory: boolean = true;

  private categoryData: CategoryData[] = [
    {
      id: 0,
      name: $r('app.string.selected'),
      subCategories: [
        { id: 0, name: $r('app.string.sub_all') },
        { id: 1, name: $r('app.string.sub_hot') },
        { id: 2, name: $r('app.string.sub_new') }
      ]
    },
    {
      id: 1,
      name: $r('app.string.mobile_phone'),
      subCategories: [
        { id: 0, name: $r('app.string.sub_all') },
        { id: 1, name: $r('app.string.sub_android') },
        { id: 2, name: $r('app.string.sub_ios') }
      ]
    },
    {
      id: 2,
      name: $r('app.string.clothes'),
      subCategories: [
        { id: 0, name: $r('app.string.sub_all') },
        { id: 1, name: $r('app.string.sub_mens') },
        { id: 2, name: $r('app.string.sub_womens') }
      ]
    },
    {
      id: 3,
      name: $r('app.string.wear'),
      subCategories: [
        { id: 0, name: $r('app.string.sub_all') },
        { id: 1, name: $r('app.string.sub_casual') },
        { id: 2, name: $r('app.string.sub_formal') }
      ]
    },
    {
      id: 4,
      name: $r('app.string.home_furnishing'),
      subCategories: [
        { id: 0, name: $r('app.string.sub_all') },
        { id: 1, name: $r('app.string.sub_furniture') },
        { id: 2, name: $r('app.string.sub_decor') }
      ]
    }
  ];

  getSubCategoriesForCurrentTab(): SubCategoryData[] {
    return this.categoryData[this.selectedCategoryIndex].subCategories;
  }

  getCurrentSubCategoryName(): Resource {
    const subCategories = this.getSubCategoriesForCurrentTab();
    return subCategories[this.selectedSubCategoryIndex].name;
  }

  build() {
    Column() {
      // 一级分类 Tab（横向）
      Row() {
        CategoryTab({
          selectedCategoryIndex: $selectedCategoryIndex,
          selectedSubCategoryIndex: $selectedSubCategoryIndex
        })
          .layoutWeight(1)

        // 切换左侧栏显示/隐藏按钮
        Text(this.showSubCategory ? '◀' : '▶')
          .fontSize(16)
          .fontColor('#666666')
          .width(40)
          .height(56)
          .textAlign(TextAlign.Center)
          .backgroundColor('#FFFFFF')
          .onClick(() => {
            this.showSubCategory = !this.showSubCategory;
          })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)

      // 二级分类和商品列表（左右分栏）
      Row() {
        // 左侧：二级子分类（可隐藏）
        CategorySub({
          selectedSubCategoryIndex: $selectedSubCategoryIndex,
          subCategories: this.getSubCategoriesForCurrentTab()
        })
          .width(this.showSubCategory ? '25%' : '0%')
          .visibility(this.showSubCategory ? Visibility.Visible : Visibility.Hidden)

        // 右侧：商品列表
        GoodsList()
          .layoutWeight(1)
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .layoutWeight(1)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#F5F5F5')
  }
}
```



GoodsDetailPage.ets

````
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
  MAX_FONT_SIZE,
  SMALL_FONT_SIZE,
  NAV_BAR_HEIGHT,
  BUTTON_HEIGHT,
  BUTTON_BORDER_RADIUS
} from '../common/CommonConstants';

@Component
export default struct GoodsDetailPage {
  @State goodsName: string = '【新到】长乐冰晶绿低脂新品上市';
  @State goodsPrice: string = '¥199';
  @State originalPrice: string = '¥299';
  @State salesCount: string = '6662人已购买';
  @State rating: string = '95%好评';
  @State selectedQuantity: number = 1;

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
        .fontColor('#333333')
        .onClick(() => {
          // 返回上一页
        })

      Text($r('app.string.goods_detail'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // Image($r('app.media.ic_share'))
      //   .width(24)
      //   .height(24)
      // 分享按钮
      Text('⋯')
        .fontSize(24)
        .fontColor('#333333')
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(NAV_BAR_HEIGHT)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
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
          .fontColor('#FF4D4F')
          .fontWeight(FontWeight.Bold)

        Text(this.originalPrice)
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor('#999999')
          .decoration({ type: TextDecorationType.LineThrough })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .alignItems(VerticalAlign.Bottom)

      // 商品名称
      Text(this.goodsName)
        .fontSize(BIGGER_FONT_SIZE)
        .fontColor('#333333')
        .fontWeight(FontWeight.Bold)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width(LAYOUT_WIDTH_OR_HEIGHT)

      // 销量和评价
      Row({ space: 16 }) {
        Text(this.salesCount)
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')

        Text(this.rating)
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
  }

  @Builder
  QuantitySelector() {
    Column() {
      Row() {
        Text($r('app.string.quantity'))
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor('#333333')
          .layoutWeight(1)

        Row({ space: 12 }) {
          Button('-')
            .width(32)
            .height(32)
            .fontSize(BIGGER_FONT_SIZE)
            .backgroundColor(this.selectedQuantity <= 1 ? '#F5F5F5' : '#FF4D4F')
            .fontColor(this.selectedQuantity <= 1 ? '#CCCCCC' : '#FFFFFF')
            .enabled(this.selectedQuantity > 1)
            .onClick(() => {
              if (this.selectedQuantity > 1) {
                this.selectedQuantity--;
              }
            })

          Text(this.selectedQuantity.toString())
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor('#333333')
            .width(40)
            .textAlign(TextAlign.Center)

          Button('+')
            .width(32)
            .height(32)
            .fontSize(BIGGER_FONT_SIZE)
            .backgroundColor('#FF4D4F')
            .fontColor('#FFFFFF')
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
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .margin({ top: 8 })
  }

  @Builder
  GoodsDescription() {
    Column({ space: 12 }) {
      Text($r('app.string.goods_description'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width(LAYOUT_WIDTH_OR_HEIGHT)

      Text($r('app.string.advertising_language'))
        .fontSize(SMALL_FONT_SIZE)
        .fontColor('#666666')
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .lineHeight(24)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding(16)
    .backgroundColor('#FFFFFF')
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
          .fontColor('#666666')

        Text($r('app.string.favorite'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .onClick(() => {
        // 收藏逻辑
      })

      Button($r('app.string.add_to_cart'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor('#FFFFFF')
        .backgroundColor('#FF9800')
        .height(BUTTON_HEIGHT)
        .borderRadius(BUTTON_BORDER_RADIUS)
        .layoutWeight(1)
        .onClick(() => {
          // 加入购物车逻辑
        })

      Button($r('app.string.buy_now'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor('#FFFFFF')
        .backgroundColor('#FF4D4F')
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
    .backgroundColor('#FFFFFF')
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
      .backgroundColor('#F5F5F5')

      // 底部操作栏
      this.BottomActionBar()
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#F5F5F5')
  }
}
````





ListIndex.ets

```
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

import TabBar from '../view/TabBarsComponent';
import BottomTabBar from '../view/BottomTabBarComponent';
import CategoryPage from './CategoryPage';
import ShoppingCartPage from './ShoppingCartPage';
import PersonalPage from './PersonalPage';
import {
  LAYOUT_WIDTH_OR_HEIGHT,
  NAV_BAR_HEIGHT
} from '../common/CommonConstants';

@Entry
@Component
struct ListIndex {
  @State currentTabIndex: number = 0;

  @Builder
  NavigationTitle() {
    Row() {
      Text(this.getPageTitle())
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(NAV_BAR_HEIGHT)
    .justifyContent(FlexAlign.Center)
  }

  getPageTitle(): Resource {
    switch (this.currentTabIndex) {
      case 0:
        return $r('app.string.shopping_mall');
      case 1:
        return $r('app.string.category');
      case 2:
        return $r('app.string.shopping_cart');
      case 3:
        return $r('app.string.personal');
      default:
        return $r('app.string.shopping_mall');
    }
  }

  @Builder
  PageContent() {
    if (this.currentTabIndex === 0) {
      // 首页内容
      Column() {
        TabBar()
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(LAYOUT_WIDTH_OR_HEIGHT)
    } else if (this.currentTabIndex === 1) {
      // 分类页面
      CategoryPage()
    } else if (this.currentTabIndex === 2) {
      // 购物车页面
      ShoppingCartPage()
    } else if (this.currentTabIndex === 3) {
      // 个人中心页面
      PersonalPage()
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      this.NavigationTitle()

      // 主内容区域
      Stack() {
        this.PageContent()
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .layoutWeight(1)

      // 底部 Tab Bar
      BottomTabBar({ currentIndex: $currentTabIndex })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor($r('app.color.primaryBgColor'))
  }
}
```



PersonalPage.ets

```
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
  SMALL_FONT_SIZE
} from '../common/CommonConstants';

interface MenuItem {
  icon: Resource;
  title: Resource;
  showArrow: boolean;
}

@Component
export default struct PersonalPage {
  @State userName: string = '用户名';
  @State userAvatar: Resource = $r('app.media.ic_avatar');

  private menuItems: MenuItem[] = [
    { icon: $r('app.media.ic_order'), title: $r('app.string.my_orders'), showArrow: true },
    { icon: $r('app.media.ic_history'), title: $r('app.string.browse_history'), showArrow: true },
    { icon: $r('app.media.ic_theme'), title: $r('app.string.theme_settings'), showArrow: true },
    { icon: $r('app.media.ic_compare'), title: $r('app.string.goods_compare'), showArrow: true },
    { icon: $r('app.media.ic_clear'), title: $r('app.string.clear_cache'), showArrow: true },
    { icon: $r('app.media.ic_about'), title: $r('app.string.about_us'), showArrow: true }
  ];

  @Builder
  UserInfoSection() {
    Row({ space: 16 }) {
      // 头像
      Image(this.userAvatar)
        .width(64)
        .height(64)
        .borderRadius(32)
        .backgroundColor('#F5F5F5')

      // 用户信息
      Column({ space: 8 }) {
        Text(this.userName)
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor('#333333')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.edit_profile'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#999999')
          .onClick(() => {
            // 编辑资料逻辑
          })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r('app.media.ic_arrow_right'))
        .width(20)
        .height(20)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
  }

  @Builder
  OrderStatistics() {
    Row() {
      Column({ space: 8 }) {
        Text('0')
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor('#333333')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.pending_payment'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .layoutWeight(1)

      Column({ space: 8 }) {
        Text('0')
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor('#333333')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.pending_shipment'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .layoutWeight(1)

      Column({ space: 8 }) {
        Text('0')
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor('#333333')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.pending_receipt'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .layoutWeight(1)

      Column({ space: 8 }) {
        Text('0')
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor('#333333')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.completed'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .layoutWeight(1)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .margin({ top: 8 })
  }

  @Builder
  MenuItemBuilder(item: MenuItem) {
    Row({ space: 12 }) {
      Image(item.icon)
        .width(24)
        .height(24)

      Text(item.title)
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor('#333333')
        .layoutWeight(1)

      if (item.showArrow) {
        Image($r('app.media.ic_arrow_right'))
          .width(16)
          .height(16)
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      // 菜单项点击逻辑
    })
  }

  build() {
    Scroll() {
      Column() {
        // 用户信息区域
        this.UserInfoSection()

        // 订单统计
        this.OrderStatistics()

        // 功能菜单列表
        Column() {
          ForEach(this.menuItems, (item: MenuItem) => {
            this.MenuItemBuilder(item)
            Divider()
              .strokeWidth(1)
              .color('#F0F0F0')
          })
        }
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .margin({ top: 8 })

        // 退出登录按钮
        Button($r('app.string.logout'))
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor('#FF4D4F')
          .backgroundColor('#FFFFFF')
          .width(LAYOUT_WIDTH_OR_HEIGHT)
          .height(48)
          .margin({ top: 16, bottom: 16 })
          .borderRadius(8)
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .padding(8)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#F5F5F5')
  }
}
```



SearchPage.ets

```
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

import SearchBar from '../view/SearchBarComponent';
import GoodsList from '../view/GoodsListComponent';
import {
  LAYOUT_WIDTH_OR_HEIGHT,
  NORMAL_FONT_SIZE,
  SMALL_FONT_SIZE,
  NAV_BAR_HEIGHT
} from '../common/CommonConstants';

@Component
export default struct SearchPage {
  @State searchText: string = '';
  @State isSearching: boolean = false;
  @State searchHistory: string[] = ['手机', '笔记本', '耳机', '键盘'];
  @State hotSearchList: string[] = ['华为手机', '苹果手机', '小米手机', '蓝牙耳机', '机械键盘'];
  @State searchResults: number = 0;

  handleSearch() {
    if (this.searchText.trim().length === 0) {
      return;
    }

    // 添加到搜索历史
    if (!this.searchHistory.includes(this.searchText)) {
      this.searchHistory.unshift(this.searchText);
      if (this.searchHistory.length > 10) {
        this.searchHistory.pop();
      }
    }

    this.isSearching = true;
    // 模拟搜索结果数量
    this.searchResults = Math.floor(Math.random() * 100) + 20;
  }

  handleClear() {
    this.searchText = '';
    this.isSearching = false;
  }

  clearHistory() {
    this.searchHistory = [];
  }

  @Builder
  SearchHistoryBuilder() {
    Column() {
      // 搜索历史标题
      Row() {
        Text($r('app.string.search_history'))
          .fontSize(NORMAL_FONT_SIZE)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)

        Text($r('app.string.clear_history'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#999999')
          .onClick(() => {
            this.clearHistory();
          })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // 搜索历史列表
      if (this.searchHistory.length > 0) {
        List() {
          ForEach(this.searchHistory, (item: string) => {
            ListItem() {
              Row() {
                Image($r('app.media.ic_history'))
                  .width(20)
                  .height(20)

                Text(item)
                  .fontSize(NORMAL_FONT_SIZE)
                  .fontColor('#666666')
                  .margin({ left: 12 })
                  .layoutWeight(1)

                Image($r('app.media.ic_arrow_right'))
                  .width(16)
                  .height(16)
              }
              .width(LAYOUT_WIDTH_OR_HEIGHT)
              .height(48)
              .padding({ left: 16, right: 16 })
              .onClick(() => {
                this.searchText = item;
                this.handleSearch();
              })
            }
          })
        }
        .divider({ strokeWidth: 1, color: '#F0F0F0' })
      } else {
        Text($r('app.string.no_search_history'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#999999')
          .margin({ top: 24 })
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#FFFFFF')
    .margin({ top: 8 })
  }

  @Builder
  HotSearchBuilder() {
    Column() {
      // 热门搜索标题
      Text($r('app.string.hot_search'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // 热门搜索标签
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.hotSearchList, (item: string) => {
          Text(item)
            .fontSize(SMALL_FONT_SIZE)
            .fontColor('#666666')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .backgroundColor('#F5F5F5')
            .borderRadius(16)
            .margin({ right: 8, bottom: 8 })
            .onClick(() => {
              this.searchText = item;
              this.handleSearch();
            })
        })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .padding({ left: 16, right: 16, bottom: 16 })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#FFFFFF')
    .margin({ top: 8 })
  }

  @Builder
  SearchResultBuilder() {
    Column() {
      // 搜索结果提示
      Row() {
        Text($r('app.string.search_result_prefix'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')

        Text(this.searchResults.toString())
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#FF4D4F')
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.search_result_suffix'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#666666')
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(NAV_BAR_HEIGHT)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F5F5F5')

      // 搜索结果列表
      GoodsList()
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .layoutWeight(1)
  }

  build() {
    Column() {
      // 顶部搜索栏
      Row() {
        SearchBar({
          searchText: $searchText,
          onSearchClick: () => {
            this.handleSearch();
          },
          onClearClick: () => {
            this.handleClear();
          }
        })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(NAV_BAR_HEIGHT)
      .padding({ left: 8, right: 8 })
      .backgroundColor('#FFFFFF')

      // 内容区域
      if (this.isSearching) {
        // 显示搜索结果
        this.SearchResultBuilder()
      } else {
        // 显示搜索历史和热门搜索
        Scroll() {
          Column() {
            this.SearchHistoryBuilder()
            this.HotSearchBuilder()
          }
          .width(LAYOUT_WIDTH_OR_HEIGHT)
        }
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .layoutWeight(1)
        .backgroundColor('#F5F5F5')
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#F5F5F5')
  }
}
```



ShoppingCartPage.ets

```
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
        .selectedColor('#FF4D4F')
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
          .fontColor('#333333')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(item.price)
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor('#FF4D4F')
          .fontWeight(FontWeight.Bold)

        // 数量选择器
        Row({ space: 8 }) {
          Button('-')
            .width(28)
            .height(28)
            .fontSize(NORMAL_FONT_SIZE)
            .backgroundColor(item.quantity <= 1 ? '#F5F5F5' : '#FF4D4F')
            .fontColor(item.quantity <= 1 ? '#CCCCCC' : '#FFFFFF')
            .enabled(item.quantity > 1)
            .onClick(() => {
              this.updateQuantity(index, -1);
            })

          Text(item.quantity.toString())
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor('#333333')
            .width(32)
            .textAlign(TextAlign.Center)

          Button('+')
            .width(28)
            .height(28)
            .fontSize(NORMAL_FONT_SIZE)
            .backgroundColor('#FF4D4F')
            .fontColor('#FFFFFF')
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
    .backgroundColor('#FFFFFF')
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
        .backgroundColor('#FF4D4F')
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
          .selectedColor('#FF4D4F')
          .onChange(() => {
            this.toggleSelectAll();
          })

        Text($r('app.string.select_all'))
          .fontSize(SMALL_FONT_SIZE)
          .fontColor('#333333')
      }

      // 总价
      Column({ space: 4 }) {
        Row({ space: 4 }) {
          Text($r('app.string.total'))
            .fontSize(SMALL_FONT_SIZE)
            .fontColor('#666666')

          Text('¥' + this.totalPrice.toFixed(2))
            .fontSize(BIGGER_FONT_SIZE)
            .fontColor('#FF4D4F')
            .fontWeight(FontWeight.Bold)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.End)

      // 结算按钮
      Button($r('app.string.checkout'))
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor('#FFFFFF')
        .backgroundColor('#FF4D4F')
        .height(BUTTON_HEIGHT)
        .borderRadius(BUTTON_BORDER_RADIUS)
        .width(120)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(72)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
    .shadow({
      radius: 8,
      color: '#00000015',
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
        .backgroundColor('#F5F5F5')

        // 底部操作栏
        this.BottomBar()
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#F5F5F5')
  }
}
```



# 问题

购物车按按钮，数字不会增加，但勾选结算时计算总价却会改变。













# update

1.1 : 修改PersonalPages.ets，为菜单项添加 id，添加显示主题选择弹窗的方法。

1.2 颜色替换： '#FF4D4F' 换成 this.currentThemeColors.accentColor

​			'#333333' 换成 this.currentThemeColors.primaryTextColor

​			'#FFFFFF' 换成 this.currentThemeColors.cardBackgroundColor

​			'#F5F5F5'是默认的背景色





































