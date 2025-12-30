if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface CategoryTab_Params {
    selectedCategoryIndex?: number;
    selectedSubCategoryIndex?: number;
    categoryData?: CategoryData[];
}
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, BIGGER_FONT_SIZE, GOODS_EVALUATE_FONT_SIZE, MAX_LINES_TEXT } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
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
        this.categoryData = [
            {
                id: 0,
                name: { "id": 16777283, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                subCategories: [
                    { id: 0, name: { "id": 16777286, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 1, name: { "id": 16777292, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 2, name: { "id": 16777295, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } }
                ]
            },
            {
                id: 1,
                name: { "id": 16777259, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                subCategories: [
                    { id: 0, name: { "id": 16777286, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 1, name: { "id": 16777287, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 2, name: { "id": 16777293, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } }
                ]
            },
            {
                id: 2,
                name: { "id": 16777242, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                subCategories: [
                    { id: 0, name: { "id": 16777286, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 1, name: { "id": 16777294, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 2, name: { "id": 16777296, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } }
                ]
            },
            {
                id: 3,
                name: { "id": 16777300, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                subCategories: [
                    { id: 0, name: { "id": 16777286, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 1, name: { "id": 16777288, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 2, name: { "id": 16777290, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } }
                ]
            },
            {
                id: 4,
                name: { "id": 16777255, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
                subCategories: [
                    { id: 0, name: { "id": 16777286, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 1, name: { "id": 16777291, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } },
                    { id: 2, name: { "id": 16777289, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" } }
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
    }
    aboutToBeDeleted() {
        this.__selectedCategoryIndex.aboutToBeDeleted();
        this.__selectedSubCategoryIndex.aboutToBeDeleted();
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
    private categoryData: CategoryData[];
    TabItem(item: CategoryData, index: number, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/view/CategoryTabComponent.ets(89:5)", "entry");
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
            Text.debugLine("entry/src/main/ets/view/CategoryTabComponent.ets(90:7)", "entry");
            Text.fontSize(this.selectedCategoryIndex === index ? BIGGER_FONT_SIZE : NORMAL_FONT_SIZE);
            Text.fontColor(this.selectedCategoryIndex === index ? Color.Black : { "id": 16777308, "type": 10001, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
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
                        Divider.debugLine("entry/src/main/ets/view/CategoryTabComponent.ets(99:9)", "entry");
                        Divider.width(40);
                        Divider.height(3);
                        Divider.color('#FF4D4F');
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
            Scroll.debugLine("entry/src/main/ets/view/CategoryTabComponent.ets(116:5)", "entry");
            Scroll.scrollable(ScrollDirection.Horizontal);
            Scroll.scrollBar(BarState.Off);
            Scroll.width(LAYOUT_WIDTH_OR_HEIGHT);
            Scroll.height(56);
            Scroll.backgroundColor('#FFFFFF');
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 12 });
            Row.debugLine("entry/src/main/ets/view/CategoryTabComponent.ets(117:7)", "entry");
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
