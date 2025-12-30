import { goodsInitialList } from "@bundle:com.example.list_harmony/entry/ets/viewmodel/InitialData";
import type { GoodsListItemType } from "@bundle:com.example.list_harmony/entry/ets/viewmodel/InitialData";
import { MAGNIFICATION, MAX_DATA_LENGTH } from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
/**
 * create a List range
 */
const createListRange = (): GoodsListItemType[] => {
    let result = new Array<GoodsListItemType>();
    for (let i = 0; i < MAGNIFICATION; i++) {
        result = result.concat(goodsInitialList);
    }
    return result;
};
/**
 * LazyLoad Class
 */
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
        });
    }
    notifyDataAdd(index: number): void {
        this.listeners.forEach((listener: DataChangeListener) => {
            listener.onDataAdd(index);
        });
    }
    notifyDataChange(index: number): void {
        this.listeners.forEach((listener: DataChangeListener) => {
            listener.onDataChange(index);
        });
    }
    notifyDataDelete(index: number): void {
        this.listeners.forEach((listener: DataChangeListener) => {
            listener.onDataDelete(index);
        });
    }
    notifyDataMove(from: number, to: number): void {
        this.listeners.forEach((listener: DataChangeListener) => {
            listener.onDataMove(from, to);
        });
    }
}
export class ListDataSource extends BasicDataSource {
    private listData = createListRange();
    public totalCount(): number {
        return this.listData.length;
    }
    public getData(index: number): GoodsListItemType {
        return this.listData[index];
    }
    public pushData(): void {
        if (this.listData.length < MAX_DATA_LENGTH) {
            this.listData = this.listData.concat(goodsInitialList);
            this.notifyDataAdd(this.listData.length - 1);
        }
    }
}
