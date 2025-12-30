if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface ListIndex_Params {
    currentTabIndex?: number;
    layoutMode?: 'list' | 'grid';
    currentThemeColors?: ThemeColors;
}
import TabBar from "@bundle:com.example.list_harmony/entry/ets/view/TabBarsComponent";
import BottomTabBar from "@bundle:com.example.list_harmony/entry/ets/view/BottomTabBarComponent";
import CategoryPage from "@bundle:com.example.list_harmony/entry/ets/pages/CategoryPage";
import ShoppingCartPage from "@bundle:com.example.list_harmony/entry/ets/pages/ShoppingCartPage";
import PersonalPage from "@bundle:com.example.list_harmony/entry/ets/pages/PersonalPage";
import { DEFAULT_THEME } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import type { ThemeColors } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import { LAYOUT_WIDTH_OR_HEIGHT, NAV_BAR_HEIGHT } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
class ListIndex extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__currentTabIndex = new ObservedPropertySimplePU(0, this, "currentTabIndex");
        this.__layoutMode = new ObservedPropertySimplePU('list', this, "layoutMode");
        this.__currentThemeColors = this.createStorageLink('themeColors', DEFAULT_THEME, "currentThemeColors");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: ListIndex_Params) {
        if (params.currentTabIndex !== undefined) {
            this.currentTabIndex = params.currentTabIndex;
        }
        if (params.layoutMode !== undefined) {
            this.layoutMode = params.layoutMode;
        }
    }
    updateStateVars(params: ListIndex_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__currentTabIndex.purgeDependencyOnElmtId(rmElmtId);
        this.__layoutMode.purgeDependencyOnElmtId(rmElmtId);
        this.__currentThemeColors.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__currentTabIndex.aboutToBeDeleted();
        this.__layoutMode.aboutToBeDeleted();
        this.__currentThemeColors.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __currentTabIndex: ObservedPropertySimplePU<number>;
    get currentTabIndex() {
        return this.__currentTabIndex.get();
    }
    set currentTabIndex(newValue: number) {
        this.__currentTabIndex.set(newValue);
    }
    private __layoutMode: ObservedPropertySimplePU<'list' | 'grid'>; // 添加布局模式状态
    get layoutMode() {
        return this.__layoutMode.get();
    }
    set layoutMode(newValue: 'list' | 'grid') {
        this.__layoutMode.set(newValue);
    }
    private __currentThemeColors: ObservedPropertyAbstractPU<ThemeColors>; //使用 @StorageLink 确保当 PersonalPage 改变主题时，这里会自动刷新
    get currentThemeColors() {
        return this.__currentThemeColors.get();
    }
    set currentThemeColors(newValue: ThemeColors) {
        this.__currentThemeColors.set(newValue);
    }
    NavigationTitle(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.height(NAV_BAR_HEIGHT);
            Row.justifyContent(FlexAlign.Center);
            Row.backgroundColor(this.currentThemeColors.cardBackgroundColor);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.getPageTitle());
            Text.fontSize(20);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.margin({ top: 34 });
        }, Text);
        Text.pop();
        Row.pop();
    }
    getPageTitle(): Resource {
        switch (this.currentTabIndex) {
            case 0:
                return { "id": 16777273, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
            case 1:
                return { "id": 16777226, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
            case 2:
                return { "id": 16777272, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
            case 3:
                return { "id": 16777254, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
            default:
                return { "id": 16777273, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
        }
    }
    PageContent(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.currentTabIndex === 0) {
                this.ifElseBranchUpdateFunction(0, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new 
                                // 首页内容
                                TabBar(this, {
                                    layoutMode: this.__layoutMode
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/ListIndex.ets", line: 69, col: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {
                                        layoutMode: this.layoutMode
                                    };
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "TabBar" });
                    }
                });
            }
            else if (this.currentTabIndex === 1) {
                this.ifElseBranchUpdateFunction(1, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new 
                                // 分类页面
                                CategoryPage(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/ListIndex.ets", line: 74, col: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {};
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "CategoryPage" });
                    }
                });
            }
            else if (this.currentTabIndex === 2) {
                this.ifElseBranchUpdateFunction(2, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new 
                                // 购物车页面
                                ShoppingCartPage(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/ListIndex.ets", line: 77, col: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {};
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "ShoppingCartPage" });
                    }
                });
            }
            else if (this.currentTabIndex === 3) {
                this.ifElseBranchUpdateFunction(3, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new 
                                // 个人中心页面
                                PersonalPage(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/ListIndex.ets", line: 80, col: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {};
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "PersonalPage" });
                    }
                });
            }
            else {
                this.ifElseBranchUpdateFunction(4, () => {
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
            Column.backgroundColor(this.currentThemeColors.backgroundColor);
        }, Column);
        // 顶部导航栏
        this.NavigationTitle.bind(this)();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 主内容区域
            Stack.create();
            // 主内容区域
            Stack.width(LAYOUT_WIDTH_OR_HEIGHT);
            // 主内容区域
            Stack.layoutWeight(1);
        }, Stack);
        this.PageContent.bind(this)();
        // 主内容区域
        Stack.pop();
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // 底部 Tab Bar
                    BottomTabBar(this, { currentIndex: this.__currentTabIndex }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/ListIndex.ets", line: 97, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            currentIndex: this.currentTabIndex
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "BottomTabBar" });
        }
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "ListIndex";
    }
}
registerNamedRoute(() => new ListIndex(undefined, {}), "", { bundleName: "com.example.list_harmony", moduleName: "entry", pagePath: "pages/ListIndex", pageFullPath: "entry/src/main/ets/pages/ListIndex", integratedHsp: "false", moduleType: "followWithHap" });
