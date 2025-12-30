if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface GoodsList_Params {
    goodsListData?: ListDataSource;
    startTouchOffsetY?: number;
    endTouchOffsetY?: number;
}
import * as commonConst from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
import type { GoodsListItemType } from '../viewmodel/InitialData';
import { ListDataSource } from "@bundle:com.example.list_harmony/entry/ets/viewmodel/ListDataSource";
export default class GoodsList extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__goodsListData = new ObservedPropertyObjectPU(new ListDataSource(), this, "goodsListData");
        this.addProvidedVar("goodsListData", this.__goodsListData, false);
        this.startTouchOffsetY = 0;
        this.endTouchOffsetY = 0;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: GoodsList_Params) {
        if (params.goodsListData !== undefined) {
            this.goodsListData = params.goodsListData;
        }
        if (params.startTouchOffsetY !== undefined) {
            this.startTouchOffsetY = params.startTouchOffsetY;
        }
        if (params.endTouchOffsetY !== undefined) {
            this.endTouchOffsetY = params.endTouchOffsetY;
        }
    }
    updateStateVars(params: GoodsList_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__goodsListData.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__goodsListData.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __goodsListData: ObservedPropertyObjectPU<ListDataSource>;
    get goodsListData() {
        return this.__goodsListData.get();
    }
    set goodsListData(newValue: ListDataSource) {
        this.__goodsListData.set(newValue);
    }
    private startTouchOffsetY: number;
    private endTouchOffsetY: number;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.justifyContent(FlexAlign.Center);
            Row.width(commonConst.LAYOUT_WIDTH_OR_HEIGHT);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            List.create({ space: commonConst.LIST_ITEM_SPACE });
            List.width(commonConst.GOODS_LIST_WIDTH);
        }, List);
        {
            const __lazyForEachItemGenFunction = _item => {
                const item = _item;
                {
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        ListItem.create(() => { }, false);
                        ListItem.onTouch((event?: TouchEvent) => {
                            if (event === undefined) {
                                return;
                            }
                            switch (event.type) {
                                case TouchType.Down:
                                    this.startTouchOffsetY = event.touches[0].y;
                                    break;
                                case TouchType.Up:
                                    this.startTouchOffsetY = event.touches[0].y;
                                    break;
                                case TouchType.Move:
                                    if (this.startTouchOffsetY - this.endTouchOffsetY > 0) {
                                        this.goodsListData.pushData();
                                    }
                                    break;
                            }
                        });
                    };
                    const observedDeepRender = () => {
                        this.observeComponentCreation2(itemCreation2, ListItem);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Row.create();
                            Row.justifyContent(FlexAlign.SpaceBetween);
                            Row.height(commonConst.GOODS_LIST_HEIGHT);
                            Row.width(commonConst.LAYOUT_WIDTH_OR_HEIGHT);
                        }, Row);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Column.create();
                            Column.width(commonConst.GOODS_IMAGE_WIDTH);
                            Column.height(commonConst.LAYOUT_WIDTH_OR_HEIGHT);
                        }, Column);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Image.create(item?.goodsImg);
                            Image.width(commonConst.LAYOUT_WIDTH_OR_HEIGHT);
                            Image.height(commonConst.LAYOUT_WIDTH_OR_HEIGHT);
                            Image.draggable(false);
                        }, Image);
                        Column.pop();
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Column.create();
                            Column.padding(commonConst.GOODS_LIST_PADDING);
                            Column.width(commonConst.GOODS_FONT_WIDTH);
                            Column.height(commonConst.LAYOUT_WIDTH_OR_HEIGHT);
                            Column.justifyContent(FlexAlign.SpaceBetween);
                        }, Column);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(item?.goodsName);
                            Text.fontSize(commonConst.NORMAL_FONT_SIZE);
                        }, Text);
                        Text.pop();
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(item?.advertisingLanguage);
                            Text.fontColor({ "id": 16777291, "type": 10001, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
                            Text.fontSize(commonConst.GOODS_EVALUATE_FONT_SIZE);
                            Text.margin({ right: commonConst.MARGIN_RIGHT });
                        }, Text);
                        Text.pop();
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Row.create();
                            Row.justifyContent(FlexAlign.SpaceAround);
                            Row.width(commonConst.GOODS_LIST_WIDTH);
                        }, Row);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(item?.evaluate);
                            Text.fontSize(commonConst.GOODS_EVALUATE_FONT_SIZE);
                            Text.fontColor({ "id": 16777289, "type": 10001, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
                            Text.width(commonConst.EVALUATE_WIDTH);
                        }, Text);
                        Text.pop();
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(item?.price);
                            Text.fontSize(commonConst.NORMAL_FONT_SIZE);
                            Text.fontColor({ "id": 16777290, "type": 10001, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
                        }, Text);
                        Text.pop();
                        Row.pop();
                        Column.pop();
                        Row.pop();
                        ListItem.pop();
                    };
                    observedDeepRender();
                }
            };
            LazyForEach.create("1", this, this.goodsListData, __lazyForEachItemGenFunction);
            LazyForEach.pop();
        }
        List.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
