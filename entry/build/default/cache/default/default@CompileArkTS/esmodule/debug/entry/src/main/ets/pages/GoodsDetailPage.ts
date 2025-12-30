if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface GoodsDetailPage_Params {
    goodsName?: string;
    goodsPrice?: string;
    originalPrice?: string;
    salesCount?: string;
    rating?: string;
    selectedQuantity?: number;
    currentThemeColors?: ThemeColors;
}
import router from "@ohos:router";
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, BIGGER_FONT_SIZE, MAX_FONT_SIZE, SMALL_FONT_SIZE, NAV_BAR_HEIGHT, BUTTON_HEIGHT, BUTTON_BORDER_RADIUS } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
import { DEFAULT_THEME } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import type { ThemeColors } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
export default class GoodsDetailPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__goodsName = new ObservedPropertySimplePU((router.getParams() as Record<string, Object>)['goodsName'] as string, this, "goodsName");
        this.__goodsPrice = new ObservedPropertySimplePU((router.getParams() as Record<string, Object>)['goodsPrice'] as string, this, "goodsPrice");
        this.__originalPrice = new ObservedPropertySimplePU('¥299', this, "originalPrice");
        this.__salesCount = new ObservedPropertySimplePU('6662人已购买', this, "salesCount");
        this.__rating = new ObservedPropertySimplePU('95%好评', this, "rating");
        this.__selectedQuantity = new ObservedPropertySimplePU(1, this, "selectedQuantity");
        this.__currentThemeColors = this.createStorageLink('themeColors', DEFAULT_THEME, "currentThemeColors");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: GoodsDetailPage_Params) {
        if (params.goodsName !== undefined) {
            this.goodsName = params.goodsName;
        }
        if (params.goodsPrice !== undefined) {
            this.goodsPrice = params.goodsPrice;
        }
        if (params.originalPrice !== undefined) {
            this.originalPrice = params.originalPrice;
        }
        if (params.salesCount !== undefined) {
            this.salesCount = params.salesCount;
        }
        if (params.rating !== undefined) {
            this.rating = params.rating;
        }
        if (params.selectedQuantity !== undefined) {
            this.selectedQuantity = params.selectedQuantity;
        }
    }
    updateStateVars(params: GoodsDetailPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__goodsName.purgeDependencyOnElmtId(rmElmtId);
        this.__goodsPrice.purgeDependencyOnElmtId(rmElmtId);
        this.__originalPrice.purgeDependencyOnElmtId(rmElmtId);
        this.__salesCount.purgeDependencyOnElmtId(rmElmtId);
        this.__rating.purgeDependencyOnElmtId(rmElmtId);
        this.__selectedQuantity.purgeDependencyOnElmtId(rmElmtId);
        this.__currentThemeColors.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__goodsName.aboutToBeDeleted();
        this.__goodsPrice.aboutToBeDeleted();
        this.__originalPrice.aboutToBeDeleted();
        this.__salesCount.aboutToBeDeleted();
        this.__rating.aboutToBeDeleted();
        this.__selectedQuantity.aboutToBeDeleted();
        this.__currentThemeColors.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __goodsName: ObservedPropertySimplePU<string>;
    get goodsName() {
        return this.__goodsName.get();
    }
    set goodsName(newValue: string) {
        this.__goodsName.set(newValue);
    }
    private __goodsPrice: ObservedPropertySimplePU<string>;
    get goodsPrice() {
        return this.__goodsPrice.get();
    }
    set goodsPrice(newValue: string) {
        this.__goodsPrice.set(newValue);
    }
    private __originalPrice: ObservedPropertySimplePU<string>;
    get originalPrice() {
        return this.__originalPrice.get();
    }
    set originalPrice(newValue: string) {
        this.__originalPrice.set(newValue);
    }
    private __salesCount: ObservedPropertySimplePU<string>;
    get salesCount() {
        return this.__salesCount.get();
    }
    set salesCount(newValue: string) {
        this.__salesCount.set(newValue);
    }
    private __rating: ObservedPropertySimplePU<string>;
    get rating() {
        return this.__rating.get();
    }
    set rating(newValue: string) {
        this.__rating.set(newValue);
    }
    private __selectedQuantity: ObservedPropertySimplePU<number>;
    get selectedQuantity() {
        return this.__selectedQuantity.get();
    }
    set selectedQuantity(newValue: number) {
        this.__selectedQuantity.set(newValue);
    }
    private __currentThemeColors: ObservedPropertyAbstractPU<ThemeColors>; //使用 @StorageLink 确保当 PersonalPage 改变主题时，这里会自动刷新
    get currentThemeColors() {
        return this.__currentThemeColors.get();
    }
    set currentThemeColors(newValue: ThemeColors) {
        this.__currentThemeColors.set(newValue);
    }
    TopNavigationBar(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.height(NAV_BAR_HEIGHT);
            Row.padding({ left: 16, right: 16 });
            Row.backgroundColor(this.currentThemeColors.backgroundColor);
            Row.justifyContent(FlexAlign.SpaceBetween);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Image($r('app.media.ic_back'))
            //   .width(24)
            //   .height(24)
            //   .onClick(() => {
            //     // 返回上一页
            //   })
            // 返回按钮
            Text.create('←');
            // Image($r('app.media.ic_back'))
            //   .width(24)
            //   .height(24)
            //   .onClick(() => {
            //     // 返回上一页
            //   })
            // 返回按钮
            Text.fontSize(24);
            // Image($r('app.media.ic_back'))
            //   .width(24)
            //   .height(24)
            //   .onClick(() => {
            //     // 返回上一页
            //   })
            // 返回按钮
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            // Image($r('app.media.ic_back'))
            //   .width(24)
            //   .height(24)
            //   .onClick(() => {
            //     // 返回上一页
            //   })
            // 返回按钮
            Text.onClick(() => {
                router.back();
            });
        }, Text);
        // Image($r('app.media.ic_back'))
        //   .width(24)
        //   .height(24)
        //   .onClick(() => {
        //     // 返回上一页
        //   })
        // 返回按钮
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777241, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.layoutWeight(1);
            Text.textAlign(TextAlign.Center);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Image($r('app.media.ic_share'))
            //   .width(24)
            //   .height(24)
            // 分享按钮
            Text.create('⋯');
            // Image($r('app.media.ic_share'))
            //   .width(24)
            //   .height(24)
            // 分享按钮
            Text.fontSize(24);
            // Image($r('app.media.ic_share'))
            //   .width(24)
            //   .height(24)
            // 分享按钮
            Text.fontColor(this.currentThemeColors.primaryTextColor);
        }, Text);
        // Image($r('app.media.ic_share'))
        //   .width(24)
        //   .height(24)
        // 分享按钮
        Text.pop();
        Row.pop();
    }
    GoodsImageSwiper(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Swiper.create();
            Swiper.width(LAYOUT_WIDTH_OR_HEIGHT);
            Swiper.height(400);
            Swiper.autoPlay(true);
            Swiper.interval(3000);
            Swiper.indicator(true);
            Swiper.loop(true);
        }, Swiper);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 16777294, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Image.width(LAYOUT_WIDTH_OR_HEIGHT);
            Image.height(400);
            Image.objectFit(ImageFit.Cover);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 16777295, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Image.width(LAYOUT_WIDTH_OR_HEIGHT);
            Image.height(400);
            Image.objectFit(ImageFit.Cover);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 16777296, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Image.width(LAYOUT_WIDTH_OR_HEIGHT);
            Image.height(400);
            Image.objectFit(ImageFit.Cover);
        }, Image);
        Swiper.pop();
    }
    GoodsInfoSection(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 12 });
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
            Column.padding(16);
            Column.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            Column.borderRadius(8);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 价格
            Row.create({ space: 8 });
            // 价格
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            // 价格
            Row.alignItems(VerticalAlign.Bottom);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.goodsPrice);
            Text.fontSize(MAX_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.accentColor);
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.originalPrice);
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
            Text.decoration({ type: TextDecorationType.LineThrough });
        }, Text);
        Text.pop();
        // 价格
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 商品名称
            Text.create(this.goodsName);
            // 商品名称
            Text.fontSize(BIGGER_FONT_SIZE);
            // 商品名称
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            // 商品名称
            Text.fontWeight(FontWeight.Bold);
            // 商品名称
            Text.maxLines(2);
            // 商品名称
            Text.textOverflow({ overflow: TextOverflow.Ellipsis });
            // 商品名称
            Text.width(LAYOUT_WIDTH_OR_HEIGHT);
        }, Text);
        // 商品名称
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 销量和评价
            Row.create({ space: 16 });
            // 销量和评价
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.salesCount);
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.rating);
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
        }, Text);
        Text.pop();
        // 销量和评价
        Row.pop();
        Column.pop();
    }
    QuantitySelector(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
            Column.padding({ left: 16, right: 16 });
            Column.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            Column.borderRadius(8);
            Column.margin({ top: 8 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.height(56);
            Row.alignItems(VerticalAlign.Center);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777260, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.layoutWeight(1);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 12 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel('-');
            Button.width(32);
            Button.height(32);
            Button.fontSize(BIGGER_FONT_SIZE);
            Button.backgroundColor(this.selectedQuantity <= 1 ? this.currentThemeColors.tabUnselectedColor : this.currentThemeColors.tabSelectedColor);
            Button.fontColor(this.selectedQuantity <= 1 ? this.currentThemeColors.secondaryTextColor : this.currentThemeColors.cardBackgroundColor);
            Button.enabled(this.selectedQuantity > 1);
            Button.onClick(() => {
                if (this.selectedQuantity > 1) {
                    this.selectedQuantity--;
                }
            });
        }, Button);
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.selectedQuantity.toString());
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.width(40);
            Text.textAlign(TextAlign.Center);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel('+');
            Button.width(32);
            Button.height(32);
            Button.fontSize(BIGGER_FONT_SIZE);
            Button.backgroundColor(this.currentThemeColors.accentColor);
            Button.fontColor(this.currentThemeColors.cardBackgroundColor);
            Button.onClick(() => {
                if (this.selectedQuantity < 99) {
                    this.selectedQuantity++;
                }
            });
        }, Button);
        Button.pop();
        Row.pop();
        Row.pop();
        Column.pop();
    }
    GoodsDescription(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 12 });
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
            Column.padding(16);
            Column.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            Column.borderRadius(8);
            Column.margin({ top: 8 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777240, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.width(LAYOUT_WIDTH_OR_HEIGHT);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777222, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
            Text.width(LAYOUT_WIDTH_OR_HEIGHT);
            Text.lineHeight(24);
        }, Text);
        Text.pop();
        Column.pop();
    }
    BottomActionBar(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 12 });
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.height(72);
            Row.padding({ left: 16, right: 16, top: 12, bottom: 12 });
            Row.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            Row.shadow({
                radius: 8,
                color: '#00000015',
                offsetY: -2
            });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 4 });
            Column.onClick(() => {
                // 收藏逻辑
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Image($r('app.media.ic_favorite'))
            //   .width(24)
            //   .height(24)
            // 收藏图标
            Text.create('♡');
            // Image($r('app.media.ic_favorite'))
            //   .width(24)
            //   .height(24)
            // 收藏图标
            Text.fontSize(20);
            // Image($r('app.media.ic_favorite'))
            //   .width(24)
            //   .height(24)
            // 收藏图标
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
        }, Text);
        // Image($r('app.media.ic_favorite'))
        //   .width(24)
        //   .height(24)
        // 收藏图标
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777236, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel({ "id": 16777221, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Button.fontSize(NORMAL_FONT_SIZE);
            Button.fontColor(this.currentThemeColors.cardBackgroundColor);
            Button.backgroundColor('#FF9800');
            Button.height(BUTTON_HEIGHT);
            Button.borderRadius(BUTTON_BORDER_RADIUS);
            Button.layoutWeight(1);
            Button.onClick(() => {
                // 加入购物车逻辑
            });
        }, Button);
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel({ "id": 16777225, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Button.fontSize(NORMAL_FONT_SIZE);
            Button.fontColor(this.currentThemeColors.cardBackgroundColor);
            Button.backgroundColor(this.currentThemeColors.accentColor);
            Button.height(BUTTON_HEIGHT);
            Button.borderRadius(BUTTON_BORDER_RADIUS);
            Button.layoutWeight(1);
            Button.onClick(() => {
                // 立即购买逻辑
            });
        }, Button);
        Button.pop();
        Row.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
            Column.height(LAYOUT_WIDTH_OR_HEIGHT);
            Column.backgroundColor(this.currentThemeColors.backgroundColor);
            Column.padding({ top: 34 });
        }, Column);
        // 顶部导航栏
        this.TopNavigationBar.bind(this)();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 可滚动内容区域
            Scroll.create();
            // 可滚动内容区域
            Scroll.layoutWeight(1);
            // 可滚动内容区域
            Scroll.backgroundColor(this.currentThemeColors.backgroundColor);
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
        }, Column);
        // 商品图片轮播
        this.GoodsImageSwiper.bind(this)();
        // 商品信息
        this.GoodsInfoSection.bind(this)();
        // 数量选择器
        this.QuantitySelector.bind(this)();
        // 商品描述
        this.GoodsDescription.bind(this)();
        Column.pop();
        // 可滚动内容区域
        Scroll.pop();
        // 底部操作栏
        this.BottomActionBar.bind(this)();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "GoodsDetailPage";
    }
}
registerNamedRoute(() => new GoodsDetailPage(undefined, {}), "", { bundleName: "com.example.list_harmony", moduleName: "entry", pagePath: "pages/GoodsDetailPage", pageFullPath: "entry/src/main/ets/pages/GoodsDetailPage", integratedHsp: "false", moduleType: "followWithHap" });
