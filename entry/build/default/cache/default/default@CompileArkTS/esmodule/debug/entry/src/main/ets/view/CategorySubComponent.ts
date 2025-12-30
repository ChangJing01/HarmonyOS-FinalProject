if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface CategorySub_Params {
    selectedSubCategoryIndex?: number;
    subCategories?: SubCategoryItem[];
}
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, SMALL_FONT_SIZE, CATEGORY_LIST_WIDTH, CATEGORY_ITEM_HEIGHT } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
export interface SubCategoryItem {
    id: number;
    name: Resource;
}
export default class CategorySub extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__selectedSubCategoryIndex = new SynchedPropertySimpleTwoWayPU(params.selectedSubCategoryIndex, this, "selectedSubCategoryIndex");
        this.__subCategories = new SynchedPropertyObjectOneWayPU(params.subCategories, this, "subCategories");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: CategorySub_Params) {
    }
    updateStateVars(params: CategorySub_Params) {
        this.__subCategories.reset(params.subCategories);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__selectedSubCategoryIndex.purgeDependencyOnElmtId(rmElmtId);
        this.__subCategories.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__selectedSubCategoryIndex.aboutToBeDeleted();
        this.__subCategories.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __selectedSubCategoryIndex: SynchedPropertySimpleTwoWayPU<number>;
    get selectedSubCategoryIndex() {
        return this.__selectedSubCategoryIndex.get();
    }
    set selectedSubCategoryIndex(newValue: number) {
        this.__selectedSubCategoryIndex.set(newValue);
    }
    private __subCategories: SynchedPropertySimpleOneWayPU<SubCategoryItem[]>;
    get subCategories() {
        return this.__subCategories.get();
    }
    set subCategories(newValue: SubCategoryItem[]) {
        this.__subCategories.set(newValue);
    }
    SubCategoryItem(item: SubCategoryItem, index: number, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width(CATEGORY_LIST_WIDTH);
            Column.height(CATEGORY_ITEM_HEIGHT);
            Column.justifyContent(FlexAlign.Center);
            Column.backgroundColor(this.selectedSubCategoryIndex === index ? '#FFF5F5' : '#FFFFFF');
            Column.borderRadius(4);
            Column.onClick(() => {
                this.selectedSubCategoryIndex = index;
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item.name);
            Text.fontSize(this.selectedSubCategoryIndex === index ? NORMAL_FONT_SIZE : SMALL_FONT_SIZE);
            Text.fontColor(this.selectedSubCategoryIndex === index ? '#FF4D4F' : '#333333');
            Text.fontWeight(this.selectedSubCategoryIndex === index ? FontWeight.Medium : FontWeight.Normal);
        }, Text);
        Text.pop();
        Column.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Scroll.create();
            Scroll.scrollBar(BarState.Off);
            Scroll.width(LAYOUT_WIDTH_OR_HEIGHT);
            Scroll.backgroundColor('#F5F5F5');
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 8 });
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
            Column.padding({ left: 16, right: 16, top: 12, bottom: 12 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = (_item, index?: number) => {
                const item = _item;
                this.SubCategoryItem.bind(this)(item, index !== undefined ? index : 0);
            };
            this.forEachUpdateFunction(elmtId, this.subCategories, forEachItemGenFunction, undefined, true, false);
        }, ForEach);
        ForEach.pop();
        Column.pop();
        Scroll.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
