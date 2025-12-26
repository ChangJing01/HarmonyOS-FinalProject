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

export interface ThemeColors {
  backgroundColor: string;
  primaryTextColor: string;
  secondaryTextColor: string;
  accentColor: string;
  cardBackgroundColor: string;
  dividerColor: string;
  tabSelectedColor: string;
  tabUnselectedColor: string;
}

// 默认主题
export const DEFAULT_THEME: ThemeColors = {
  backgroundColor: '#F5F5F5',
  primaryTextColor: '#333333',
  secondaryTextColor: '#666666',
  accentColor: '#FF4D4F',
  cardBackgroundColor: '#FFFFFF',
  dividerColor: '#EEEEEE',
  tabSelectedColor: '#FF4D4F',
  tabUnselectedColor: '#666666',
};

// 深色主题（夜间模式）
export const DARK_THEME: ThemeColors = {
  backgroundColor: '#1E1E1E',
  primaryTextColor: '#FFFFFF',
  secondaryTextColor: '#CCCCCC',
  accentColor: '#FF4D4F',
  cardBackgroundColor: '#2D2D2D',
  dividerColor: '#404040',
  tabSelectedColor: '#FF4D4F',
  tabUnselectedColor: '#CCCCCC',
};

// 护眼主题
export const EYECARE_THEME: ThemeColors = {
  backgroundColor: '#F5F5DC',
  primaryTextColor: '#333333',
  secondaryTextColor: '#666666',
  accentColor: '#FF6B35',
  cardBackgroundColor: '#FFFFFF', //'#f3f3f3ff'  '#FFFFFF' '#fff9ecff'
  dividerColor: '#E8E8D0',
  tabSelectedColor: '#FF6B35',
  tabUnselectedColor: '#666666',
};

export enum ThemeType {
  LIGHT = 'light',
  DARK = 'dark',
  EYECARE = 'eyecare'
}

export function getThemeColors(themeType: ThemeType): ThemeColors {
  switch (themeType) {
    case ThemeType.DARK:
      return DARK_THEME;
    case ThemeType.EYECARE:
      return EYECARE_THEME;
    case ThemeType.LIGHT:
    default:
      return DEFAULT_THEME;
  }
}