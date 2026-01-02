import router from '@ohos.router';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, SMALL_FONT_SIZE, BIGGER_FONT_SIZE } from '../common/CommonConstants';
import { common } from '@kit.AbilityKit';
import { AccountData } from '../model/AccountData';
import Logger from '../model/Logger';
import promptAction from '@ohos.promptAction';

const TAG: string = '[EditProfilePage]';

@Entry
@Component
export default struct EditProfilePage {
    @StorageLink('currentUsername') currentUsername: string = '';
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;
  @State userAvatar: Resource = $r('app.media.ic_avatar');
  @State accountName: string = '';
  @State nickname: string = '';
  @State gender: string = '保密'; // 保密、男、女
  @State birthDate: string = '';
  @State address: string = '';
  @State isLoading: boolean = false;

  private accountData: AccountData = new AccountData();
  private context: common.Context = getContext(this) as common.Context;

  aboutToAppear(): void {
    this.loadUserData();
  }

  // 加载用户数据
  private loadUserData(): void {
    try {
      const STORAGE_KEY = 'account_storage';
      // 从存储获取账号名
      this.accountData.getStorageValue(
        this.context,
        'username',
        STORAGE_KEY
      ).then((result) => {
        this.accountName = String(result) || '';
        Logger.info(TAG, `Loaded username: ${this.accountName}`);
      }).catch(() => {
        Logger.error(TAG, 'Failed to load username');
      });
    } catch (_) {
      Logger.error(TAG, 'loadUserData failed');
    }
  }

  // 选择头像（模拟）
  private selectAvatar(): void {
    try {
      promptAction.showToast({
        message: '头像修改功能开发中',
        duration: 2000
      });
    } catch (_) {
      Logger.error(TAG, 'showToast failed');
    }
  }

  // 选择性别
  private selectGender(): void {
    try {
      promptAction.showActionMenu({
        title: '选择性别',
        buttons: [
          { text: '保密', color: '#333333' },
          { text: '男', color: '#333333' },
          { text: '女', color: '#333333' }
        ]
      }).then((data) => {
        const genders: string[] = ['保密', '男', '女'];
        this.gender = genders[data.index];
      }).catch(() => {
        Logger.error(TAG, 'showActionMenu failed');
      });
    } catch (_) {
      Logger.error(TAG, 'selectGender failed');
    }
  }

  // 选择出生日期
  private selectBirthDate(): void {
    try {
      promptAction.showToast({
        message: '出生日期选择功能开发中',
        duration: 2000
      });
    } catch (_) {
      Logger.error(TAG, 'showToast failed');
    }
  }

  // 保存信息
  private saveProfile(): void {
    if (!this.accountName.trim()) {
      try {
        promptAction.showToast({
          message: '账号名不能为空',
          duration: 2000
        });
      } catch (_) {
        Logger.error(TAG, 'showToast failed');
      }
      return;
    }

    this.isLoading = true;
    try {
      const STORAGE_KEY = 'account_storage';
      this.accountData.putStorageValue(
        this.context,
        'username',
        this.accountName,
        STORAGE_KEY
      ).then((): void => {
        this.isLoading = false;
        try {
          promptAction.showToast({
            message: '保存成功',
            duration: 2000
          });
        } catch (_) {
          Logger.error(TAG, 'showToast failed');
        }
        // 返回上一页
        setTimeout(() => {
          router.back();
        }, 500);
      }).catch((): void => {
        this.isLoading = false;
        Logger.error(TAG, 'Save profile failed');
        try {
          promptAction.showToast({
            message: '保存失败',
            duration: 2000
          });
        } catch (_) {
          Logger.error(TAG, 'showToast failed');
        }
      });
    } catch (_) {
      this.isLoading = false;
      Logger.error(TAG, 'saveProfile failed');
    }
  }

