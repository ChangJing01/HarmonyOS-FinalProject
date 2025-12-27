if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface CategoryPage_Params {
    selectedCategoryIndex?: number;
    selectedSubCategoryIndex?: number;
    showSubCategory?: boolean;
    currentThemeColors?: ThemeColors;
    categoryData?: CategoryData[];
}
import CategoryTab from "@bundle:com.example.list_harmony/entry/ets/view/CategoryTabComponent";
import type { CategoryData, SubCategoryData } from "@bundle:com.example.list_harmony/entry/ets/view/CategoryTabComponent";
import CategorySub from "@bundle:com.example.list_harmony/entry/ets/view/CategorySubComponent";
import GoodsList from "@bundle:com.example.list_harmony/entry/ets/view/GoodsListComponent";
import { LAYOUT_WIDTH_OR_HEIGHT } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
import { DEFAULT_THEME } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import type { ThemeColors } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
export default class CategoryPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__selectedCategoryIndex = new ObservedPropertySimplePU(0, this, "selectedCategoryIndex");
        this.__selectedSubCategoryIndex = new ObservedPropertySimplePU(0, this, "selectedSubCategoryIndex");
        this.__showSubCategory = new ObservedPropertySimplePU(true, this, "showSubCategory");
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
    setInitiallyProvidedValue(params: CategoryPage_Params) {
        if (params.selectedCategoryIndex !== undefined) {
            this.selectedCategoryIndex = params.selectedCategoryIndex;
        }
        if (params.selectedSubCategoryIndex !== undefined) {
            this.selectedSubCategoryIndex = params.selectedSubCategoryIndex;
        }
        if (params.showSubCategory !== undefined) {
            this.showSubCategory = params.showSubCategory;
        }
        if (params.categoryData !== undefined) {
            this.categoryData = params.categoryData;
        }
    }
    updateStateVars(params: CategoryPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__selectedCategoryIndex.purgeDependencyOnElmtId(rmElmtId);
        this.__selectedSubCategoryIndex.purgeDependencyOnElmtId(rmElmtId);
        this.__showSubCategory.purgeDependencyOnElmtId(rmElmtId);
        this.__currentThemeColors.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__selectedCategoryIndex.aboutToBeDeleted();
        this.__selectedSubCategoryIndex.aboutToBeDeleted();
        this.__showSubCategory.aboutToBeDeleted();
        this.__currentThemeColors.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __selectedCategoryIndex: ObservedPropertySimplePU<number>;
    get selectedCategoryIndex() {
        return this.__selectedCategoryIndex.get();
    }
    set selectedCategoryIndex(newValue: number) {
        this.__selectedCategoryIndex.set(newValue);
    }
    private __selectedSubCategoryIndex: ObservedPropertySimplePU<number>;
    get selectedSubCategoryIndex() {
        return this.__selectedSubCategoryIndex.get();
    }
    set selectedSubCategoryIndex(newValue: number) {
        this.__selectedSubCategoryIndex.set(newValue);
    }
    private __showSubCategory: ObservedPropertySimplePU<boolean>;
    get showSubCategory() {
        return this.__showSubCategory.get();
    }
    set showSubCategory(newValue: boolean) {
        this.__showSubCategory.set(newValue);
    }
    private __currentThemeColors: ObservedPropertyAbstractPU<ThemeColors>;
    get currentThemeColors() {
        return this.__currentThemeColors.get();
    }
    set currentThemeColors(newValue: ThemeColors) {
        this.__currentThemeColors.set(newValue);
    }
    private categoryData: CategoryData[];
    getSubCategoriesForCurrentTab(): SubCategoryData[] {
        return this.categoryData[this.selectedCategoryIndex].subCategories;
    }
    getCurrentSubCategoryName(): Resource {
        const subCategories = this.getSubCategoriesForCurrentTab();
        return subCategories[this.selectedSubCategoryIndex].name;
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
            Column.height(LAYOUT_WIDTH_OR_HEIGHT);
            Column.backgroundColor('#F5F5F5');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 一级分类 Tab（横向）
            Row.create();
            // 一级分类 Tab（横向）
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.layoutWeight(1);
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new CategoryTab(this, {
                        selectedCategoryIndex: this.__selectedCategoryIndex,
                        selectedSubCategoryIndex: this.__selectedSubCategoryIndex
                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/CategoryPage.ets", line: 92, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            selectedCategoryIndex: this.selectedCategoryIndex,
                            selectedSubCategoryIndex: this.selectedSubCategoryIndex
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "CategoryTab" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 切换左侧栏显示/隐藏按钮
            Text.create(this.showSubCategory ? '◀' : '▶');
            // 切换左侧栏显示/隐藏按钮
            Text.fontSize(16);
            // 切换左侧栏显示/隐藏按钮
            Text.fontColor('#666666');
            // 切换左侧栏显示/隐藏按钮
            Text.width(40);
            // 切换左侧栏显示/隐藏按钮
            Text.height(56);
            // 切换左侧栏显示/隐藏按钮
            Text.textAlign(TextAlign.Center);
            // 切换左侧栏显示/隐藏按钮
            Text.backgroundColor('#FFFFFF');
            // 切换左侧栏显示/隐藏按钮
            Text.onClick(() => {
                this.showSubCategory = !this.showSubCategory;
            });
        }, Text);
        // 切换左侧栏显示/隐藏按钮
        Text.pop();
        // 一级分类 Tab（横向）
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 二级分类和商品列表（左右分栏）
            Row.create();
            // 二级分类和商品列表（左右分栏）
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            // 二级分类和商品列表（左右分栏）
            Row.layoutWeight(1);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.width(this.showSubCategory ? '25%' : '0%');
            __Common__.visibility(this.showSubCategory ? Visibility.Visible : Visibility.Hidden);
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // 左侧：二级子分类（可隐藏）
                    CategorySub(this, {
                        selectedSubCategoryIndex: this.__selectedSubCategoryIndex,
                        subCategories: this.getSubCategoriesForCurrentTab()
                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/CategoryPage.ets", line: 115, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            selectedSubCategoryIndex: this.selectedSubCategoryIndex,
                            subCategories: this.getSubCategoriesForCurrentTab()
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        subCategories: this.getSubCategoriesForCurrentTab()
                    });
                }
            }, { name: "CategorySub" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.layoutWeight(1);
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // 右侧：商品列表
                    GoodsList(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/CategoryPage.ets", line: 123, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {};
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "GoodsList" });
        }
        __Common__.pop();
        // 二级分类和商品列表（左右分栏）
        Row.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
