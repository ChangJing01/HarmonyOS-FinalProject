if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface ListIndex_Params {
    currentTabIndex?: number;
}
import TabBar from "@bundle:com.example.list_harmony/entry/ets/view/TabBarsComponent";
import BottomTabBar from "@bundle:com.example.list_harmony/entry/ets/view/BottomTabBarComponent";
import CategoryPage from "@bundle:com.example.list_harmony/entry/ets/pages/CategoryPage";
import ShoppingCartPage from "@bundle:com.example.list_harmony/entry/ets/pages/ShoppingCartPage";
import PersonalPage from "@bundle:com.example.list_harmony/entry/ets/pages/PersonalPage";
import { LAYOUT_WIDTH_OR_HEIGHT, NAV_BAR_HEIGHT } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
class ListIndex extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__currentTabIndex = new ObservedPropertySimplePU(0, this, "currentTabIndex");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: ListIndex_Params) {
        if (params.currentTabIndex !== undefined) {
            this.currentTabIndex = params.currentTabIndex;
        }
    }
    updateStateVars(params: ListIndex_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__currentTabIndex.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__currentTabIndex.aboutToBeDeleted();
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
    NavigationTitle(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.debugLine("entry/src/main/ets/pages/ListIndex.ets(33:5)", "entry");
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.height(NAV_BAR_HEIGHT);
            Row.justifyContent(FlexAlign.Center);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.getPageTitle());
            Text.debugLine("entry/src/main/ets/pages/ListIndex.ets(34:7)", "entry");
            Text.fontSize(20);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#333333');
        }, Text);
        Text.pop();
        Row.pop();
    }
    getPageTitle(): Resource {
        switch (this.currentTabIndex) {
            case 0:
                return { "id": 16777285, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
            case 1:
                return { "id": 16777238, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
            case 2:
                return { "id": 16777284, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
            case 3:
                return { "id": 16777266, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
            default:
                return { "id": 16777285, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
        }
    }
    PageContent(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.currentTabIndex === 0) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        // 首页内容
                        Column.create();
                        Column.debugLine("entry/src/main/ets/pages/ListIndex.ets(63:7)", "entry");
                        // 首页内容
                        Column.width(LAYOUT_WIDTH_OR_HEIGHT);
                        // 首页内容
                        Column.height(LAYOUT_WIDTH_OR_HEIGHT);
                    }, Column);
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new TabBar(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/ListIndex.ets", line: 64, col: 9 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {};
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "TabBar" });
                    }
                    // 首页内容
                    Column.pop();
                });
            }
            else if (this.currentTabIndex === 1) {
                this.ifElseBranchUpdateFunction(1, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new 
                                // 分类页面
                                CategoryPage(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/ListIndex.ets", line: 70, col: 7 });
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
                                ShoppingCartPage(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/ListIndex.ets", line: 73, col: 7 });
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
                                PersonalPage(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/ListIndex.ets", line: 76, col: 7 });
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
            Column.debugLine("entry/src/main/ets/pages/ListIndex.ets(81:5)", "entry");
            Column.width(LAYOUT_WIDTH_OR_HEIGHT);
            Column.height(LAYOUT_WIDTH_OR_HEIGHT);
            Column.backgroundColor({ "id": 16777309, "type": 10001, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
        }, Column);
        // 顶部导航栏
        this.NavigationTitle.bind(this)();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 主内容区域
            Stack.create();
            Stack.debugLine("entry/src/main/ets/pages/ListIndex.ets(86:7)", "entry");
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
                    BottomTabBar(this, { currentIndex: this.__currentTabIndex }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/ListIndex.ets", line: 93, col: 7 });
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
