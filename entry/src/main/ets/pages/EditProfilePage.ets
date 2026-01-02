import router from '@ohos.router';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';
import { LAYOUT_WIDTH_OR_HEIGHT, NORMAL_FONT_SIZE, SMALL_FONT_SIZE, BIGGER_FONT_SIZE } from '../common/CommonConstants';
import { common } from '@kit.AbilityKit';
import { AccountData } from '../model/AccountData';
import Logger from '../model/Logger';
import promptAction from '@ohos.promptAction';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { geoLocationManager } from '@kit.LocationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { abilityAccessCtrl, PermissionRequestResult, Permissions } from '@kit.AbilityKit';

const TAG: string = '[EditProfilePage]';

@Entry
@Component
export default struct EditProfilePage {
    @StorageLink('currentUsername') currentUsername: string = '';
  @StorageLink('themeColors') currentThemeColors: ThemeColors = DEFAULT_THEME;
  @State userAvatar: Resource | string = $r('app.media.ic_avatar');
  @State accountName: string = '';
  @State nickname: string = '';
  @State gender: string = '保密'; // 保密、男、女
  @State birthDate: string = '';
  @State address: string = '';
  @State isLoading: boolean = false;
  @State isLocating: boolean = false;

  private accountData: AccountData = new AccountData();
  private context: common.Context = getContext(this) as common.Context;

  aboutToAppear(): void {
    this.loadUserData();
  }

  // 加载用户数据
  private async loadUserData(): Promise<void> {
    try {
      const STORAGE_KEY = 'profile_storage';
      
      // 加载账号名
      this.accountData.getStorageValue(this.context, 'username', STORAGE_KEY)
        .then((result) => {
          this.accountName = String(result) || '';
          Logger.info(TAG, `Loaded username: ${this.accountName}`);
        }).catch(() => {});
      
      // 加载昵称
      this.accountData.getStorageValue(this.context, 'nickname', STORAGE_KEY)
        .then((result) => {
          this.nickname = String(result) || '';
        }).catch(() => {});
      
      // 加载性别
      this.accountData.getStorageValue(this.context, 'gender', STORAGE_KEY)
        .then((result) => {
          this.gender = String(result) || '保密';
        }).catch(() => {});
      
      // 加载出生日期
      this.accountData.getStorageValue(this.context, 'birthDate', STORAGE_KEY)
        .then((result) => {
          this.birthDate = String(result) || '';
        }).catch(() => {});
      
      // 加载地址
      this.accountData.getStorageValue(this.context, 'address', STORAGE_KEY)
        .then((result) => {
          this.address = String(result) || '';
        }).catch(() => {});
      
      // 加载头像
      this.accountData.getStorageValue(this.context, 'avatar', STORAGE_KEY)
        .then((result) => {
          const avatarUrl = String(result);
          if (avatarUrl && avatarUrl !== 'undefined') {
            this.userAvatar = avatarUrl;
          }
        }).catch(() => {});
        
      Logger.info(TAG, 'Load user data completed');
    } catch (error) {
      Logger.error(TAG, `loadUserData failed: ${error}`);
    }
  }

