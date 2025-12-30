if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface PersonalPage_Params {
    userName?: string;
    userAvatar?: Resource;
    isLoggedIn?: boolean;
    currentUsername?: string;
    currentThemeType?: ThemeType;
    currentThemeColors?: ThemeColors;
    accountData?: AccountData;
    context?: common.Context;
    menuItems?: MenuItem[];
}
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, BIGGER_FONT_SIZE, SMALL_FONT_SIZE } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
import promptAction from "@ohos:promptAction";
import { ThemeType, getThemeColors, DEFAULT_THEME } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import type { ThemeColors } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import router from "@ohos:router";
import LoginComponent from "@bundle:com.example.list_harmony/entry/ets/view/LoginComponent";
import { AccountData } from "@bundle:com.example.list_harmony/entry/ets/model/AccountData";
import type common from "@ohos:app.ability.common";
import Logger from "@bundle:com.example.list_harmony/entry/ets/model/Logger";
const TAG: string = '[PersonalPage]';
interface MenuItem {
    id: number;
    icon: Resource;
    title: Resource;
    showArrow: boolean;
}
export default class PersonalPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__userName = new ObservedPropertySimplePU('用户名', this, "userName");
        this.__userAvatar = new ObservedPropertyObjectPU({ "id": 16777300, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, this, "userAvatar");
        this.__isLoggedIn = this.createStorageLink('isLoggedIn', false, "isLoggedIn");
        this.__currentUsername = this.createStorageLink('currentUsername', '', "currentUsername");
        this.__currentThemeType = this.createStorageLink('themeType', ThemeType.LIGHT, "currentThemeType");
        this.__currentThemeColors = this.createStorageLink('themeColors', DEFAULT_THEME, "currentThemeColors");
        this.accountData = new AccountData();
        this.context = getContext(this) as common.Context;
        this.menuItems = [
            { id: 1, icon: { "id": 16777310, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777248, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { id: 2, icon: { "id": 16777307, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777224, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { id: 3, icon: { "id": 16777314, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777285, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { id: 4, icon: { "id": 16777306, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777239, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { id: 7, icon: { "id": 16777310, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777318, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { id: 5, icon: { "id": 16777305, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777228, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { id: 6, icon: { "id": 16777298, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777220, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true }
        ];
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: PersonalPage_Params) {
        if (params.userName !== undefined) {
            this.userName = params.userName;
        }
        if (params.userAvatar !== undefined) {
            this.userAvatar = params.userAvatar;
        }
        if (params.accountData !== undefined) {
            this.accountData = params.accountData;
        }
        if (params.context !== undefined) {
            this.context = params.context;
        }
        if (params.menuItems !== undefined) {
            this.menuItems = params.menuItems;
        }
    }
    updateStateVars(params: PersonalPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__userName.purgeDependencyOnElmtId(rmElmtId);
        this.__userAvatar.purgeDependencyOnElmtId(rmElmtId);
        this.__isLoggedIn.purgeDependencyOnElmtId(rmElmtId);
        this.__currentUsername.purgeDependencyOnElmtId(rmElmtId);
        this.__currentThemeType.purgeDependencyOnElmtId(rmElmtId);
        this.__currentThemeColors.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__userName.aboutToBeDeleted();
        this.__userAvatar.aboutToBeDeleted();
        this.__isLoggedIn.aboutToBeDeleted();
        this.__currentUsername.aboutToBeDeleted();
        this.__currentThemeType.aboutToBeDeleted();
        this.__currentThemeColors.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __userName: ObservedPropertySimplePU<string>;
    get userName() {
        return this.__userName.get();
    }
    set userName(newValue: string) {
        this.__userName.set(newValue);
    }
    private __userAvatar: ObservedPropertyObjectPU<Resource>;
    get userAvatar() {
        return this.__userAvatar.get();
    }
    set userAvatar(newValue: Resource) {
        this.__userAvatar.set(newValue);
    }
    //使用 @StorageLink 与全局 AppStorage 双向绑定登录状态
    private __isLoggedIn: ObservedPropertyAbstractPU<boolean>;
    get isLoggedIn() {
        return this.__isLoggedIn.get();
    }
    set isLoggedIn(newValue: boolean) {
        this.__isLoggedIn.set(newValue);
    }
    private __currentUsername: ObservedPropertyAbstractPU<string>;
    get currentUsername() {
        return this.__currentUsername.get();
    }
    set currentUsername(newValue: string) {
        this.__currentUsername.set(newValue);
    }
    //与全局 AppStorage 建立双向同步
    // 当 themeType 改变时，UI 会自动刷新（如果有依赖它的 UI），且我们修改它会同步回全局
    private __currentThemeType: ObservedPropertyAbstractPU<ThemeType>;
    get currentThemeType() {
        return this.__currentThemeType.get();
    }
    set currentThemeType(newValue: ThemeType) {
        this.__currentThemeType.set(newValue);
    }
    private __currentThemeColors: ObservedPropertyAbstractPU<ThemeColors>;
    get currentThemeColors() {
        return this.__currentThemeColors.get();
    }
    set currentThemeColors(newValue: ThemeColors) {
        this.__currentThemeColors.set(newValue);
    }
    private accountData: AccountData;
    private context: common.Context;
    //为菜单项添加 id，方便识别 (id: 3 对应主题设置)
    private menuItems: MenuItem[];
    UserInfoSection(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 16 });
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.padding(16);
            Row.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            Row.borderRadius(8);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 头像
            Image.create(this.userAvatar);
            // 头像
            Image.width(64);
            // 头像
            Image.height(64);
            // 头像
            Image.borderRadius(32);
            // 头像
            Image.backgroundColor('#F5F5F5');
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 用户信息
            Column.create({ space: 8 });
            // 用户信息
            Column.alignItems(HorizontalAlign.Start);
            // 用户信息
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.userName);
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777232, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
            Text.onClick(() => {
                // 编辑资料逻辑
            });
        }, Text);
        Text.pop();
        // 用户信息
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 16777299, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Image.width(20);
            Image.height(20);
        }, Image);
        Row.pop();
    }
    OrderStatistics(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.padding(16);
            Row.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            Row.borderRadius(8);
            Row.margin({ top: 8 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 8 });
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('0');
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777251, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 8 });
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('0');
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777253, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 8 });
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('0');
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777252, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 8 });
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('0');
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777231, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.secondaryTextColor);
        }, Text);
        Text.pop();
        Column.pop();
        Row.pop();
    }
    MenuItemBuilder(item: MenuItem, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 12 });
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.height(56);
            Row.padding({ left: 16, right: 16 });
            Row.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            Row.onClick(() => {
                // 菜单项点击逻辑 根据id判断点击逻辑 update1.2
                if (item.id === 3) {
                    this.showThemeDialog();
                }
                else if (item.id === 7) {
                    router.pushUrl({
                        url: 'pages/PublishGoodsPage'
                    });
                }
                else {
                    // 其他菜单项逻辑
                    console.info('Clicked menu item:', item.id);
                }
            });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(item.icon);
            Image.width(24);
            Image.height(24);
            Image.fillColor(this.currentThemeColors.primaryTextColor);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item.title);
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
            Text.layoutWeight(1);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (item.showArrow) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Image.create({ "id": 16777299, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
                        Image.width(16);
                        Image.height(16);
                    }, Image);
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        Row.pop();
    }
    //显示主题选择弹窗的方法
    showThemeDialog() {
        try {
            promptAction.showActionMenu({
                title: '选择应用主题',
                buttons: [
                    { text: '默认白', color: '#333333' },
                    { text: '深色模式', color: '#000000' },
                    { text: '护眼模式', color: '#FF6B35' }
                ]
            }).then(data => {
                let selectedType: ThemeType;
                // 根据点击的按钮索引决定切换哪个主题
                switch (data.index) {
                    case 0:
                        selectedType = ThemeType.LIGHT;
                        break;
                    case 1:
                        selectedType = ThemeType.DARK;
                        break;
                    case 2:
                        selectedType = ThemeType.EYECARE;
                        break;
                    default:
                        return;
                }
                // 核心逻辑：修改状态变量，AppStorage 会自动同步到全局
                this.currentThemeType = selectedType;
                this.currentThemeColors = getThemeColors(selectedType);
                // 可以在这里打印日志验证
                console.info('Theme changed to:', selectedType);
            }).catch(() => {
                Logger.error(TAG, `showActionMenu failed`);
            });
        }
        catch (_) {
            Logger.error(TAG, `showThemeDialog failed`);
        }
    }
    // 检查登录状态
    async checkLoginStatus() {
        try {
            const STORAGE_KEY = 'account_storage';
            const loginStatus = await this.accountData.getStorageValue(this.context, 'isLoggedIn', STORAGE_KEY);
            if (loginStatus === 'true') {
                const username = await this.accountData.getStorageValue(this.context, 'username', STORAGE_KEY);
                this.currentUsername = username as string;
                this.userName = username as string;
                this.isLoggedIn = true;
                Logger.info(TAG, `User is logged in: ${this.currentUsername}`);
            }
            else {
                this.isLoggedIn = false;
                this.currentUsername = '';
                this.userName = '用户名';
                Logger.info(TAG, 'User is not logged in');
            }
        }
        catch (err) {
            Logger.error(TAG, `checkLoginStatus failed: ${JSON.stringify(err)}`);
            this.isLoggedIn = false;
            this.currentUsername = '';
        }
    }
    // 处理登出
    async handleLogout() {
        try {
            promptAction.showDialog({
                title: '确认登出',
                message: '您确定要登出吗？',
                buttons: [
                    { text: '取消', color: '#000000' },
                    { text: '登出', color: '#FF0000' }
                ]
            }).then((data) => {
                if (data.index === 1) {
                    // 用户确认登出
                    const STORAGE_KEY = 'account_storage';
                    this.accountData.putStorageValue(this.context, 'isLoggedIn', 'false', STORAGE_KEY).then(() => {
                        this.isLoggedIn = false;
                        this.currentUsername = '';
                        this.userName = '用户名';
                        try {
                            promptAction.showToast({
                                message: '已登出',
                                duration: 2000
                            });
                        }
                        catch (_) {
                            Logger.error(TAG, `showToast failed`);
                        }
                        Logger.info(TAG, 'User logged out');
                    }).catch(() => {
                        Logger.error(TAG, `Logout failed`);
                    });
                }
            }).catch(() => {
                Logger.error(TAG, `showDialog failed`);
            });
        }
        catch (_) {
            Logger.error(TAG, `handleLogout failed`);
        }
    }
    aboutToAppear() {
        this.checkLoginStatus();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (!this.isLoggedIn) {
                this.ifElseBranchUpdateFunction(0, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new 
                                // 显示登录页面
                                LoginComponent(this, {
                                    currentThemeColors: this.currentThemeColors,
                                    onLoginSuccess: (username: string) => {
                                        this.userName = username;
                                    }
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/PersonalPage.ets", line: 324, col: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {
                                        currentThemeColors: this.currentThemeColors,
                                        onLoginSuccess: (username: string) => {
                                            this.userName = username;
                                        }
                                    };
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {
                                    currentThemeColors: this.currentThemeColors
                                });
                            }
                        }, { name: "LoginComponent" });
                    }
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        // 显示个人信息页面
                        Scroll.create();
                        // 显示个人信息页面
                        Scroll.width(LAYOUT_WIDTH_OR_HEIGHT);
                        // 显示个人信息页面
                        Scroll.height(LAYOUT_WIDTH_OR_HEIGHT);
                        // 显示个人信息页面
                        Scroll.backgroundColor(this.currentThemeColors.backgroundColor);
                    }, Scroll);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Column.create();
                        Column.width(LAYOUT_WIDTH_OR_HEIGHT);
                        Column.padding(8);
                    }, Column);
                    // 用户信息区域
                    this.UserInfoSection.bind(this)();
                    // 订单统计
                    this.OrderStatistics.bind(this)();
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        // 功能菜单列表
                        Column.create();
                        // 功能菜单列表
                        Column.width(LAYOUT_WIDTH_OR_HEIGHT);
                        // 功能菜单列表
                        Column.backgroundColor(this.currentThemeColors.cardBackgroundColor);
                        // 功能菜单列表
                        Column.borderRadius(8);
                        // 功能菜单列表
                        Column.margin({ top: 8 });
                    }, Column);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        ForEach.create();
                        const forEachItemGenFunction = _item => {
                            const item = _item;
                            this.MenuItemBuilder.bind(this)(item);
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Divider.create();
                                Divider.strokeWidth(1);
                                Divider.color(this.currentThemeColors.dividerColor);
                            }, Divider);
                        };
                        this.forEachUpdateFunction(elmtId, this.menuItems, forEachItemGenFunction);
                    }, ForEach);
                    ForEach.pop();
                    // 功能菜单列表
                    Column.pop();
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        // 退出登录按钮
                        Button.createWithLabel('登出');
                        // 退出登录按钮
                        Button.fontSize(NORMAL_FONT_SIZE);
                        // 退出登录按钮
                        Button.fontColor(this.currentThemeColors.accentColor);
                        // 退出登录按钮
                        Button.backgroundColor(this.currentThemeColors.cardBackgroundColor);
                        // 退出登录按钮
                        Button.width(LAYOUT_WIDTH_OR_HEIGHT);
                        // 退出登录按钮
                        Button.height(48);
                        // 退出登录按钮
                        Button.margin({ top: 16, bottom: 16 });
                        // 退出登录按钮
                        Button.borderRadius(8);
                        // 退出登录按钮
                        Button.onClick(() => {
                            this.handleLogout();
                        });
                    }, Button);
                    // 退出登录按钮
                    Button.pop();
                    Column.pop();
                    // 显示个人信息页面
                    Scroll.pop();
                });
            }
        }, If);
        If.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
