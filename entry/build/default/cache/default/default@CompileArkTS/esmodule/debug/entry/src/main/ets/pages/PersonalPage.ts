if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface PersonalPage_Params {
    userName?: string;
    userAvatar?: Resource;
    currentThemeType?: ThemeType;
    currentThemeColors?: ThemeColors;
    menuItems?: MenuItem[];
}
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, BIGGER_FONT_SIZE, SMALL_FONT_SIZE } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
import promptAction from "@ohos:promptAction";
import { ThemeType, getThemeColors, DEFAULT_THEME } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import type { ThemeColors } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
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
        this.__currentThemeType = this.createStorageLink('themeType', ThemeType.LIGHT, "currentThemeType");
        this.__currentThemeColors = this.createStorageLink('themeColors', DEFAULT_THEME, "currentThemeColors");
        this.menuItems = [
            { id: 1, icon: { "id": 16777310, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777248, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { id: 2, icon: { "id": 16777307, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777224, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { id: 3, icon: { "id": 16777314, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777285, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { id: 4, icon: { "id": 16777306, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777239, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
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
        if (params.menuItems !== undefined) {
            this.menuItems = params.menuItems;
        }
    }
    updateStateVars(params: PersonalPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__userName.purgeDependencyOnElmtId(rmElmtId);
        this.__userAvatar.purgeDependencyOnElmtId(rmElmtId);
        this.__currentThemeType.purgeDependencyOnElmtId(rmElmtId);
        this.__currentThemeColors.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__userName.aboutToBeDeleted();
        this.__userAvatar.aboutToBeDeleted();
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
    //为菜单项添加 id，方便识别 (id: 3 对应主题设置)
    private menuItems: MenuItem[];
    UserInfoSection(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 16 });
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.padding(16);
            Row.backgroundColor('#FFFFFF');
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
            Text.fontColor('#333333');
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777232, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor('#999999');
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
            Row.backgroundColor('#FFFFFF');
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
            Text.fontColor('#333333');
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777251, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor('#666666');
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
            Text.fontColor('#333333');
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777253, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor('#666666');
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
            Text.fontColor('#333333');
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777252, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor('#666666');
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
            Text.fontColor('#333333');
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777231, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor('#666666');
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
            Row.backgroundColor('#FFFFFF');
            Row.onClick(() => {
                // 菜单项点击逻辑 根据id判断点击逻辑 update1.2
                if (item.id === 3) {
                    this.showThemeDialog();
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
            Text.fontColor('#333333');
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
        });
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Scroll.create();
            Scroll.width(LAYOUT_WIDTH_OR_HEIGHT);
            Scroll.height(LAYOUT_WIDTH_OR_HEIGHT);
            Scroll.backgroundColor('#F5F5F5');
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
            Column.backgroundColor('#FFFFFF');
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
                    Divider.color('#F0F0F0');
                }, Divider);
            };
            this.forEachUpdateFunction(elmtId, this.menuItems, forEachItemGenFunction);
        }, ForEach);
        ForEach.pop();
        // 功能菜单列表
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 退出登录按钮
            Button.createWithLabel({ "id": 16777246, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            // 退出登录按钮
            Button.fontSize(NORMAL_FONT_SIZE);
            // 退出登录按钮
            Button.fontColor('#FF4D4F');
            // 退出登录按钮
            Button.backgroundColor('#FFFFFF');
            // 退出登录按钮
            Button.width(LAYOUT_WIDTH_OR_HEIGHT);
            // 退出登录按钮
            Button.height(48);
            // 退出登录按钮
            Button.margin({ top: 16, bottom: 16 });
            // 退出登录按钮
            Button.borderRadius(8);
        }, Button);
        // 退出登录按钮
        Button.pop();
        Column.pop();
        Scroll.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
