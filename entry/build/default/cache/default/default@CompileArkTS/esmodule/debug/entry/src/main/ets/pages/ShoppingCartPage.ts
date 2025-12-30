if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface ShoppingCartPage_Params {
    cartItems?: CartItem[];
    isAllSelected?: boolean;
    totalPrice?: number;
    currentThemeColors?: ThemeColors;
}
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, BIGGER_FONT_SIZE, SMALL_FONT_SIZE, BUTTON_HEIGHT, BUTTON_BORDER_RADIUS } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
import { DEFAULT_THEME } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import type { ThemeColors } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
interface CartItem {
    id: number;
    name: Resource;
    price: string;
    quantity: number;
    image: Resource;
    selected: boolean;
}
export default class ShoppingCartPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__cartItems = new ObservedPropertyObjectPU([
            {
                id: 1,
                name: { "id": 16777238, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                price: '¥199',
                quantity: 1,
                image: { "id": 16777294, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                selected: false
            },
            {
                id: 2,
                name: { "id": 16777223, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                price: '¥265',
                quantity: 2,
                image: { "id": 16777295, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                selected: false
            }
        ], this, "cartItems");
        this.__isAllSelected = new ObservedPropertySimplePU(false, this, "isAllSelected");
        this.__totalPrice = new ObservedPropertySimplePU(0, this, "totalPrice");
        this.__currentThemeColors = this.createStorageLink('themeColors', DEFAULT_THEME, "currentThemeColors");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: ShoppingCartPage_Params) {
        if (params.cartItems !== undefined) {
            this.cartItems = params.cartItems;
        }
        if (params.isAllSelected !== undefined) {
            this.isAllSelected = params.isAllSelected;
        }
        if (params.totalPrice !== undefined) {
            this.totalPrice = params.totalPrice;
        }
    }
    updateStateVars(params: ShoppingCartPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__cartItems.purgeDependencyOnElmtId(rmElmtId);
        this.__isAllSelected.purgeDependencyOnElmtId(rmElmtId);
        this.__totalPrice.purgeDependencyOnElmtId(rmElmtId);
        this.__currentThemeColors.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__cartItems.aboutToBeDeleted();
        this.__isAllSelected.aboutToBeDeleted();
        this.__totalPrice.aboutToBeDeleted();
        this.__currentThemeColors.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __cartItems: ObservedPropertyObjectPU<CartItem[]>;
    get cartItems() {
        return this.__cartItems.get();
    }
    set cartItems(newValue: CartItem[]) {
        this.__cartItems.set(newValue);
    }
    private __isAllSelected: ObservedPropertySimplePU<boolean>;
    get isAllSelected() {
        return this.__isAllSelected.get();
    }
    set isAllSelected(newValue: boolean) {
        this.__isAllSelected.set(newValue);
    }
    private __totalPrice: ObservedPropertySimplePU<number>;
    get totalPrice() {
        return this.__totalPrice.get();
    }
    set totalPrice(newValue: number) {
        this.__totalPrice.set(newValue);
    }
    private __currentThemeColors: ObservedPropertyAbstractPU<ThemeColors>; //使用 @StorageLink 确保当 PersonalPage 改变主题时，这里会自动刷新
    get currentThemeColors() {
        return this.__currentThemeColors.get();
    }
    set currentThemeColors(newValue: ThemeColors) {
        this.__currentThemeColors.set(newValue);
    }
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
    CartItemBuilder(item: CartItem, index: number, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 12 });
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.padding(12);
            Row.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            Row.borderRadius(8);
            Row.alignItems(VerticalAlign.Top);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 选择框
            Checkbox.create();
            // 选择框
            Checkbox.select(item.selected);
            // 选择框
            Checkbox.selectedColor(this.currentThemeColors.accentColor);
            // 选择框
            Checkbox.onChange((value: boolean) => {
                this.toggleItemSelect(index);
            });
        }, Checkbox);
        // 选择框
        Checkbox.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 商品图片
            Image.create(item.image);
            // 商品图片
            Image.width(80);
            // 商品图片
            Image.height(80);
            // 商品图片
            Image.borderRadius(8);
            // 商品图片
            Image.objectFit(ImageFit.Cover);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 商品信息
            Column.create({ space: 8 });
            // 商品信息
            Column.alignItems(HorizontalAlign.Start);
            // 商品信息
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item.name);
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.maxLines(2);
            Text.textOverflow({ overflow: TextOverflow.Ellipsis });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item.price);
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.accentColor);
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 数量选择器
            Row.create({ space: 8 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel('-');
            Button.width(28);
            Button.height(28);
            Button.fontSize(NORMAL_FONT_SIZE);
            Button.backgroundColor(item.quantity <= 1 ? this.currentThemeColors.tabUnselectedColor : this.currentThemeColors.accentColor);
            Button.fontColor(item.quantity <= 1 ? this.currentThemeColors.secondaryTextColor : this.currentThemeColors.accentColor);
            Button.enabled(item.quantity > 1);
            Button.onClick(() => {
                this.updateQuantity(index, -1);
            });
        }, Button);
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item.quantity.toString());
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.width(32);
            Text.textAlign(TextAlign.Center);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel('+');
            Button.width(28);
            Button.height(28);
            Button.fontSize(NORMAL_FONT_SIZE);
            Button.backgroundColor(this.currentThemeColors.accentColor);
            Button.fontColor(this.currentThemeColors.primaryTextColor);
            Button.onClick(() => {
                this.updateQuantity(index, 1);
            });
        }, Button);
        Button.pop();
        // 数量选择器
        Row.pop();
        // 商品信息
        Column.pop();
        Row.pop();
    }
    EmptyCartBuilder(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 16 });
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
            Column.height(LAYOUT_WIDTH_OR_HEIGHT);
            Column.justifyContent(FlexAlign.Center);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Image($r('app.media.ic_empty_cart'))
            //   .width(120)
            //   .height(120)
            // 空购物车图标
            Circle.create();
            // Image($r('app.media.ic_empty_cart'))
            //   .width(120)
            //   .height(120)
            // 空购物车图标
            Circle.width(120);
            // Image($r('app.media.ic_empty_cart'))
            //   .width(120)
            //   .height(120)
            // 空购物车图标
            Circle.height(120);
            // Image($r('app.media.ic_empty_cart'))
            //   .width(120)
            //   .height(120)
            // 空购物车图标
            Circle.fill('#E0E0E0');
        }, Circle);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777233, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor('#999999');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel({ "id": 16777237, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Button.fontSize(NORMAL_FONT_SIZE);
            Button.fontColor('#FFFFFF');
            Button.backgroundColor(this.currentThemeColors.accentColor);
            Button.height(BUTTON_HEIGHT);
            Button.borderRadius(BUTTON_BORDER_RADIUS);
            Button.width(200);
        }, Button);
        Button.pop();
        Column.pop();
    }
    BottomBar(parent = null) {
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
            // 全选
            Row.create({ space: 8 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Checkbox.create();
            Checkbox.select(this.isAllSelected);
            Checkbox.selectedColor(this.currentThemeColors.accentColor);
            Checkbox.onChange(() => {
                this.toggleSelectAll();
            });
        }, Checkbox);
        Checkbox.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777270, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
        }, Text);
        Text.pop();
        // 全选
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 总价
            Column.create({ space: 4 });
            // 总价
            Column.layoutWeight(1);
            // 总价
            Column.alignItems(HorizontalAlign.End);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 4 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777287, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('¥' + this.totalPrice.toFixed(2));
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.accentColor);
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        Row.pop();
        // 总价
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 结算按钮
            Button.createWithLabel({ "id": 16777227, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            // 结算按钮
            Button.fontSize(NORMAL_FONT_SIZE);
            // 结算按钮
            Button.fontColor('#FFFFFF');
            // 结算按钮
            Button.backgroundColor(this.currentThemeColors.accentColor);
            // 结算按钮
            Button.height(BUTTON_HEIGHT);
            // 结算按钮
            Button.borderRadius(BUTTON_BORDER_RADIUS);
            // 结算按钮
            Button.width(120);
        }, Button);
        // 结算按钮
        Button.pop();
        Row.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
            Column.height(LAYOUT_WIDTH_OR_HEIGHT);
            Column.backgroundColor(this.currentThemeColors.backgroundColor);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.cartItems.length === 0) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.EmptyCartBuilder.bind(this)();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        // 购物车列表
                        List.create({ space: 8 });
                        // 购物车列表
                        List.layoutWeight(1);
                        // 购物车列表
                        List.padding(8);
                        // 购物车列表
                        List.backgroundColor(this.currentThemeColors.backgroundColor);
                    }, List);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        ForEach.create();
                        const forEachItemGenFunction = (_item, index?: number) => {
                            const item = _item;
                            {
                                const itemCreation = (elmtId, isInitialRender) => {
                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                    ListItem.create(deepRenderFunction, true);
                                    if (!isInitialRender) {
                                        ListItem.pop();
                                    }
                                    ViewStackProcessor.StopGetAccessRecording();
                                };
                                const itemCreation2 = (elmtId, isInitialRender) => {
                                    ListItem.create(deepRenderFunction, true);
                                };
                                const deepRenderFunction = (elmtId, isInitialRender) => {
                                    itemCreation(elmtId, isInitialRender);
                                    this.CartItemBuilder.bind(this)(item, index !== undefined ? index : 0);
                                    ListItem.pop();
                                };
                                this.observeComponentCreation2(itemCreation2, ListItem);
                                ListItem.pop();
                            }
                        };
                        this.forEachUpdateFunction(elmtId, this.cartItems, forEachItemGenFunction, undefined, true, false);
                    }, ForEach);
                    ForEach.pop();
                    // 购物车列表
                    List.pop();
                    // 底部操作栏
                    this.BottomBar.bind(this)();
                });
            }
        }, If);
        If.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
