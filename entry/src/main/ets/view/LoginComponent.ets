/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, BIGGER_FONT_SIZE, SMALL_FONT_SIZE } from '../common/CommonConstants';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';
import { AccountModel } from '../model/AccountModel';
import { AccountData } from '../model/AccountData';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import promptAction from '@ohos.promptAction';
import Logger from '../model/Logger';

const TAG: string = '[LoginComponent]';

@Component
export default struct LoginComponent {
  @Prop currentThemeColors: ThemeColors = DEFAULT_THEME;
  @State username: string = '';
  @State password: string = '';
  @State confirmPassword: string = '';
  @State isLoading: boolean = false;
  @State isRegisterMode: boolean = false;
  //使用 @StorageLink 与全局 AppStorage 双向绑定登录状态和用户名
  @StorageLink('isLoggedIn') isLoggedIn: boolean = false;
  @StorageLink('currentUsername') currentUsername: string = '';
  private accountModel: AccountModel = new AccountModel();
  private accountData: AccountData = new AccountData();
  private context: common.Context = getContext(this) as common.Context;
  // 用于父组件更新登录状态的回调
  onLoginSuccess?: (username: string) => void;

  // 处理登录
  async handleLogin() {
    if (!this.username.trim() || !this.password.trim()) {
      try {
        promptAction.showToast({
          message: '请输入账号和密码',
          duration: 2000
        });
      } catch (_) {
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
        } catch (_) {
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
        } catch (_) {
          Logger.error(TAG, `showToast failed`);
        }
        this.isLoading = false;
        return;
      }

      // 验证用户是否已注册（检查用户名是否存在于Preferences中）
      const STORAGE_KEY = 'account_storage';
      const registeredUsersKey = 'registered_users';
      let registeredUsers = await this.accountData.getStorageValue(
        this.context,
        registeredUsersKey,
        STORAGE_KEY
      ) as string;
      
      if (!registeredUsers || !registeredUsers.includes(this.username)) {
        try {
          promptAction.showToast({
            message: '该账号不存在，请先注册',
            duration: 2000
          });
        } catch (_) {
          Logger.error(TAG, `showToast failed`);
        }
        this.isLoading = false;
        return;
      }

      // 验证密码是否正确
      const passwordKey = `password_${this.username}`;
      let savedPassword = await this.accountData.getStorageValue(
        this.context,
        passwordKey,
        STORAGE_KEY
      ) as string;
      
      if (!savedPassword || savedPassword !== this.password) {
        try {
          promptAction.showToast({
            message: '密码错误，请重试',
            duration: 2000
          });
        } catch (_) {
          Logger.error(TAG, `showToast failed`);
        }
        this.isLoading = false;
        return;
      }

      // 使用 AccountData 保存登录状态
      await this.accountData.putStorageValue(
        this.context,
        'isLoggedIn',
        'true',
        STORAGE_KEY
      );
      await this.accountData.putStorageValue(
        this.context,
        'username',
        this.username,
        STORAGE_KEY
      );

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
      } catch (_) {
        Logger.error(TAG, `showToast failed`);
      }
    } catch (_) {
      Logger.error(TAG, `Login failed`);
      try {
        promptAction.showToast({
          message: '登录失败，请重试',
          duration: 2000
        });
      } catch (_) {
        Logger.error(TAG, `showToast failed`);
      }
    } finally {
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
      } catch (_) {
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
      } catch (_) {
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
        } catch (_) {
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
        } catch (_) {
          Logger.error(TAG, `showToast failed`);
        }
        this.isLoading = false;
        return;
      }

      // 使用 AccountModel 创建账号
      await this.accountModel.addAccount(this.username);

      // 设置凭证（密码）
      await this.accountModel.setAccountCredential(
        this.username,
        'password',
        this.password
      );

      // 保存注册用户名到registered_users列表
      const STORAGE_KEY = 'account_storage';
      const registeredUsersKey = 'registered_users';
      let registeredUsers = await this.accountData.getStorageValue(
        this.context,
        registeredUsersKey,
        STORAGE_KEY
      ) as string;
      
      if (!registeredUsers) {
        registeredUsers = this.username;
      } else {
        registeredUsers = registeredUsers + ',' + this.username;
      }
      
      await this.accountData.putStorageValue(
        this.context,
        registeredUsersKey,
        registeredUsers,
        STORAGE_KEY
      );

      // 保存密码（使用password_用户名作为key）
      const passwordKey = `password_${this.username}`;
      await this.accountData.putStorageValue(
        this.context,
        passwordKey,
        this.password,
        STORAGE_KEY
      );

      // 使用 AccountData 保存注册状态
      await this.accountData.putStorageValue(
        this.context,
        'isLoggedIn',
        'true',
        STORAGE_KEY
      );
      await this.accountData.putStorageValue(
        this.context,
        'username',
        this.username,
        STORAGE_KEY
      );

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
      } catch (_) {
        Logger.error(TAG, `showToast failed`);
      }
      
      // 清空表单
      this.username = '';
      this.password = '';
      this.confirmPassword = '';
      this.isRegisterMode = false;
    } catch (_) {
      Logger.error(TAG, `Register failed`);
      try {
        promptAction.showToast({
          message: '注册失败，请重试',
          duration: 2000
        });
      } catch (_) {
        Logger.error(TAG, `showToast failed`);
      }
    } finally {
      this.isLoading = false;
    }
  }

  build() {
    Scroll() {
      Column({ space: 24 }) {
        // 标题
        if (!this.isRegisterMode) {
          Text('欢迎登录')
            .fontSize(BIGGER_FONT_SIZE + 8)
            .fontColor(this.currentThemeColors.primaryTextColor)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 40 })

          Text('请输入您的账号和密码')
            .fontSize(SMALL_FONT_SIZE)
            .fontColor(this.currentThemeColors.secondaryTextColor)
        } else {
          Text('创建新账号')
            .fontSize(BIGGER_FONT_SIZE + 8)
            .fontColor(this.currentThemeColors.primaryTextColor)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 40 })

          Text('注册一个新的账号')
            .fontSize(SMALL_FONT_SIZE)
            .fontColor(this.currentThemeColors.secondaryTextColor)
        }

        // 账号输入框
        Column({ space: 8 }) {
          Text('账号')
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)

          TextInput({
            placeholder: '请输入账号（至少3位）',
            text: this.username
          })
            .type(InputType.Normal)
            .placeholderColor(this.currentThemeColors.secondaryTextColor)
            .placeholderFont({ size: NORMAL_FONT_SIZE })
            .caretColor(this.currentThemeColors.accentColor)
            .padding(12)
            .backgroundColor(this.currentThemeColors.cardBackgroundColor)
            .borderRadius(8)
            .onChange((value: string) => {
              this.username = value;
            })
        }

        // 密码输入框
        Column({ space: 8 }) {
          Text('密码')
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)

          TextInput({
            placeholder: '请输入密码（至少5位）',
            text: this.password
          })
            .type(InputType.Password)
            .placeholderColor(this.currentThemeColors.secondaryTextColor)
            .placeholderFont({ size: NORMAL_FONT_SIZE })
            .caretColor(this.currentThemeColors.accentColor)
            .padding(12)
            .backgroundColor(this.currentThemeColors.cardBackgroundColor)
            .borderRadius(8)
            .onChange((value: string) => {
              this.password = value;
            })
        }

        // 注册模式下显示确认密码
        if (this.isRegisterMode) {
          Column({ space: 8 }) {
            Text('确认密码')
              .fontSize(NORMAL_FONT_SIZE)
              .fontColor(this.currentThemeColors.primaryTextColor)

            TextInput({
              placeholder: '请再次输入密码',
              text: this.confirmPassword
            })
              .type(InputType.Password)
              .placeholderColor(this.currentThemeColors.secondaryTextColor)
              .placeholderFont({ size: NORMAL_FONT_SIZE })
              .caretColor(this.currentThemeColors.accentColor)
              .padding(12)
              .backgroundColor(this.currentThemeColors.cardBackgroundColor)
              .borderRadius(8)
              .onChange((value: string) => {
                this.confirmPassword = value;
              })
          }
        }

        // 登录/注册按钮
        Button(this.isRegisterMode ? '注册' : '登录')
          .type(ButtonType.Capsule)
          .width(LAYOUT_WIDTH_OR_HEIGHT)
          .height(48)
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor('#FFFFFF')
          .backgroundColor(this.currentThemeColors.accentColor)
          .enabled(!this.isLoading)
          .onClick(() => {
            if (this.isRegisterMode) {
              this.handleRegister();
            } else {
              this.handleLogin();
            }
          })

        // 切换按钮
        Button(this.isRegisterMode ? '返回登录' : '注册新账号')
          .type(ButtonType.Capsule)
          .width(LAYOUT_WIDTH_OR_HEIGHT)
          .height(48)
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor(this.currentThemeColors.accentColor)
          .backgroundColor(this.currentThemeColors.cardBackgroundColor)
          .borderWidth(1)
          .borderColor(this.currentThemeColors.accentColor)
          .enabled(!this.isLoading)
          .onClick(() => {
            // 切换模式时清空表单
            this.username = '';
            this.password = '';
            this.confirmPassword = '';
            this.isRegisterMode = !this.isRegisterMode;
          })

        Blank()
      }
      .padding(16)
      .margin({ left: 16, right: 16 })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor(this.currentThemeColors.backgroundColor)
  }
}