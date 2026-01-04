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

import { goodsInitialList, GoodsListItemType, GoodsCategory, getGoodsByCategory, searchGoods } from './InitialData';
import { MAGNIFICATION, MAX_DATA_LENGTH } from '../common/CommonConstants';

// 随机打乱数组
const shuffleArray = <T>(array: T[]): T[] => {
  const shuffled = [...array];
  for (let i = shuffled.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    const temp = shuffled[i];
    shuffled[i] = shuffled[j];
    shuffled[j] = temp;
  }
  return shuffled;
}

const createListRange = (category?: GoodsCategory, shuffle: boolean = false, keyword?: string): GoodsListItemType[] => {
  let baseList: GoodsListItemType[];
  
  // 如果有搜索关键字，优先使用搜索结果
  if (keyword && keyword.trim() !== '') {
    baseList = searchGoods(keyword);
  } else if (category !== undefined && category !== null) {
    // 如果指定了类别，只返回该类别的商品
    baseList = getGoodsByCategory(category);
  } else {
    // 如果没有指定类别，返回所有商品
    baseList = goodsInitialList;
  }
  
  // 如果需要随机打乱（精选页面）
  if (shuffle) {
    baseList = shuffleArray(baseList);
  }
  
  let result = new Array<GoodsListItemType>();
  for (let i = 0; i < MAGNIFICATION; i++) {
    result = result.concat(baseList);
  }
  return result;
}

class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = [];

  public totalCount(): number {
    return 0;
  }

  public getData(index: number): GoodsListItemType | undefined {
    return undefined;
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const position = this.listeners.indexOf(listener);
    if (position >= 0) {
      this.listeners.splice(position, 1);
    }
  }

  notifyDataReload(): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataReloaded();
    })
  }

  notifyDataAdd(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataAdd(index);
    })
  }

  notifyDataChange(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataChange(index);
    })
  }

  notifyDataDelete(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataDelete(index);
    })
  }

  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataMove(from, to);
    })
  }
}

export class ListDataSource extends BasicDataSource {
  private static instances: Map<string, ListDataSource> = new Map();

  private allData: GoodsListItemType[] = []; // 全量数据
  private listData: GoodsListItemType[] = []; // 当前显示的数据
  private pageSize: number = 10;
  private currentPage: number = 0;
  private category?: GoodsCategory;
  private shuffle: boolean = false;
  private keyword?: string;

  private constructor(category?: GoodsCategory, shuffle: boolean = false, keyword?: string) {
    super();
    this.category = category;
    this.shuffle = shuffle;
    this.keyword = keyword;
    this.allData = createListRange(category, shuffle, keyword);
    this.loadNextPage(); // 初始化第一页
  }

  public static getInstance(category?: GoodsCategory, shuffle: boolean = false, keyword?: string): ListDataSource {
    const key = `${category || 'all'}_${shuffle ? 'shuffle' : 'normal'}_${keyword || ''}`;
    // 每次都清除旧实例，创建新实例，确保数据更新
    if (ListDataSource.instances.has(key)) {
      ListDataSource.instances.delete(key);
    }
    ListDataSource.instances.set(key, new ListDataSource(category, shuffle, keyword));
    return ListDataSource.instances.get(key)!;
  }

  public totalCount(): number {
    return this.listData.length;
  }

  public getData(index: number): GoodsListItemType {
    return this.listData[index];
  }

  // 加载下一页数据
  public loadNextPage(): void {
    const start = this.currentPage * this.pageSize;
    const end = Math.min(start + this.pageSize, this.allData.length);
    if (start >= end) return; // 没有更多数据

    this.listData.push(...this.allData.slice(start, end));
    this.notifyDataAdd(this.listData.length - 1);
    this.currentPage++;
  }

  public addNewItem(item: GoodsListItemType): void {
    this.allData.push(item); // 新增商品加入全量数据
  }
  
  // 检查是否还有数据未加载
  public hasMore(): boolean {
    return this.listData.length < this.allData.length;
  }
}