  // 选择头像
  private async selectAvatar(): Promise<void> {
    try {
      const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
      photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
      photoSelectOptions.maxSelectNumber = 1;

      const photoPicker = new photoAccessHelper.PhotoViewPicker();
      const photoSelectResult: photoAccessHelper.PhotoSelectResult = 
        await photoPicker.select(photoSelectOptions);
      
      if (photoSelectResult && photoSelectResult.photoUris.length > 0) {
        const photoUri = photoSelectResult.photoUris[0];
        this.userAvatar = photoUri;
        Logger.info(TAG, `Selected photo: ${photoUri}`);
        
        promptAction.showToast({
          message: '头像已更新',
          duration: 2000
        });
      }
    } catch (error) {
      const err = error as BusinessError;
      Logger.error(TAG, `selectAvatar failed, code: ${err.code}, message: ${err.message}`);
      if (err.code !== 0) { // 用户取消选择返回0，不提示错误
        promptAction.showToast({
          message: '选择头像失败',
          duration: 2000
        });
      }
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

  // 逆地理编码：将经纬度转换为地址
  private async getAddressFromLocation(latitude: number, longitude: number): Promise<void> {
    try {
      const reverseGeoCodeRequest: geoLocationManager.ReverseGeoCodeRequest = {
        latitude: latitude,
        longitude: longitude,
        maxItems: 1,
        locale: 'zh'
      };

      geoLocationManager.getAddressesFromLocation(reverseGeoCodeRequest, (err, data) => {
        if (err) {
          Logger.error(TAG, `getAddressesFromLocation failed, code: ${err.code}, message: ${err.message}`);
          // 如果逆地理编码失败，降级使用经纬度
          const lat = latitude.toFixed(6);
          const lon = longitude.toFixed(6);
          this.address = `纬度: ${lat}, 经度: ${lon}`;
          promptAction.showToast({
            message: '定位成功，但获取地址失败',
            duration: 2000
          });
          return;
        }

        if (data && data.length > 0) {
          const geoAddress = data[0];
          Logger.info(TAG, `Address: ${JSON.stringify(geoAddress)}`);
          
          // 拼接完整地址
          let fullAddress = '';
          if (geoAddress.countryName) fullAddress += geoAddress.countryName;
          if (geoAddress.administrativeArea) fullAddress += geoAddress.administrativeArea;
          if (geoAddress.locality) fullAddress += geoAddress.locality;
          if (geoAddress.subLocality) fullAddress += geoAddress.subLocality;
          if (geoAddress.roadName) fullAddress += geoAddress.roadName;
          if (geoAddress.subRoadName) fullAddress += geoAddress.subRoadName;
          
          // 如果有详细地址描述，优先使用
          if (geoAddress.placeName) {
            fullAddress = geoAddress.placeName;
          } else if (!fullAddress) {
            fullAddress = `${latitude.toFixed(6)}, ${longitude.toFixed(6)}`;
          }
          
          this.address = fullAddress;
          Logger.info(TAG, `Full address: ${fullAddress}`);
          
          promptAction.showToast({
            message: '定位成功',
            duration: 2000
          });
        } else {
          // 没有获取到地址信息，使用经纬度
          const lat = latitude.toFixed(6);
          const lon = longitude.toFixed(6);
          this.address = `纬度: ${lat}, 经度: ${lon}`;
          promptAction.showToast({
            message: '定位成功',
            duration: 2000
          });
        }
      });
    } catch (error) {
      const err = error as BusinessError;
      Logger.error(TAG, `getAddressFromLocation exception, code: ${err.code}, message: ${err.message}`);
      // 异常时使用经纬度
      const lat = latitude.toFixed(6);
      const lon = longitude.toFixed(6);
      this.address = `纬度: ${lat}, 经度: ${lon}`;
    }
  }

  // 检查并请求定位权限
  private async checkLocationPermission(): Promise<boolean> {
    try {
      const atManager = abilityAccessCtrl.createAtManager();
      const permissions: Array<Permissions> = [
        'ohos.permission.APPROXIMATELY_LOCATION',
        'ohos.permission.LOCATION'
      ];
      
      // 检查权限状态
      const grantStatus = await atManager.checkAccessToken(
        this.context.applicationInfo.accessTokenId,
        'ohos.permission.LOCATION'
      );
      
      if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        return true;
      }
      
      // 请求权限
      const result: PermissionRequestResult = await atManager.requestPermissionsFromUser(
        this.context,
        permissions
      );
      
      // 检查权限请求结果
      const allGranted = result.authResults.every(item => item === 0);
      if (!allGranted) {
        promptAction.showToast({
          message: '定位权限被拒绝，无法获取位置',
          duration: 2000
        });
        return false;
      }
      
      return true;
    } catch (error) {
      const err = error as BusinessError;
      Logger.error(TAG, `checkLocationPermission failed, code: ${err.code}, message: ${err.message}`);
      return false;
    }
  }

  // 获取当前位置
  private async getCurrentLocation(): Promise<void> {
    if (this.isLocating) {
      return;
    }

    // 先检查并请求权限
    const hasPermission = await this.checkLocationPermission();
    if (!hasPermission) {
      Logger.error(TAG, 'No location permission');
      return;
    }

    this.isLocating = true;
    try {
      // 请求位置权限并获取位置
      const requestInfo: geoLocationManager.LocationRequest = {
        'priority': geoLocationManager.LocationRequestPriority.FIRST_FIX,
        'scenario': geoLocationManager.LocationRequestScenario.UNSET,
        'timeInterval': 0,
        'distanceInterval': 0,
        'maxAccuracy': 0
      };

      promptAction.showToast({
        message: '正在定位...',
        duration: 2000
      });

      geoLocationManager.getCurrentLocation(requestInfo, (err, location) => {
        this.isLocating = false;
        if (err) {
          Logger.error(TAG, `getCurrentLocation failed, code: ${err.code}, message: ${err.message}`);
          
          // 根据错误码提供友好提示
          let errorMsg = '定位失败';
          if (err.code === 3301100) {
            errorMsg = '请先在设置中开启设备定位服务';
          } else if (err.code === 3301200) {
            errorMsg = '定位失败，请稍后重试';
          } else {
            errorMsg = `定位失败: ${err.message}`;
          }
          
          promptAction.showToast({
            message: errorMsg,
            duration: 3000
          });
          return;
        }
        
        if (location) {
          Logger.info(TAG, `Location: lat=${location.latitude}, lon=${location.longitude}`);
          
          // 使用逆地理编码获取具体地址
          this.getAddressFromLocation(location.latitude, location.longitude);
        } else {
          Logger.error(TAG, 'Location is null');
          promptAction.showToast({
            message: '未获取到定位信息',
            duration: 2000
          });
        }
      });
    } catch (error) {
      this.isLocating = false;
      const err = error as BusinessError;
      Logger.error(TAG, `Location request failed, code: ${err.code}, message: ${err.message}`);
      promptAction.showToast({
        message: `定位异常: ${err.message}`,
        duration: 3000
      });
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
  private async saveProfile(): Promise<void> {
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
      const STORAGE_KEY = 'profile_storage';
      
      // 保存所有字段
      await Promise.all([
        this.accountData.putStorageValue(this.context, 'username', this.accountName, STORAGE_KEY),
        this.accountData.putStorageValue(this.context, 'nickname', this.nickname, STORAGE_KEY),
        this.accountData.putStorageValue(this.context, 'gender', this.gender, STORAGE_KEY),
        this.accountData.putStorageValue(this.context, 'birthDate', this.birthDate, STORAGE_KEY),
        this.accountData.putStorageValue(this.context, 'address', this.address, STORAGE_KEY),
        this.accountData.putStorageValue(this.context, 'avatar', String(this.userAvatar), STORAGE_KEY)
      ]);
      
      this.isLoading = false;
      Logger.info(TAG, 'Save profile success');
      
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
    } catch (error) {
      this.isLoading = false;
      Logger.error(TAG, `Save profile failed: ${error}`);
      try {
        promptAction.showToast({
          message: '保存失败',
          duration: 2000
        });
      } catch (_) {
        Logger.error(TAG, 'showToast failed');
      }
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

      // 地址 - 带定位功能
      Row({ space: 12 }) {
        Text('地址')
          .fontSize(NORMAL_FONT_SIZE)
          .fontColor(this.currentThemeColors.primaryTextColor)
          .width(80)
          .textAlign(TextAlign.Start)

        Row({ space: 8 }) {
          // 定位图标
          Image($r('app.media.ic_location'))
            .width(20)
            .height(20)
            .fillColor(this.isLocating ? this.currentThemeColors.accentColor : this.currentThemeColors.secondaryTextColor)
            .onClick(() => { this.getCurrentLocation(); })

          TextInput({ placeholder: '输入地址或点击定位', text: this.address })
            .fontSize(NORMAL_FONT_SIZE)
            .fontColor(this.currentThemeColors.primaryTextColor)
            .placeholderColor(this.currentThemeColors.secondaryTextColor)
            .backgroundColor('transparent')
            .onChange((text) => { this.address = text; })
            .layoutWeight(1)
        }
        .layoutWeight(1)
      }
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(this.currentThemeColors.cardBackgroundColor)
      .alignItems(VerticalAlign.Center)
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
