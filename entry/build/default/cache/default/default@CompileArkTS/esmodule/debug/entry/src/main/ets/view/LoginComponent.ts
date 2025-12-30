if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface LoginComponent_Params {
    currentThemeColors?: ThemeColors;
    username?: string;
    password?: string;
    confirmPassword?: string;
    isLoading?: boolean;
    isRegisterMode?: boolean;
    isLoggedIn?: boolean;
    currentUsername?: string;
    accountModel?: AccountModel;
    accountData?: AccountData;
    context?: common.Context;
    // 用于父组件更新登录状态的回调
    onLoginSuccess?: (username: string) => void;
}
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, BIGGER_FONT_SIZE, SMALL_FONT_SIZE } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
import { DEFAULT_THEME } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import type { ThemeColors } from "@bundle:com.example.list_harmony/entry/ets/common/Colors";
import { AccountModel } from "@bundle:com.example.list_harmony/entry/ets/model/AccountModel";
import { AccountData } from "@bundle:com.example.list_harmony/entry/ets/model/AccountData";
import type common from "@ohos:app.ability.common";
import promptAction from "@ohos:promptAction";
import Logger from "@bundle:com.example.list_harmony/entry/ets/model/Logger";
const TAG: string = '[LoginComponent]';
export default class LoginComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__currentThemeColors = new SynchedPropertyObjectOneWayPU(params.currentThemeColors, this, "currentThemeColors");
        this.__username = new ObservedPropertySimplePU('', this, "username");
        this.__password = new ObservedPropertySimplePU('', this, "password");
        this.__confirmPassword = new ObservedPropertySimplePU('', this, "confirmPassword");
        this.__isLoading = new ObservedPropertySimplePU(false, this, "isLoading");
        this.__isRegisterMode = new ObservedPropertySimplePU(false, this, "isRegisterMode");
        this.__isLoggedIn = this.createStorageLink('isLoggedIn', false, "isLoggedIn");
        this.__currentUsername = this.createStorageLink('currentUsername', '', "currentUsername");
        this.accountModel = new AccountModel();
        this.accountData = new AccountData();
        this.context = getContext(this) as common.Context;
        this.onLoginSuccess = undefined;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: LoginComponent_Params) {
        if (params.currentThemeColors === undefined) {
            this.__currentThemeColors.set(DEFAULT_THEME);
        }
        if (params.username !== undefined) {
            this.username = params.username;
        }
        if (params.password !== undefined) {
            this.password = params.password;
        }
        if (params.confirmPassword !== undefined) {
            this.confirmPassword = params.confirmPassword;
        }
        if (params.isLoading !== undefined) {
            this.isLoading = params.isLoading;
        }
        if (params.isRegisterMode !== undefined) {
            this.isRegisterMode = params.isRegisterMode;
        }
        if (params.accountModel !== undefined) {
            this.accountModel = params.accountModel;
        }
        if (params.accountData !== undefined) {
            this.accountData = params.accountData;
        }
        if (params.context !== undefined) {
            this.context = params.context;
        }
        if (params.onLoginSuccess !== undefined) {
            this.onLoginSuccess = params.onLoginSuccess;
        }
    }
    updateStateVars(params: LoginComponent_Params) {
        this.__currentThemeColors.reset(params.currentThemeColors);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__currentThemeColors.purgeDependencyOnElmtId(rmElmtId);
        this.__username.purgeDependencyOnElmtId(rmElmtId);
        this.__password.purgeDependencyOnElmtId(rmElmtId);
        this.__confirmPassword.purgeDependencyOnElmtId(rmElmtId);
        this.__isLoading.purgeDependencyOnElmtId(rmElmtId);
        this.__isRegisterMode.purgeDependencyOnElmtId(rmElmtId);
        this.__isLoggedIn.purgeDependencyOnElmtId(rmElmtId);
        this.__currentUsername.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__currentThemeColors.aboutToBeDeleted();
        this.__username.aboutToBeDeleted();
        this.__password.aboutToBeDeleted();
        this.__confirmPassword.aboutToBeDeleted();
        this.__isLoading.aboutToBeDeleted();
        this.__isRegisterMode.aboutToBeDeleted();
        this.__isLoggedIn.aboutToBeDeleted();
        this.__currentUsername.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __currentThemeColors: SynchedPropertySimpleOneWayPU<ThemeColors>;
    get currentThemeColors() {
        return this.__currentThemeColors.get();
    }
    set currentThemeColors(newValue: ThemeColors) {
        this.__currentThemeColors.set(newValue);
    }
    private __username: ObservedPropertySimplePU<string>;
    get username() {
        return this.__username.get();
    }
    set username(newValue: string) {
        this.__username.set(newValue);
    }
    private __password: ObservedPropertySimplePU<string>;
    get password() {
        return this.__password.get();
    }
    set password(newValue: string) {
        this.__password.set(newValue);
    }
    private __confirmPassword: ObservedPropertySimplePU<string>;
    get confirmPassword() {
        return this.__confirmPassword.get();
    }
    set confirmPassword(newValue: string) {
        this.__confirmPassword.set(newValue);
    }
    private __isLoading: ObservedPropertySimplePU<boolean>;
    get isLoading() {
        return this.__isLoading.get();
    }
    set isLoading(newValue: boolean) {
        this.__isLoading.set(newValue);
    }
    private __isRegisterMode: ObservedPropertySimplePU<boolean>;
    get isRegisterMode() {
        return this.__isRegisterMode.get();
    }
    set isRegisterMode(newValue: boolean) {
        this.__isRegisterMode.set(newValue);
    }
    //使用 @StorageLink 与全局 AppStorage 双向绑定登录状态和用户名
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
    private accountModel: AccountModel;
    private accountData: AccountData;
    private context: common.Context;
    // 用于父组件更新登录状态的回调
    private onLoginSuccess?: (username: string) => void;
    // 处理登录
    async handleLogin() {
        if (!this.username.trim() || !this.password.trim()) {
            try {
                promptAction.showToast({
                    message: '请输入账号和密码',
                    duration: 2000
                });
            }
            catch (_) {
                Logger.error(TAG, `showToast failed`);
            }
            return;
        }
        this.isLoading = true;
        try {
            // 验证账号密码（简单校验：账号长度>3，密码长度>5）
            if (this.username.length < 3) {
                try {
                    promptAction.showToast({
                        message: '账号长度至少3位',
                        duration: 2000
                    });
                }
                catch (_) {
                    Logger.error(TAG, `showToast failed`);
                }
                this.isLoading = false;
                return;
            }
            if (this.password.length < 5) {
                try {
                    promptAction.showToast({
                        message: '密码长度至少5位',
                        duration: 2000
                    });
                }
                catch (_) {
                    Logger.error(TAG, `showToast failed`);
                }
                this.isLoading = false;
                return;
            }
            // 验证用户是否已注册（检查用户名是否存在于Preferences中）
            const STORAGE_KEY = 'account_storage';
            const registeredUsersKey = 'registered_users';
            let registeredUsers = await this.accountData.getStorageValue(this.context, registeredUsersKey, STORAGE_KEY) as string;
            if (!registeredUsers || !registeredUsers.includes(this.username)) {
                try {
                    promptAction.showToast({
                        message: '该账号不存在，请先注册',
                        duration: 2000
                    });
                }
                catch (_) {
                    Logger.error(TAG, `showToast failed`);
                }
                this.isLoading = false;
                return;
            }
            // 验证密码是否正确
            const passwordKey = `password_${this.username}`;
            let savedPassword = await this.accountData.getStorageValue(this.context, passwordKey, STORAGE_KEY) as string;
            if (!savedPassword || savedPassword !== this.password) {
                try {
                    promptAction.showToast({
                        message: '密码错误，请重试',
                        duration: 2000
                    });
                }
                catch (_) {
                    Logger.error(TAG, `showToast failed`);
                }
                this.isLoading = false;
                return;
            }
            // 使用 AccountData 保存登录状态
            await this.accountData.putStorageValue(this.context, 'isLoggedIn', 'true', STORAGE_KEY);
            await this.accountData.putStorageValue(this.context, 'username', this.username, STORAGE_KEY);
            Logger.info(TAG, `Login successful for user: ${this.username}`);
            this.currentUsername = this.username;
            this.isLoggedIn = true;
            // 调用回调函数通知父组件
            if (this.onLoginSuccess) {
                this.onLoginSuccess(this.username);
            }
            try {
                promptAction.showToast({
                    message: '登录成功',
                    duration: 2000
                });
            }
            catch (_) {
                Logger.error(TAG, `showToast failed`);
            }
        }
        catch (_) {
            Logger.error(TAG, `Login failed`);
            try {
                promptAction.showToast({
                    message: '登录失败，请重试',
                    duration: 2000
                });
            }
            catch (_) {
                Logger.error(TAG, `showToast failed`);
            }
        }
        finally {
            this.isLoading = false;
        }
    }
    // 处理注册
    async handleRegister() {
        if (!this.username.trim() || !this.password.trim() || !this.confirmPassword.trim()) {
            try {
                promptAction.showToast({
                    message: '请输入账号、密码和确认密码',
                    duration: 2000
                });
            }
            catch (_) {
                Logger.error(TAG, `showToast failed`);
            }
            return;
        }
        if (this.password !== this.confirmPassword) {
            try {
                promptAction.showToast({
                    message: '两次密码输入不一致',
                    duration: 2000
                });
            }
            catch (_) {
                Logger.error(TAG, `showToast failed`);
            }
            return;
        }
        this.isLoading = true;
        try {
            if (this.username.length < 3) {
                try {
                    promptAction.showToast({
                        message: '账号长度至少3位',
                        duration: 2000
                    });
                }
                catch (_) {
                    Logger.error(TAG, `showToast failed`);
                }
                this.isLoading = false;
                return;
            }
            if (this.password.length < 5) {
                try {
                    promptAction.showToast({
                        message: '密码长度至少5位',
                        duration: 2000
                    });
                }
                catch (_) {
                    Logger.error(TAG, `showToast failed`);
                }
                this.isLoading = false;
                return;
            }
            // 使用 AccountModel 创建账号
            await this.accountModel.addAccount(this.username);
            // 设置凭证（密码）
            await this.accountModel.setAccountCredential(this.username, 'password', this.password);
            // 保存注册用户名到registered_users列表
            const STORAGE_KEY = 'account_storage';
            const registeredUsersKey = 'registered_users';
            let registeredUsers = await this.accountData.getStorageValue(this.context, registeredUsersKey, STORAGE_KEY) as string;
            if (!registeredUsers) {
                registeredUsers = this.username;
            }
            else {
                registeredUsers = registeredUsers + ',' + this.username;
            }
            await this.accountData.putStorageValue(this.context, registeredUsersKey, registeredUsers, STORAGE_KEY);
            // 保存密码（使用password_用户名作为key）
            const passwordKey = `password_${this.username}`;
            await this.accountData.putStorageValue(this.context, passwordKey, this.password, STORAGE_KEY);
            // 使用 AccountData 保存注册状态
            await this.accountData.putStorageValue(this.context, 'isLoggedIn', 'true', STORAGE_KEY);
            await this.accountData.putStorageValue(this.context, 'username', this.username, STORAGE_KEY);
            Logger.info(TAG, `Register successful for user: ${this.username}`);
            this.currentUsername = this.username;
            this.isLoggedIn = true;
            // 调用回调函数通知父组件
            if (this.onLoginSuccess) {
                this.onLoginSuccess(this.username);
            }
            try {
                promptAction.showToast({
                    message: '注册成功',
                    duration: 2000
                });
            }
            catch (_) {
                Logger.error(TAG, `showToast failed`);
            }
            // 清空表单
            this.username = '';
            this.password = '';
            this.confirmPassword = '';
            this.isRegisterMode = false;
        }
        catch (_) {
            Logger.error(TAG, `Register failed`);
            try {
                promptAction.showToast({
                    message: '注册失败，请重试',
                    duration: 2000
                });
            }
            catch (_) {
                Logger.error(TAG, `showToast failed`);
            }
        }
        finally {
            this.isLoading = false;
        }
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Scroll.create();
            Scroll.width(LAYOUT_WIDTH_OR_HEIGHT);
            Scroll.height(LAYOUT_WIDTH_OR_HEIGHT);
            Scroll.backgroundColor(this.currentThemeColors.backgroundColor);
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 24 });
            Column.padding(16);
            Column.margin({ left: 16, right: 16 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            // 标题
            if (!this.isRegisterMode) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create('欢迎登录');
                        Text.fontSize(BIGGER_FONT_SIZE + 8);
                        Text.fontColor(this.currentThemeColors.primaryTextColor);
                        Text.fontWeight(FontWeight.Bold);
                        Text.margin({ top: 40 });
                    }, Text);
                    Text.pop();
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create('请输入您的账号和密码');
                        Text.fontSize(SMALL_FONT_SIZE);
                        Text.fontColor(this.currentThemeColors.secondaryTextColor);
                    }, Text);
                    Text.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create('创建新账号');
                        Text.fontSize(BIGGER_FONT_SIZE + 8);
                        Text.fontColor(this.currentThemeColors.primaryTextColor);
                        Text.fontWeight(FontWeight.Bold);
                        Text.margin({ top: 40 });
                    }, Text);
                    Text.pop();
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create('注册一个新的账号');
                        Text.fontSize(SMALL_FONT_SIZE);
                        Text.fontColor(this.currentThemeColors.secondaryTextColor);
                    }, Text);
                    Text.pop();
                });
            }
        }, If);
        If.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 账号输入框
            Column.create({ space: 8 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('账号');
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({
                placeholder: '请输入账号（至少3位）',
                text: this.username
            });
            TextInput.type(InputType.Normal);
            TextInput.placeholderColor(this.currentThemeColors.secondaryTextColor);
            TextInput.placeholderFont({ size: NORMAL_FONT_SIZE });
            TextInput.caretColor(this.currentThemeColors.accentColor);
            TextInput.padding(12);
            TextInput.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            TextInput.borderRadius(8);
            TextInput.onChange((value: string) => {
                this.username = value;
            });
        }, TextInput);
        // 账号输入框
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 密码输入框
            Column.create({ space: 8 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('密码');
            Text.fontSize(NORMAL_FONT_SIZE);
            Text.fontColor(this.currentThemeColors.primaryTextColor);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({
                placeholder: '请输入密码（至少5位）',
                text: this.password
            });
            TextInput.type(InputType.Password);
            TextInput.placeholderColor(this.currentThemeColors.secondaryTextColor);
            TextInput.placeholderFont({ size: NORMAL_FONT_SIZE });
            TextInput.caretColor(this.currentThemeColors.accentColor);
            TextInput.padding(12);
            TextInput.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            TextInput.borderRadius(8);
            TextInput.onChange((value: string) => {
                this.password = value;
            });
        }, TextInput);
        // 密码输入框
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            // 注册模式下显示确认密码
            if (this.isRegisterMode) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Column.create({ space: 8 });
                    }, Column);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create('确认密码');
                        Text.fontSize(NORMAL_FONT_SIZE);
                        Text.fontColor(this.currentThemeColors.primaryTextColor);
                    }, Text);
                    Text.pop();
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        TextInput.create({
                            placeholder: '请再次输入密码',
                            text: this.confirmPassword
                        });
                        TextInput.type(InputType.Password);
                        TextInput.placeholderColor(this.currentThemeColors.secondaryTextColor);
                        TextInput.placeholderFont({ size: NORMAL_FONT_SIZE });
                        TextInput.caretColor(this.currentThemeColors.accentColor);
                        TextInput.padding(12);
                        TextInput.backgroundColor(this.currentThemeColors.cardBackgroundColor);
                        TextInput.borderRadius(8);
                        TextInput.onChange((value: string) => {
                            this.confirmPassword = value;
                        });
                    }, TextInput);
                    Column.pop();
                });
            }
            // 登录/注册按钮
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 登录/注册按钮
            Button.createWithLabel(this.isRegisterMode ? '注册' : '登录');
            // 登录/注册按钮
            Button.type(ButtonType.Capsule);
            // 登录/注册按钮
            Button.width(LAYOUT_WIDTH_OR_HEIGHT);
            // 登录/注册按钮
            Button.height(48);
            // 登录/注册按钮
            Button.fontSize(NORMAL_FONT_SIZE);
            // 登录/注册按钮
            Button.fontColor('#FFFFFF');
            // 登录/注册按钮
            Button.backgroundColor(this.currentThemeColors.accentColor);
            // 登录/注册按钮
            Button.enabled(!this.isLoading);
            // 登录/注册按钮
            Button.onClick(() => {
                if (this.isRegisterMode) {
                    this.handleRegister();
                }
                else {
                    this.handleLogin();
                }
            });
        }, Button);
        // 登录/注册按钮
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 切换按钮
            Button.createWithLabel(this.isRegisterMode ? '返回登录' : '注册新账号');
            // 切换按钮
            Button.type(ButtonType.Capsule);
            // 切换按钮
            Button.width(LAYOUT_WIDTH_OR_HEIGHT);
            // 切换按钮
            Button.height(48);
            // 切换按钮
            Button.fontSize(NORMAL_FONT_SIZE);
            // 切换按钮
            Button.fontColor(this.currentThemeColors.accentColor);
            // 切换按钮
            Button.backgroundColor(this.currentThemeColors.cardBackgroundColor);
            // 切换按钮
            Button.borderWidth(1);
            // 切换按钮
            Button.borderColor(this.currentThemeColors.accentColor);
            // 切换按钮
            Button.enabled(!this.isLoading);
            // 切换按钮
            Button.onClick(() => {
                // 切换模式时清空表单
                this.username = '';
                this.password = '';
                this.confirmPassword = '';
                this.isRegisterMode = !this.isRegisterMode;
            });
        }, Button);
        // 切换按钮
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Blank.create();
        }, Blank);
        Blank.pop();
        Column.pop();
        Scroll.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
