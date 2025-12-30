if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface TabBar_Params {
    currentOffsetY?: number;
    timer?: number;
    tabsIndex?: number;
    refreshStatus?: boolean;
    refreshText?: Resource;
    layoutMode?: 'list' | 'grid';
    currentThemeColors?: ThemeColors;
    tabData?: Resource[];
}
import { initTabBarData } from "@bundle:com.example.list_harmony/entry/ets/viewmodel/InitialData";
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, BIGGER_FONT_SIZE, MAX_FONT_SIZE, MAX_OFFSET_Y, REFRESH_TIME, GOODS_EVALUATE_FONT_SIZE, MAX_LINES_TEXT } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
import GoodsList from "@bundle:com.example.list_harmony/entry/ets/view/GoodsListComponent";
import PutDownRefresh from "@bundle:com.example.list_harmony/entry/ets/view/PutDownRefreshLayout";
import { DEFAULT_THEME } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import type { ThemeColors } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
export default class TabBar extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.currentOffsetY = 0;
        this.timer = 0;
        this.__tabsIndex = new ObservedPropertySimplePU(0, this, "tabsIndex");
        this.__refreshStatus = new ObservedPropertySimplePU(false, this, "refreshStatus");
        this.__refreshText = new ObservedPropertyObjectPU({ "id": 16777263, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, this, "refreshText");
        this.__layoutMode = new SynchedPropertySimpleTwoWayPU(params.layoutMode, this, "layoutMode");
        this.__currentThemeColors = this.createStorageLink('themeColors', DEFAULT_THEME, "currentThemeColors");
        this.tabData = [{ "id": 16777271, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, ...initTabBarData];
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: TabBar_Params) {
        if (params.currentOffsetY !== undefined) {
            this.currentOffsetY = params.currentOffsetY;
        }
        if (params.timer !== undefined) {
            this.timer = params.timer;
        }
        if (params.tabsIndex !== undefined) {
            this.tabsIndex = params.tabsIndex;
        }
        if (params.refreshStatus !== undefined) {
            this.refreshStatus = params.refreshStatus;
        }
        if (params.refreshText !== undefined) {
            this.refreshText = params.refreshText;
        }
        if (params.tabData !== undefined) {
            this.tabData = params.tabData;
        }
    }
    updateStateVars(params: TabBar_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__tabsIndex.purgeDependencyOnElmtId(rmElmtId);
        this.__refreshStatus.purgeDependencyOnElmtId(rmElmtId);
        this.__refreshText.purgeDependencyOnElmtId(rmElmtId);
        this.__layoutMode.purgeDependencyOnElmtId(rmElmtId);
        this.__currentThemeColors.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__tabsIndex.aboutToBeDeleted();
        this.__refreshStatus.aboutToBeDeleted();
        this.__refreshText.aboutToBeDeleted();
        this.__layoutMode.aboutToBeDeleted();
        this.__currentThemeColors.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private currentOffsetY: number;
    private timer: number;
    private __tabsIndex: ObservedPropertySimplePU<number>;
    get tabsIndex() {
        return this.__tabsIndex.get();
    }
    set tabsIndex(newValue: number) {
        this.__tabsIndex.set(newValue);
    }
    private __refreshStatus: ObservedPropertySimplePU<boolean>;
    get refreshStatus() {
        return this.__refreshStatus.get();
    }
    set refreshStatus(newValue: boolean) {
        this.__refreshStatus.set(newValue);
    }
    private __refreshText: ObservedPropertyObjectPU<Resource>;
    get refreshText() {
        return this.__refreshText.get();
    }
    set refreshText(newValue: Resource) {
        this.__refreshText.set(newValue);
    }
    private __layoutMode: SynchedPropertySimpleTwoWayPU<'list' | 'grid'>;
    get layoutMode() {
        return this.__layoutMode.get();
    }
    set layoutMode(newValue: 'list' | 'grid') {
        this.__layoutMode.set(newValue);
    }
    private __currentThemeColors: ObservedPropertyAbstractPU<ThemeColors>;
    get currentThemeColors() {
        return this.__currentThemeColors.get();
    }
    set currentThemeColors(newValue: ThemeColors) {
        this.__currentThemeColors.set(newValue);
    }
    private tabData: Resource[];
    putDownRefresh(event?: TouchEvent): void {
        if (event === undefined) {
            return;
        }
        switch (event.type) {
            // Record the y-coordinate pressed by the finger.
            case TouchType.Down:
                this.currentOffsetY = event.touches[0].y;
                break;
            case TouchType.Move:
                // Determine whether to refresh based on the drop-down offset.
                this.refreshStatus = event.touches[0].y - this.currentOffsetY > MAX_OFFSET_Y;
                break;
            case TouchType.Cancel:
                break;
            case TouchType.Up:
                // Only simulation effect, no data request.
                this.timer = setTimeout(() => {
                    this.refreshStatus = false;
                }, REFRESH_TIME);
                break;
            default:
                break;
        }
    }
    TabItem(content: Resource, index: number, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.padding({ left: 12, right: 12 });
            Column.height(56);
            Column.justifyContent(FlexAlign.Center);
            Column.onClick(() => {
                this.tabsIndex = index;
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(content);
            Text.fontSize(this.tabsIndex === index ? BIGGER_FONT_SIZE : NORMAL_FONT_SIZE);
            Text.fontColor(this.tabsIndex === index ? this.currentThemeColors.primaryTextColor : this.currentThemeColors.secondaryTextColor);
            Text.maxLines(MAX_LINES_TEXT);
            Text.minFontSize(this.tabsIndex === index ? NORMAL_FONT_SIZE : GOODS_EVALUATE_FONT_SIZE);
            Text.maxFontSize(this.tabsIndex === index ? BIGGER_FONT_SIZE : NORMAL_FONT_SIZE);
            Text.fontWeight(this.tabsIndex === index ? FontWeight.Bold : FontWeight.Normal);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.tabsIndex === index) {
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
    getContent(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.tabsIndex === 0) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Column.create();
                    }, Column);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        If.create();
                        if (this.refreshStatus) {
                            this.ifElseBranchUpdateFunction(0, () => {
                                {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        if (isInitialRender) {
                                            let componentCall = new PutDownRefresh(this, { refreshText: this.__refreshText }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/view/TabBarsComponent.ets", line: 101, col: 11 });
                                            ViewPU.create(componentCall);
                                            let paramsLambda = () => {
                                                return {
                                                    refreshText: this.refreshText
                                                };
                                            };
                                            componentCall.paramsGenerator_ = paramsLambda;
                                        }
                                        else {
                                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                                        }
                                    }, { name: "PutDownRefresh" });
                                }
                            });
                        }
                        else {
                            this.ifElseBranchUpdateFunction(1, () => {
                            });
                        }
                    }, If);
                    If.pop();
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new GoodsList(this, {
                                    layoutMode: this.layoutMode
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/view/TabBarsComponent.ets", line: 103, col: 9 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {
                                        layoutMode: this.layoutMode
                                    };
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {
                                    layoutMode: this.layoutMode
                                });
                            }
                        }, { name: "GoodsList" });
                    }
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create({ "id": 16777286, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
                        Text.fontSize(NORMAL_FONT_SIZE);
                        Text.fontColor({ "id": 16777291, "type": 10001, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
                    }, Text);
                    Text.pop();
                    Column.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Column.create();
                        Column.justifyContent(FlexAlign.Center);
                        Column.width(LAYOUT_WIDTH_OR_HEIGHT);
                        Column.height(LAYOUT_WIDTH_OR_HEIGHT);
                    }, Column);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create(initTabBarData[this.tabsIndex - 1]);
                        Text.fontSize(MAX_FONT_SIZE);
                    }, Text);
                    Text.pop();
                    Column.pop();
                });
            }
        }, If);
        If.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
            Column.height(LAYOUT_WIDTH_OR_HEIGHT);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 顶部导航栏：tabs 和 布局切换按钮
            Row.create();
            // 顶部导航栏：tabs 和 布局切换按钮
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            // 顶部导航栏：tabs 和 布局切换按钮
            Row.height(56);
            // 顶部导航栏：tabs 和 布局切换按钮
            Row.backgroundColor(this.currentThemeColors.cardBackgroundColor);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Tabs 部分
            Scroll.create();
            // Tabs 部分
            Scroll.scrollable(ScrollDirection.Horizontal);
            // Tabs 部分
            Scroll.scrollBar(BarState.Off);
            // Tabs 部分
            Scroll.layoutWeight(1);
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
            this.forEachUpdateFunction(elmtId, this.tabData, forEachItemGenFunction, undefined, true, false);
        }, ForEach);
        ForEach.pop();
        Row.pop();
        // Tabs 部分
        Scroll.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 布局切换按钮
            Text.create(this.layoutMode === 'list' ? '⊞' : '☰');
            // 布局切换按钮
            Text.fontSize(16);
            // 布局切换按钮
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
            // 布局切换按钮
            Text.width(40);
            // 布局切换按钮
            Text.height(56);
            // 布局切换按钮
            Text.textAlign(TextAlign.Center);
            // 布局切换按钮
            Text.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            // 布局切换按钮
            Text.onClick(() => {
                this.layoutMode = this.layoutMode === 'list' ? 'grid' : 'list';
            });
        }, Text);
        // 布局切换按钮
        Text.pop();
        // 顶部导航栏：tabs 和 布局切换按钮
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 内容区域
            Scroll.create();
            // 内容区域
            Scroll.scrollable(ScrollDirection.Vertical);
            // 内容区域
            Scroll.scrollBar(BarState.Off);
            // 内容区域
            Scroll.edgeEffect(EdgeEffect.Spring);
            // 内容区域
            Scroll.width(LAYOUT_WIDTH_OR_HEIGHT);
            // 内容区域
            Scroll.layoutWeight(1);
            // 内容区域
            Scroll.onTouch((event?: TouchEvent) => {
                this.putDownRefresh(event);
            });
        }, Scroll);
        this.getContent.bind(this)();
        // 内容区域
        Scroll.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
