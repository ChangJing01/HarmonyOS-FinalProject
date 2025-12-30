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
export const initTabBarData = [
    { "id": 16777247, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
    { "id": 16777230, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
    { "id": 16777288, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" },
    { "id": 16777243, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }
];
export class GoodsListItemType {
    id: number;
    goodsImg: Resource;
    goodsName: Resource;
    advertisingLanguage: Resource;
    evaluate: Resource;
    price: Resource;
    constructor(id: number, goodsImg: Resource, goodsName: Resource, price: Resource) {
        this.id = id;
        this.goodsImg = goodsImg;
        this.goodsName = goodsName;
        this.advertisingLanguage = { "id": 16777222, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
        this.evaluate = { "id": 16777235, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" };
        this.price = price;
    }
}
export const goodsInitialList: GoodsListItemType[] = [
    new GoodsListItemType(1, { "id": 16777294, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, { "id": 16777238, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, { "id": 16777255, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }),
    new GoodsListItemType(2, { "id": 16777295, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, { "id": 16777223, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, { "id": 16777255, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }),
    new GoodsListItemType(3, { "id": 16777296, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, { "id": 16777238, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, { "id": 16777255, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }),
    new GoodsListItemType(4, { "id": 16777297, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, { "id": 16777223, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" }, { "id": 16777255, "type": 10003, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" })
];
