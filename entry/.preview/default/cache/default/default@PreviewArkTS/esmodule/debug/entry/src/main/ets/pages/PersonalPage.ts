if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface PersonalPage_Params {
    userName?: string;
    userAvatar?: Resource;
    menuItems?: MenuItem[];
}
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, BIGGER_FONT_SIZE, SMALL_FONT_SIZE } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
interface MenuItem {
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
        this.__userAvatar = new ObservedPropertyObjectPU({ "id": 16777312, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, this, "userAvatar");
        this.menuItems = [
            { icon: { "id": 16777227, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777260, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { icon: { "id": 16777313, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777236, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { icon: { "id": 16777226, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777297, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { icon: { "id": 16777305, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777251, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { icon: { "id": 16777219, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777240, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true },
            { icon: { "id": 16777223, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, title: { "id": 16777232, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, showArrow: true }
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
    }
    aboutToBeDeleted() {
        this.__userName.aboutToBeDeleted();
        this.__userAvatar.aboutToBeDeleted();
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
    private menuItems: MenuItem[];
    UserInfoSection(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 16 });
            Row.debugLine("entry/src/main/ets/pages/PersonalPage.ets(45:5)", "entry");
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.padding(16);
            Row.backgroundColor('#FFFFFF');
            Row.borderRadius(8);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 头像
            Image.create(this.userAvatar);
            Image.debugLine("entry/src/main/ets/pages/PersonalPage.ets(47:7)", "entry");
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
            Column.debugLine("entry/src/main/ets/pages/PersonalPage.ets(54:7)", "entry");
            // 用户信息
            Column.alignItems(HorizontalAlign.Start);
            // 用户信息
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.userName);
            Text.debugLine("entry/src/main/ets/pages/PersonalPage.ets(55:9)", "entry");
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor('#333333');
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777244, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/pages/PersonalPage.ets(60:9)", "entry");
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
            Image.create({ "id": 16777225, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Image.debugLine("entry/src/main/ets/pages/PersonalPage.ets(70:7)", "entry");
            Image.width(20);
            Image.height(20);
        }, Image);
        Row.pop();
    }
    OrderStatistics(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.debugLine("entry/src/main/ets/pages/PersonalPage.ets(82:5)", "entry");
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.padding(16);
            Row.backgroundColor('#FFFFFF');
            Row.borderRadius(8);
            Row.margin({ top: 8 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 8 });
            Column.debugLine("entry/src/main/ets/pages/PersonalPage.ets(83:7)", "entry");
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('0');
            Text.debugLine("entry/src/main/ets/pages/PersonalPage.ets(84:9)", "entry");
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor('#333333');
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777263, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/pages/PersonalPage.ets(89:9)", "entry");
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor('#666666');
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 8 });
            Column.debugLine("entry/src/main/ets/pages/PersonalPage.ets(95:7)", "entry");
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('0');
            Text.debugLine("entry/src/main/ets/pages/PersonalPage.ets(96:9)", "entry");
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor('#333333');
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777265, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/pages/PersonalPage.ets(101:9)", "entry");
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor('#666666');
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 8 });
            Column.debugLine("entry/src/main/ets/pages/PersonalPage.ets(107:7)", "entry");
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('0');
            Text.debugLine("entry/src/main/ets/pages/PersonalPage.ets(108:9)", "entry");
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor('#333333');
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777264, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/pages/PersonalPage.ets(113:9)", "entry");
            Text.fontSize(SMALL_FONT_SIZE);
            Text.fontColor('#666666');
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 8 });
            Column.debugLine("entry/src/main/ets/pages/PersonalPage.ets(119:7)", "entry");
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('0');
            Text.debugLine("entry/src/main/ets/pages/PersonalPage.ets(120:9)", "entry");
            Text.fontSize(BIGGER_FONT_SIZE);
            Text.fontColor('#333333');
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777243, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Text.debugLine("entry/src/main/ets/pages/PersonalPage.ets(125:9)", "entry");
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
            Row.debugLine("entry/src/main/ets/pages/PersonalPage.ets(140:5)", "entry");
            Row.width(LAYOUT_WIDTH_OR_HEIGHT);
            Row.height(56);
            Row.padding({ left: 16, right: 16 });
            Row.backgroundColor('#FFFFFF');
            Row.onClick(() => {
                // 菜单项点击逻辑
            });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(item.icon);
            Image.debugLine("entry/src/main/ets/pages/PersonalPage.ets(141:7)", "entry");
            Image.width(24);
            Image.height(24);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item.title);
            Text.debugLine("entry/src/main/ets/pages/PersonalPage.ets(145:7)", "entry");
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
                        Image.create({ "id": 16777225, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
                        Image.debugLine("entry/src/main/ets/pages/PersonalPage.ets(151:9)", "entry");
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
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Scroll.create();
            Scroll.debugLine("entry/src/main/ets/pages/PersonalPage.ets(166:5)", "entry");
            Scroll.width(LAYOUT_WIDTH_OR_HEIGHT);
            Scroll.height(LAYOUT_WIDTH_OR_HEIGHT);
            Scroll.backgroundColor('#F5F5F5');
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/PersonalPage.ets(167:7)", "entry");
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
            Column.debugLine("entry/src/main/ets/pages/PersonalPage.ets(175:9)", "entry");
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
                    Divider.debugLine("entry/src/main/ets/pages/PersonalPage.ets(178:13)", "entry");
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
            Button.createWithLabel({ "id": 16777258, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Button.debugLine("entry/src/main/ets/pages/PersonalPage.ets(189:9)", "entry");
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