  // 顶部导航栏
  @Builder
  TopNavigationBar() {
    Row() {
      Text('←')
        .fontSize(24)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .onClick(() => { router.back(); })
      Text('编辑个人信息')
        .fontSize(NORMAL_FONT_SIZE)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
      Text('')
        .fontSize(24)
        .width(24)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(this.currentThemeColors.backgroundColor)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  // 头像修改区域
  @Builder
  AvatarSection() {
    Column({ space: 16 }) {
      Text('头像')
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .fontWeight(FontWeight.Bold)
        .alignSelf(ItemAlign.Start)
        .padding({ left: 16 })
      
      Row({ space: 16 }) {
        Image(this.userAvatar)
          .width(80)
          .height(80)
          .borderRadius(40)
          .backgroundColor('#F5F5F5')

        Column({ space: 8 }) {
          Button('更换头像')
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor('#FFFFFF')
            .backgroundColor(this.currentThemeColors.accentColor)
            .height(44)
            .borderRadius(8)
            .onClick(() => { this.selectAvatar(); })
          
          Text('支持jpg、png、gif格式，大小不超过5M')
            .fontSize(SMALL_FONT_SIZE)
            .fontColor(this.currentThemeColors.secondaryTextColor)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .padding({ left: 16, right: 16 })
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .padding({ top: 16, bottom: 16 })
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .borderRadius(8)
    .margin({ top: 16, left: 16, right: 16 })
  }

  // 编辑项目 - 两列布局
  @Builder
  EditItemRow(label: string, value: string, placeholder: string, isEditable: boolean, onChange?: (text: string) => void, onTap?: () => void) {
    Row({ space: 12 }) {
      Text(label)
        .fontSize(NORMAL_FONT_SIZE)
        .fontColor(this.currentThemeColors.primaryTextColor)
        .width(80)
        .textAlign(TextAlign.Start)

      if (isEditable) {
        TextInput({ placeholder: placeholder, text: value })
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .placeholderColor(this.currentThemeColors.secondaryTextColor)
          .backgroundColor('transparent')
          .onChange((text) => { if (onChange) onChange(text); })
          .layoutWeight(1)
      } else {
        Row() {
          Text(value || placeholder)
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(value ? this.currentThemeColors.primaryTextColor : this.currentThemeColors.secondaryTextColor)
            .layoutWeight(1)
          Image($r('app.media.ic_arrow_right'))
            .width(16)
            .height(16)
            .fillColor(this.currentThemeColors.secondaryTextColor)
        }
        .layoutWeight(1)
        .onClick(() => { if (onTap) onTap(); })
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(this.currentThemeColors.cardBackgroundColor)
    .alignItems(VerticalAlign.Center)
  }

  // 编辑信息区域
  @Builder
  EditInfoSection() {
    Column({ space: 1 }) {
      // 账号名
      this.EditItemRow(
        '账号名',
        this.accountName,
        this.currentUsername ? this.currentUsername : '输入账号名',
        true,
        (text) => { this.accountName = text; }
      )
      Divider().strokeWidth(1).color(this.currentThemeColors.dividerColor)

      // 昵称
      this.EditItemRow(
        '昵称',
        this.nickname,
        this.currentUsername ? this.currentUsername : '输入昵称',
        true,
        (text) => { this.nickname = text; }
      )
      Divider().strokeWidth(1).color(this.currentThemeColors.dividerColor)

      // 性别
      this.EditItemRow(
        '性别',
        this.gender,
        '选择性别',
        false,
        undefined,
        () => { this.selectGender(); }
      )
      Divider().strokeWidth(1).color(this.currentThemeColors.dividerColor)

      // 出生日期（TextInput）
      this.EditItemRow(
        '出生日期',
        this.birthDate,
        '输入出生日期',
        true,
        (text) => { this.birthDate = text; }
      )
      Divider().strokeWidth(1).color(this.currentThemeColors.dividerColor)

      // 地址
      this.EditItemRow(
        '地址',
        this.address,
        '输入地址',
        true,
        (text) => { this.address = text; }
      )
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .borderRadius(8)
    .margin({ top: 16, left: 16, right: 16 })
    .clip(true)
  }

  // 保存按钮
  @Builder
  SaveButton() {
    Button('保存')
      .fontSize(NORMAL_FONT_SIZE)
      .fontColor('#FFFFFF')
      .backgroundColor(this.currentThemeColors.accentColor)
      .width('calc(100% - 32vp)')
      .height(48)
      .borderRadius(8)
      .margin({ top: 32, left: 16, right: 16 })
      .onClick(() => { this.saveProfile(); })
  }

  build() {
    Column() {
      this.TopNavigationBar()
      
      Scroll() {
        Column() {
          this.AvatarSection()
          this.EditInfoSection()
          this.SaveButton()
          
          // 底部占位符
          Column().height(20)
        }
        .width(LAYOUT_WIDTH_OR_HEIGHT)
      }
      .layoutWeight(1)
      .backgroundColor(this.currentThemeColors.backgroundColor)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor(this.currentThemeColors.backgroundColor)
    .padding({ top: 34 })
  }
}
