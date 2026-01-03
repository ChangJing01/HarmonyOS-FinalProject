import router from '@ohos.router';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';
import { BrowsingHistoryItem } from '../viewmodel/InitialData';
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, SMALL_FONT_SIZE, BIGGER_FONT_SIZE } from '../common/CommonConstants';

interface GroupedHistory {
  date: string;
  dateTimestamp: number;
  items: BrowsingHistoryItem[];
}

@Entry
@Component
export default struct BrowsingHistoryPage {
  @StorageLink('browsingHistory') browsingHistory: BrowsingHistoryItem[] = [];
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;
  @State isSelectMode: boolean = false;
  @State isAllSelected: boolean = false;
  @State groupedData: GroupedHistory[] = [];

  aboutToAppear(): void {
    this.groupByDate();
    this.updateAllSelected();
  }

  // 按日期分组
  private groupByDate(): void {
    const groups = new Map<number, BrowsingHistoryItem[]>();
    this.browsingHistory.forEach(item => {
      const dateTs = item.getDateTimestamp();
      if (!groups.has(dateTs)) {
        groups.set(dateTs, []);
      }
      groups.get(dateTs)?.push(item);
    });
    const groupArray: [number, BrowsingHistoryItem[]][] = Array.from(groups.entries());
    const resultArray: GroupedHistory[] = [];
    groupArray.forEach((entry) => {
      const dateTs = entry[0];
      const items = entry[1];
      const grouped: GroupedHistory = {
        date: new Date(dateTs).getFullYear() + '年' + 
              String(new Date(dateTs).getMonth() + 1).padStart(2, '0') + '月' + 
              String(new Date(dateTs).getDate()).padStart(2, '0') + '日',
        dateTimestamp: dateTs,
        items: items
      };
      resultArray.push(grouped);
    });
    this.groupedData = resultArray.sort((a, b) => b.dateTimestamp - a.dateTimestamp);
  }

  // 判断全选
  private updateAllSelected(): void {
    this.isAllSelected = this.browsingHistory.length > 0 && this.browsingHistory.every(h => h.selected);
  }

  // 单个选中/取消
  private toggleItemSelected(itemId: number): void {
    const newBrowsingHistory = this.browsingHistory.map(h => {
      if (h.id === itemId) {
        h.selected = !h.selected;
      }
      return h;
    });
    this.browsingHistory = newBrowsingHistory;
    this.updateAllSelected();
    this.groupByDate();
  }

  // 全选/取消全选
  private toggleSelectAll(): void {
    const newValue = !this.isAllSelected;
    const newBrowsingHistory = this.browsingHistory.map(item => {
      item.selected = newValue;
      return item;
    });
    this.browsingHistory = newBrowsingHistory;
    this.isAllSelected = newValue;
    this.groupByDate();
  }

  // 删除选中项
  private deleteSelected(): void {
    const newHistory = this.browsingHistory.filter(item => !item.selected);
    this.browsingHistory = newHistory;
    this.isSelectMode = newHistory.length > 0 ? this.isSelectMode : false;
    this.groupByDate();
    this.updateAllSelected();
  }

  // 顶部导航栏
  @Builder
  TopNavigationBar() {
    Row() {
      Text('←')
        .fontSize(24)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .onClick(() => { router.back(); })
      Text('浏览记录')
        .fontSize(NORMAL_FONT_SIZE)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
      if (this.browsingHistory.length > 0) {
        Text(this.isSelectMode ? '完成' : '管理')
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor(this.currentThemeColors.accentColor)
          .onClick(() => {
            this.isSelectMode = !this.isSelectMode;
            this.isAllSelected = false;
            this.browsingHistory = this.browsingHistory.map(item => { item.selected = false; return item; });
            this.groupByDate();
          })
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(this.currentThemeColors.backgroundColor)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  // 单条浏览记录
  @Builder
  HistoryItemComponent(item: BrowsingHistoryItem) {
    Row({ space: 12 }) {
      if (this.isSelectMode) {
        Checkbox()
          .select(item.selected)
          .selectedColor('#FF3B30')
          .onChange(() => { this.toggleItemSelected(item.id); })
      }
      Image(item.goodsImg)
        .width(80)
        .height(80)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)
      Column({ space: 8 }) {
        Text(item.goodsName)
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
        Text(item.price)
          .fontSize(BIGGER_FONT_SIZE)
          .fontColor(this.currentThemeColors.accentColor)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding(12)
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .borderRadius(8)
    .onClick(() => { if (this.isSelectMode) { this.toggleItemSelected(item.id); } })
  }

  // 空状态
  @Builder
  EmptyComponent() {
    Column({ space: 16 }) {
      Circle().width(120).height(120).fill('#E0E0E0')
      Text('暂无浏览记录').fontSize(NORMAL_FONT_SIZE).fontColor('#999999')
      Text('点击商品即可查看详情').fontSize(SMALL_FONT_SIZE).fontColor('#CCCCCC')
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .justifyContent(FlexAlign.Center)
  }

  // 底部操作栏
  @Builder
  BottomBar() {
    if (this.isSelectMode) {
      Row({ space: 12 }) {
        Checkbox()
          .select(this.isAllSelected)
          .selectedColor('#FF3B30')
          .onChange(() => { this.toggleSelectAll(); })
        Text('全选').fontSize(SMALL_FONT_SIZE).fontColor(this.currentThemeColors.primaryTextColor)
        Blank().layoutWeight(1)
        Button('删除')
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor('#FFFFFF')
          .backgroundColor('#FF3B30')
          .height(44)
          .borderRadius(8)
          .padding({ left: 24, right: 24 })
          .onClick(() => { this.deleteSelected(); })
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(72)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(this.currentThemeColors.cardBackgroundColor)
      .shadow({ radius: 8, color: '#00000015', offsetY: -2 })
    }
  }

  build() {
    Column() {
      this.TopNavigationBar()
      if (this.browsingHistory.length === 0) {
        this.EmptyComponent()
      } else {
        Scroll() {
          Column({ space: 8 }) {
            ForEach(this.groupedData, (group: GroupedHistory) => {
              Column({ space: 8 }) {
                Text(group.date)
                  .fontSize(NORMAL_FONT_SIZE)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.currentThemeColors.primaryTextColor)
                  .padding({ left: 16, top: 8, bottom: 8 })
                  .alignSelf(ItemAlign.Start)
                Column({ space: 8 }) {
                  ForEach(group.items, (item: BrowsingHistoryItem) => {
                    this.HistoryItemComponent(item)
                  }, (item: BrowsingHistoryItem) => item.id.toString())
                }
                .padding({ left: 16, right: 16 })
              }
            }, (group: GroupedHistory) => group.dateTimestamp.toString())
          }
          .padding({ top: 8, bottom: this.isSelectMode ? 80 : 16 })
          .width(LAYOUT_WIDTH_OR_HEIGHT)
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .backgroundColor(this.currentThemeColors.backgroundColor)
      }
      if (this.isSelectMode) {
        this.BottomBar()
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor(this.currentThemeColors.backgroundColor)
    .padding({ top: 34 }) // 紧接导航栏
  }
}
