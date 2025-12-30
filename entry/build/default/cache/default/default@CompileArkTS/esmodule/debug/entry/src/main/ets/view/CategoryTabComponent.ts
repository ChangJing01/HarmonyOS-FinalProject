if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface CategoryTab_Params {
    selectedCategoryIndex?: number;
    selectedSubCategoryIndex?: number;
    currentThemeColors?: ThemeColors;
    categoryData?: CategoryData[];
}
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, BIGGER_FONT_SIZE, GOODS_EVALUATE_FONT_SIZE, MAX_LINES_TEXT } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
import { DEFAULT_THEME } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import type { ThemeColors } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
export interface CategoryData {
    id: number;
    name: Resource;
    subCategories: SubCategoryData[];
}
export interface SubCategoryData {
    id: number;
    name: Resource;
}
export default class CategoryTab extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__selectedCategoryIndex = new SynchedPropertySimpleTwoWayPU(params.selectedCategoryIndex, this, "selectedCategoryIndex");
        this.__selectedSubCategoryIndex = new SynchedPropertySimpleTwoWayPU(params.selectedSubCategoryIndex, this, "selectedSubCategoryIndex");
        this.__currentThemeColors = this.createStorageLink('themeColors', DEFAULT_THEME, "currentThemeColors");
        this.categoryData = [
            {
                id: 0,
                name: { "id": 16777271, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                subCategories: [
                    { id: 0, name: { "id": 16777274, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 1, name: { "id": 16777280, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 2, name: { "id": 16777283, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } }
                ]
            },
            {
                id: 1,
                name: { "id": 16777247, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                subCategories: [
                    { id: 0, name: { "id": 16777274, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 1, name: { "id": 16777275, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 2, name: { "id": 16777281, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } }
                ]
            },
            {
                id: 2,
                name: { "id": 16777230, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                subCategories: [
                    { id: 0, name: { "id": 16777274, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 1, name: { "id": 16777282, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 2, name: { "id": 16777284, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } }
                ]
            },
            {
                id: 3,
                name: { "id": 16777288, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                subCategories: [
                    { id: 0, name: { "id": 16777274, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 1, name: { "id": 16777276, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 2, name: { "id": 16777278, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } }
                ]
            },
            {
                id: 4,
                name: { "id": 16777243, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                subCategories: [
                    { id: 0, name: { "id": 16777274, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 1, name: { "id": 16777279, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 2, name: { "id": 16777277, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } }
                ]
            }
        ];
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: CategoryTab_Params) {
        if (params.categoryData !== undefined) {
            this.categoryData = params.categoryData;
        }
    }
    updateStateVars(params: CategoryTab_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__selectedCategoryIndex.purgeDependencyOnElmtId(rmElmtId);
        this.__selectedSubCategoryIndex.purgeDependencyOnElmtId(rmElmtId);
        this.__currentThemeColors.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__selectedCategoryIndex.aboutToBeDeleted();
        this.__selectedSubCategoryIndex.aboutToBeDeleted();
        this.__currentThemeColors.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __selectedCategoryIndex: SynchedPropertySimpleTwoWayPU<number>;
    get selectedCategoryIndex() {
        return this.__selectedCategoryIndex.get();
    }
    set selectedCategoryIndex(newValue: number) {
        this.__selectedCategoryIndex.set(newValue);
    }
    private __selectedSubCategoryIndex: SynchedPropertySimpleTwoWayPU<number>;
    get selectedSubCategoryIndex() {
        return this.__selectedSubCategoryIndex.get();
    }
    set selectedSubCategoryIndex(newValue: number) {
        this.__selectedSubCategoryIndex.set(newValue);
    }
    private __currentThemeColors: ObservedPropertyAbstractPU<ThemeColors>;
    get currentThemeColors() {
        return this.__currentThemeColors.get();
    }
    set currentThemeColors(newValue: ThemeColors) {
        this.__currentThemeColors.set(newValue);
    }
    private categoryData: CategoryData[];
    TabItem(item: CategoryData, index: number, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.padding({ left: 12, right: 12 });
            Column.height(56);
            Column.justifyContent(FlexAlign.Center);
            Column.onClick(() => {
                this.selectedCategoryIndex = index;
                this.selectedSubCategoryIndex = 0;
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item.name);
            Text.fontSize(this.selectedCategoryIndex === index ? BIGGER_FONT_SIZE : NORMAL_FONT_SIZE);
            Text.fontColor(this.selectedCategoryIndex === index ? this.currentThemeColors.primaryTextColor : this.currentThemeColors.secondaryTextColor);
            Text.maxLines(MAX_LINES_TEXT);
            Text.minFontSize(this.selectedCategoryIndex === index ? NORMAL_FONT_SIZE : GOODS_EVALUATE_FONT_SIZE);
            Text.maxFontSize(this.selectedCategoryIndex === index ? BIGGER_FONT_SIZE : NORMAL_FONT_SIZE);
            Text.fontWeight(this.selectedCategoryIndex === index ? FontWeight.Bold : FontWeight.Normal);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.selectedCategoryIndex === index) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Divider.create();
                        Divider.width(40);
                        Divider.height(3);
                        Divider.color(this.currentThemeColors.accentColor);
                        Divider.margin({ top: 4 });
                    }, Divider);
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        Column.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Scroll.create();
            Scroll.scrollable(ScrollDirection.Horizontal);
            Scroll.scrollBar(BarState.Off);
            Scroll.width(LAYOUT_WIDTH_OR_HEIGHT);
            Scroll.height(56);
            Scroll.backgroundColor(this.currentThemeColors.cardBackgroundColor);
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 12 });
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.padding({ left: 8, right: 8 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = (_item, index?: number) => {
                const item = _item;
                this.TabItem.bind(this)(item, index !== undefined ? index : 0);
            };
            this.forEachUpdateFunction(elmtId, this.categoryData, forEachItemGenFunction, undefined, true, false);
        }, ForEach);
        ForEach.pop();
        Row.pop();
        Scroll.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
