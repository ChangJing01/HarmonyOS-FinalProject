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

import {
  NORMAL_FONT_SIZE,
  BIGGER_FONT_SIZE,
  MAX_FONT_SIZE,
  SMALL_FONT_SIZE,
  TAB_FONT_SIZE,
  BORDER_RADIUS_NORMAL,
  BORDER_RADIUS_LARGE,
  PADDING_HORIZONTAL,
  PADDING_VERTICAL,
  MARGIN_TOP,
  MARGIN_BOTTOM,
  LAYOUT_WIDTH_OR_HEIGHT,
} from './CommonConstants';
import { ThemeColors, DEFAULT_THEME } from '../common/Colors';

export interface TextStyle {
  fontSize: number;
  fontWeight: FontWeight;
  lineHeight: number;
}

// 新增按钮样式接口
export interface ButtonStyle {
  height: number;
  borderRadius: number;
  backgroundColor: string;
  fontSize: number;
  fontWeight: FontWeight;
}

// 新增卡片容器样式接口
export interface CardContainerStyle {
  borderRadius: number;
  padding: number;
  backgroundColor: string;
}

// 标题样式
export const TITLE_STYLE: TextStyle = {
  fontSize: MAX_FONT_SIZE,
  fontWeight: FontWeight.Bold,
  lineHeight: MAX_FONT_SIZE * 1.4,
};

// 大文本样式
export const HEADING_STYLE: TextStyle = {
  fontSize: BIGGER_FONT_SIZE,
  fontWeight: FontWeight.Bold,
  lineHeight: BIGGER_FONT_SIZE * 1.4,
};

// 正常文本样式
export const BODY_STYLE: TextStyle = {
  fontSize: NORMAL_FONT_SIZE,
  fontWeight: FontWeight.Normal,
  lineHeight: NORMAL_FONT_SIZE * 1.5,
};

// 小文本样式
export const CAPTION_STYLE: TextStyle = {
  fontSize: SMALL_FONT_SIZE,
  fontWeight: FontWeight.Normal,
  lineHeight: SMALL_FONT_SIZE * 1.4,
};

// Tab 文本样式
export const TAB_STYLE: TextStyle = {
  fontSize: TAB_FONT_SIZE,
  fontWeight: FontWeight.Normal,
  lineHeight: TAB_FONT_SIZE * 1.4,
};

// 页面间距规范
export interface Spacing {
  horizontal: number;
  vertical: number;
  marginTop: number;
  marginBottom: number;
}

export const DEFAULT_SPACING: Spacing = {
  horizontal: PADDING_HORIZONTAL,
  vertical: PADDING_VERTICAL,
  marginTop: MARGIN_TOP,
  marginBottom: MARGIN_BOTTOM,
};

// 卡片样式
export interface CardStyle {
  borderRadius: number;
  backgroundColor: string;
  shadowColor: string;
  shadowBlur: number;
}

export const CARD_STYLE: CardStyle = {
  borderRadius: BORDER_RADIUS_NORMAL,
  backgroundColor: '#FFFFFF',
  shadowColor: '#00000015',
  shadowBlur: 8,
};

// 按钮样式
export const BUTTON_HEIGHT: number = 48;
export const BUTTON_BORDER_RADIUS: number = BORDER_RADIUS_LARGE;

// 输入框样式
export const INPUT_HEIGHT: number = 48;
export const INPUT_BORDER_RADIUS: number = BORDER_RADIUS_NORMAL;
export const INPUT_PADDING: number = PADDING_HORIZONTAL;

// Divider 样式
export const DIVIDER_HEIGHT: number = 1;
export const DIVIDER_WIDTH: string = LAYOUT_WIDTH_OR_HEIGHT;
export const DIVIDER_COLOR: string = '#EEEEEE';

// 圆角按钮样式
export function getButtonStyle(backgroundColor: string): ButtonStyle {
  return {
    height: BUTTON_HEIGHT,
    borderRadius: BUTTON_BORDER_RADIUS,
    backgroundColor: backgroundColor,
    fontSize: NORMAL_FONT_SIZE,
    fontWeight: FontWeight.Bold,
  };
}

// 卡片容器样式
export function getCardContainerStyle(): CardContainerStyle {
  return {
    borderRadius: BORDER_RADIUS_NORMAL,
    padding: PADDING_HORIZONTAL,
    backgroundColor: '#FFFFFF',
  };
}