import Logger from "@bundle:com.example.list_harmony/entry/ets/model/Logger";
import type common from "@ohos:app.ability.common";
import preferences from "@ohos:data.preferences";
const TAG: string = '[AccountData]';
let storage: preferences.Preferences;
let storageTemp: preferences.Preferences;
export class AccountData {
    /*  static instance: AccountData = null
    
      public static getInstance() {
        if (this.instance === null) {
          this.instance = new AccountData()
        }
        return this.instance
      }*/
    async getFromStorage(context: common.Context, url: string) {
        let name = url;
        Logger.info(TAG, `Name is ${name}`);
        try {
            // 【填空】请使用preferences API，根据context和name获取Preferences实例
            storage = await preferences.getPreferences(context, `${name}`);
        }
        catch (err) {
            Logger.error(`getStorage failed, code is ${err?.code}, message is ${err?.message}`);
        }
        if (storage) {
            Logger.info(TAG, `Create stroage is fail.`);
        }
    }
    async getStorage(context: common.Context, url: string) {
        storage = storageTemp;
        await this.getFromStorage(context, url);
        return storage;
    }
    async putStorageValue(context: common.Context, key: string, value: string, url: string) {
        storage = await this.getStorage(context, url);
        try {
            // 【填空】请使用storage实例，将key和value存入
            await storage.put(key, value);
            // 【填空】数据存入内存后，需要调用哪个方法才能持久化到磁盘？
            await storage.flush();
            Logger.info(TAG, `put key && value success`);
        }
        catch (err) {
            Logger.info(TAG, `aaaaaa put failed`);
        }
        return;
    }
    async hasStorageValue(context: common.Context, key: string, url: string) {
        storage = await this.getStorage(context, url);
        let result: boolean = false;
        try {
            // 【填空】请使用storage实例，检查是否存在指定的key
            result = await storage.has(key);
        }
        catch (err) {
            Logger.error(`hasStorageValue failed, code is ${err?.code}, message is ${err?.message}`);
        }
        Logger.info(TAG, `hasStorageValue success result is ${result}`);
        return result;
    }
    async getStorageValue(context: common.Context, key: string, url: string) {
        storage = await this.getStorage(context, url);
        let getValue: preferences.ValueType = 'null';
        try {
            // 【填空】请使用storage实例，根据key获取值
            getValue = await storage.get(key, 'null');
        }
        catch (err) {
            Logger.error(`getStorageValue failed, code is ${err?.code}, message is ${err?.message}`);
        }
        Logger.info(TAG, `getStorageValue success`);
        return getValue;
    }
    async deleteStorageValue(context: common.Context, key: string, url: string) {
        storage = await this.getStorage(context, url);
        try {
            // 【填空】 请使用storage实例，删除指定key的数据
            await storage.delete(key);
            // 【填空】 删除操作后，同样需要持久化到磁盘
            await storage.flush();
        }
        catch (err) {
            Logger.error(`deleteStorageValue failed, code is ${err?.code}, message is ${err?.message}`);
        }
        Logger.info(TAG, `delete success`);
        return;
    }
}
