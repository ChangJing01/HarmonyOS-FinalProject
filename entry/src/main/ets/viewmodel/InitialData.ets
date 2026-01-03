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
$r('app.string.mobile_phone'),
$r('app.string.clothes'),
$r('app.string.wear'),
$r('app.string.home_furnishing')
]

export class GoodsListItemType {
  id:number;
  goodsImg: Resource | string;
  goodsName: string | Resource;
  advertisingLanguage: string | Resource;
  evaluate: string | Resource;
  price: string | Resource;

  constructor(id: number, goodsImg: Resource | string, goodsName: string | Resource, price: string | Resource) {
    this.id = id;
    this.goodsImg = goodsImg;
    this.goodsName = goodsName;
    this.advertisingLanguage = $r('app.string.advertising_language');
    this.evaluate = $r('app.string.evaluate');
    this.price = price;
  }
}

// 浏览记录类型
export class BrowsingHistoryItem {
  id: number;
  goodsImg: Resource | string;
  goodsName: string;
  price: string;
  browsedTime: number; // 毫秒级时间戳
  selected: boolean;

  constructor(id: number, goodsImg: Resource | string, goodsName: string, price: string, browsedTime: number) {
    this.id = id;
    this.goodsImg = goodsImg;
    this.goodsName = goodsName;
    this.price = price;
    this.browsedTime = browsedTime;
    this.selected = false;
  }

  // 获取浏览日期的格式化字符串
  getFormattedDate(): string {
    const date = new Date(this.browsedTime);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}年${month}月${day}日`;
  }

  // 获取浏览日期的时间戳（用于分组，精确到天）
  getDateTimestamp(): number {
    const date = new Date(this.browsedTime);
    date.setHours(0, 0, 0, 0);
    return date.getTime();
  }
}

export const goodsInitialList: GoodsListItemType[] = [
  new GoodsListItemType(1,$r('app.media.goodsImg'), $r('app.string.goodsName'), $r('app.string.price_199')),
  new GoodsListItemType(2,$r('app.media.goodsImg_2'), $r('app.string.another_goodsName'), $r('app.string.price_199')),
  new GoodsListItemType(3,$r('app.media.goodsImg_3'), $r('app.string.goodsName'), $r('app.string.price_199')),
  new GoodsListItemType(4,$r('app.media.goodsImg_4'), $r('app.string.another_goodsName'), $r('app.string.price_199'))
]
