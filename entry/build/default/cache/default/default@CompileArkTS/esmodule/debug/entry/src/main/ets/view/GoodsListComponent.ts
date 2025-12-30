if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface GoodsList_Params {
    currentThemeColors?: ThemeColors;
    goodsListData?: ListDataSource;
    layoutMode?: 'list' | 'grid';
    startTouchOffsetY?: number;
    endTouchOffsetY?: number;
}
import * as commonConst from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
import type { GoodsListItemType } from '../viewmodel/InitialData';
import { ListDataSource } from "@bundle:com.example.list_harmony/entry/ets/viewmodel/ListDataSource";
import { DEFAULT_THEME } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import type { ThemeColors } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import router from "@ohos:router";
export default class GoodsList extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__currentThemeColors = this.createStorageLink('themeColors', DEFAULT_THEME, "currentThemeColors");
        this.__goodsListData = new ObservedPropertyObjectPU(ListDataSource.getInstance(), this, "goodsListData");
        this.addProvidedVar("goodsListData", this.__goodsListData, false);
        this.__layoutMode = new SynchedPropertySimpleOneWayPU(params.layoutMode, this, "layoutMode");
        this.startTouchOffsetY = 0;
        this.endTouchOffsetY = 0;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: GoodsList_Params) {
        if (params.goodsListData !== undefined) {
            this.goodsListData = params.goodsListData;
        }
        if (params.layoutMode === undefined) {
            this.__layoutMode.set('list');
        }
        if (params.startTouchOffsetY !== undefined) {
            this.startTouchOffsetY = params.startTouchOffsetY;
        }
        if (params.endTouchOffsetY !== undefined) {
            this.endTouchOffsetY = params.endTouchOffsetY;
        }
    }
    updateStateVars(params: GoodsList_Params) {
        this.__layoutMode.reset(params.layoutMode);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__currentThemeColors.purgeDependencyOnElmtId(rmElmtId);
        this.__goodsListData.purgeDependencyOnElmtId(rmElmtId);
        this.__layoutMode.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__currentThemeColors.aboutToBeDeleted();
        this.__goodsListData.aboutToBeDeleted();
        this.__layoutMode.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __currentThemeColors: ObservedPropertyAbstractPU<ThemeColors>;
    get currentThemeColors() {
        return this.__currentThemeColors.get();
    }
    set currentThemeColors(newValue: ThemeColors) {
        this.__currentThemeColors.set(newValue);
    }
    private __goodsListData: ObservedPropertyObjectPU<ListDataSource>;
    get goodsListData() {
        return this.__goodsListData.get();
    }
    set goodsListData(newValue: ListDataSource) {
        this.__goodsListData.set(newValue);
    }
    private __layoutMode: SynchedPropertySimpleOneWayPU<'list' | 'grid'>; // 添加布局模式属性
    get layoutMode() {
        return this.__layoutMode.get();
    }
    set layoutMode(newValue: 'list' | 'grid') {
        this.__layoutMode.set(newValue);
    }
    private startTouchOffsetY: number;
    private endTouchOffsetY: number;
    private groupItems(data: ListDataSource): GoodsListItemType[][] {
        let rows: GoodsListItemType[][] = [];
        for (let i = 0; i < data.totalCount(); i += 2) {
            let row: GoodsListItemType[] = [];
            let item1 = data.getData(i);
            if (item1)
                row.push(item1);
            if (i + 1 < data.totalCount()) {
                let item2 = data.getData(i + 1);
                if (item2)
                    row.push(item2);
            }
            if (row.length > 0)
                rows.push(row);
        }
        return rows;
    }
    GoodsItem(item: GoodsListItemType, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.padding(8);
            Column.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            Column.borderRadius(8);
            Column.width('48%');
            Column.onClick(() => {
                router.pushUrl({
                    url: 'pages/GoodsDetailPage',
                    params: {
                        goodsId: item.id,
                        goodsName: item.goodsName,
                        goodsPrice: item.price,
                        goodsImg: item.goodsImg
                    }
                });
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(item?.goodsImg);
            Image.width(140);
            Image.height(140);
            Image.draggable(false);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item?.goodsName);
            Text.fontSize(commonConst.NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.margin({ top: 8 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item?.advertisingLanguage);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.fontSize(commonConst.GOODS_EVALUATE_FONT_SIZE);
            Text.margin({ top: 4 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.justifyContent(FlexAlign.SpaceBetween);
            Row.margin({ top: 4 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item?.evaluate);
            Text.fontSize(commonConst.GOODS_EVALUATE_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.accentColor);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item?.price);
            Text.fontSize(commonConst.NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.accentColor);
        }, Text);
        Text.pop();
        Row.pop();
        Column.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.layoutMode === 'list') {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        // 平铺布局（原有布局）
                        Row.create();
                        // 平铺布局（原有布局）
                        Row.justifyContent(FlexAlign.Center);
                        // 平铺布局（原有布局）
                        Row.width(commonConst.LAYOUT_WIDTH_OR_HEIGHT);
                    }, Row);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        List.create({ space: commonConst.LIST_ITEM_SPACE });
                        List.width(commonConst.GOODS_LIST_WIDTH);
                        List.divider({
                            strokeWidth: 1,
                            color: this.currentThemeColors.dividerColor,
                        });
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
                                    ListItem.onClick(() => {
                                        router.pushUrl({
                                            url: 'pages/GoodsDetailPage',
                                            params: {
                                                goodsId: item.id,
                                                goodsName: item.goodsName,
                                                goodsPrice: item.price,
                                                goodsImg: item.goodsImg
                                            }
                                        });
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
                                        Text.fontColor(this.currentThemeColors.primaryTextColor);
                                    }, Text);
                                    Text.pop();
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        Text.create(item?.advertisingLanguage);
                                        Text.fontColor(this.currentThemeColors.primaryTextColor);
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
                                        Text.fontColor(this.currentThemeColors.accentColor);
                                        Text.width(commonConst.EVALUATE_WIDTH);
                                    }, Text);
                                    Text.pop();
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        Text.create(item?.price);
                                        Text.fontSize(commonConst.NORMAL_FONT_SIZE);
                                        Text.fontColor(this.currentThemeColors.accentColor);
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
                    // 平铺布局（原有布局）
                    Row.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        // 2列网格布局
                        Column.create();
                        // 2列网格布局
                        Column.width(commonConst.LAYOUT_WIDTH_OR_HEIGHT);
                    }, Column);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        ForEach.create();
                        const forEachItemGenFunction = (_item, index: number) => {
                            const row = _item;
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Row.create({ space: 8 });
                                Row.padding({ left: 8, right: 8 });
                            }, Row);
                            this.GoodsItem.bind(this)(row[0]);
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                If.create();
                                if (row.length > 1) {
                                    this.ifElseBranchUpdateFunction(0, () => {
                                        this.GoodsItem.bind(this)(row[1]);
                                    });
                                }
                                else {
                                    this.ifElseBranchUpdateFunction(1, () => {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            Blank.create();
                                        }, Blank);
                                        Blank.pop();
                                    });
                                }
                            }, If);
                            If.pop();
                            Row.pop();
                        };
                        this.forEachUpdateFunction(elmtId, this.groupItems(ObservedObject.GetRawObject(this.goodsListData)), forEachItemGenFunction, undefined, true, false);
                    }, ForEach);
                    ForEach.pop();
                    // 2列网格布局
                    Column.pop();
                });
            }
        }, If);
        If.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
