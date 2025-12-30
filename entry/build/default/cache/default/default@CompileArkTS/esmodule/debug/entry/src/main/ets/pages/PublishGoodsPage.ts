if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface PublishGoodsPage_Params {
    goodsName?: string;
    goodsDescription?: string;
    goodsPrice?: string;
    goodsImage?: Resource;
    currentThemeColors?: ThemeColors;
    dataSource?: ListDataSource;
}
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, BIGGER_FONT_SIZE } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
import { GoodsListItemType } from "@bundle:com.example.list_harmony/entry/ets/viewmodel/InitialData";
import { ListDataSource } from "@bundle:com.example.list_harmony/entry/ets/viewmodel/ListDataSource";
import { DEFAULT_THEME } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import type { ThemeColors } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import router from "@ohos:router";
export default class PublishGoodsPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__goodsName = new ObservedPropertySimplePU('', this, "goodsName");
        this.__goodsDescription = new ObservedPropertySimplePU('', this, "goodsDescription");
        this.__goodsPrice = new ObservedPropertySimplePU('', this, "goodsPrice");
        this.__goodsImage = new ObservedPropertyObjectPU({ "id": 16777294, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, this, "goodsImage");
        this.__currentThemeColors = this.createStorageLink('themeColors', DEFAULT_THEME, "currentThemeColors");
        this.dataSource = ListDataSource.getInstance();
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: PublishGoodsPage_Params) {
        if (params.goodsName !== undefined) {
            this.goodsName = params.goodsName;
        }
        if (params.goodsDescription !== undefined) {
            this.goodsDescription = params.goodsDescription;
        }
        if (params.goodsPrice !== undefined) {
            this.goodsPrice = params.goodsPrice;
        }
        if (params.goodsImage !== undefined) {
            this.goodsImage = params.goodsImage;
        }
        if (params.dataSource !== undefined) {
            this.dataSource = params.dataSource;
        }
    }
    updateStateVars(params: PublishGoodsPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__goodsName.purgeDependencyOnElmtId(rmElmtId);
        this.__goodsDescription.purgeDependencyOnElmtId(rmElmtId);
        this.__goodsPrice.purgeDependencyOnElmtId(rmElmtId);
        this.__goodsImage.purgeDependencyOnElmtId(rmElmtId);
        this.__currentThemeColors.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__goodsName.aboutToBeDeleted();
        this.__goodsDescription.aboutToBeDeleted();
        this.__goodsPrice.aboutToBeDeleted();
        this.__goodsImage.aboutToBeDeleted();
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
    private __goodsDescription: ObservedPropertySimplePU<string>;
    get goodsDescription() {
        return this.__goodsDescription.get();
    }
    set goodsDescription(newValue: string) {
        this.__goodsDescription.set(newValue);
    }
    private __goodsPrice: ObservedPropertySimplePU<string>;
    get goodsPrice() {
        return this.__goodsPrice.get();
    }
    set goodsPrice(newValue: string) {
        this.__goodsPrice.set(newValue);
    }
    private __goodsImage: ObservedPropertyObjectPU<Resource>; // 默认图片
    get goodsImage() {
        return this.__goodsImage.get();
    }
    set goodsImage(newValue: Resource) {
        this.__goodsImage.set(newValue);
    }
    private __currentThemeColors: ObservedPropertyAbstractPU<ThemeColors>;
    get currentThemeColors() {
        return this.__currentThemeColors.get();
    }
    set currentThemeColors(newValue: ThemeColors) {
        this.__currentThemeColors.set(newValue);
    }
    private dataSource: ListDataSource;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Scroll.create();
            Scroll.width(LAYOUT_WIDTH_OR_HEIGHT);
            Scroll.height(LAYOUT_WIDTH_OR_HEIGHT);
            Scroll.backgroundColor(this.currentThemeColors.backgroundColor);
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 16 });
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
            Column.padding(16);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 标题
            Text.create({ "id": 16777318, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            // 标题
            Text.fontSize(BIGGER_FONT_SIZE);
            // 标题
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            // 标题
            Text.fontWeight(FontWeight.Bold);
            // 标题
            Text.margin({ top: 16 });
        }, Text);
        // 标题
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 商品名称
            Column.create({ space: 8 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('商品名称');
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({ placeholder: '请输入商品名称', text: this.goodsName });
            TextInput.width(LAYOUT_WIDTH_OR_HEIGHT);
            TextInput.height(48);
            TextInput.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            TextInput.borderRadius(8);
            TextInput.padding(8);
            TextInput.onChange((value: string) => {
                this.goodsName = value;
            });
        }, TextInput);
        // 商品名称
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 商品描述
            Column.create({ space: 8 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('商品描述');
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({ placeholder: '请输入商品描述', text: this.goodsDescription });
            TextInput.width(LAYOUT_WIDTH_OR_HEIGHT);
            TextInput.height(80);
            TextInput.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            TextInput.borderRadius(8);
            TextInput.padding(8);
            TextInput.onChange((value: string) => {
                this.goodsDescription = value;
            });
        }, TextInput);
        // 商品描述
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 商品价格
            Column.create({ space: 8 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('商品价格');
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({ placeholder: '请输入商品价格', text: this.goodsPrice });
            TextInput.width(LAYOUT_WIDTH_OR_HEIGHT);
            TextInput.height(48);
            TextInput.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            TextInput.borderRadius(8);
            TextInput.padding(8);
            TextInput.type(InputType.Number);
            TextInput.onChange((value: string) => {
                this.goodsPrice = value;
            });
        }, TextInput);
        // 商品价格
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 商品图片（可选）
            Column.create({ space: 8 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('商品图片 (可选)');
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 16 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(this.goodsImage);
            Image.width(100);
            Image.height(100);
            Image.borderRadius(8);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel('选择图片');
            Button.fontSize(NORMAL_FONT_SIZE);
            Button.backgroundColor(this.currentThemeColors.accentColor);
            Button.fontColor(Color.White);
            Button.borderRadius(8);
            Button.onClick(() => {
                // 选择图片逻辑（暂时使用默认图片）
                // 这里可以集成图片选择器
            });
        }, Button);
        Button.pop();
        Row.pop();
        // 商品图片（可选）
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 发布按钮
            Button.createWithLabel('发布商品');
            // 发布按钮
            Button.fontSize(NORMAL_FONT_SIZE);
            // 发布按钮
            Button.backgroundColor(this.currentThemeColors.accentColor);
            // 发布按钮
            Button.fontColor(Color.White);
            // 发布按钮
            Button.width(LAYOUT_WIDTH_OR_HEIGHT);
            // 发布按钮
            Button.height(48);
            // 发布按钮
            Button.borderRadius(8);
            // 发布按钮
            Button.margin({ top: 32 });
            // 发布按钮
            Button.onClick(() => {
                this.publishGoods();
            });
        }, Button);
        // 发布按钮
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 返回按钮
            Button.createWithLabel('返回');
            // 返回按钮
            Button.fontSize(NORMAL_FONT_SIZE);
            // 返回按钮
            Button.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            // 返回按钮
            Button.fontColor(this.currentThemeColors.primaryTextColor);
            // 返回按钮
            Button.width(LAYOUT_WIDTH_OR_HEIGHT);
            // 返回按钮
            Button.height(48);
            // 返回按钮
            Button.borderRadius(8);
            // 返回按钮
            Button.onClick(() => {
                router.back();
            });
        }, Button);
        // 返回按钮
        Button.pop();
        Column.pop();
        Scroll.pop();
    }
    private publishGoods(): void {
        if (this.goodsName.trim() === '' || this.goodsPrice.trim() === '') {
            // 显示错误提示
            return;
        }
        const newItem = new GoodsListItemType(Date.now(), this.goodsImage, this.goodsName, this.goodsPrice);
        newItem.advertisingLanguage = this.goodsDescription || '暂无描述';
        newItem.evaluate = '新发布';
        this.dataSource.addNewItem(newItem);
        // 返回上一页
        router.back();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "PublishGoodsPage";
    }
}
registerNamedRoute(() => new PublishGoodsPage(undefined, {}), "", { bundleName: "com.example.list_harmony", moduleName: "entry", pagePath: "pages/PublishGoodsPage", pageFullPath: "entry/src/main/ets/pages/PublishGoodsPage", integratedHsp: "false", moduleType: "followWithHap" });
