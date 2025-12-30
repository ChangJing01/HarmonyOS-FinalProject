/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Logger from './Logger';
import { appAccount, BusinessError } from '@kit.BasicServicesKit';

const TAG: string = '[AccountModel]';
const app: appAccount.AppAccountManager = appAccount.createAppAccountManager();

export class AccountModel {
  async addAccount(username: string) {
    try {
      // 【填空】 请使用 app 实例，根据传入的 username 创建一个应用账号
      await app.createAccount(username);
      Logger.info(TAG, `addAccount success`);
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `createAccount failed, error code=${err.code}, message=${err.message}`);
    }
    return;
  }

  async deleteAccount(username: string) {
    try {
      // 【填空】 请使用 app 实例，删除指定 username 的应用账号
      await app.removeAccount(username);
      Logger.info(TAG, `deleteAccount success`);
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `removeAccount failed, error code=${err.code}, message=${err.message}`);
    }
    return;
  }

  async setAccountCredential(username: string, credentialType: string, credential: string) {
    try {
      // 【填空】 请使用 app 实例，为指定账号设置凭证（如密码）
      await app.setCredential(username, credentialType, credentialType);
      Logger.info(TAG, `setAccountCredential success`);
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `setCredential failed, error code=${err.code}, message=${err.message}`);
    }
    return;
  }

  async setAssociatedData(name: string, key: string, value: string) {
    try {
      // 【填空】 请使用 app 实例，为指定账号设置关联数据
      await app.setCustomData(name, key, value);
      Logger.info(TAG, `setAssociatedData success`);
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `setCustomData failed, error code=${err.code}, message=${err.message}`);
    }
    return;
  }

  async getAccountCredential(name: string, credentialType: string) {
    // 【填空】 使用 app 实例，获取指定账号的凭证
    let result = '';
    try {
      // ...
      result = await app.getCredential(name, credentialType);
      Logger.info(TAG, `getAccountCredential success`);
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `getCredential failed, error code=${err.code}, message=${err.message}`);
    }
    return result;
  }

  async getAssociatedData(name: string, key: string) {
    // 【填空】 使用 app 实例，获取指定账号的关联数据
    let result = '';
    try {
      result = await app.getCustomData(name, key);
      Logger.info(TAG, `getAssociatedData success`);
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `getCustomData failed, error code=${err.code}, message=${err.message}`);
    }
    return result;
  }
}
