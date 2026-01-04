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

  constructor(id: number, goodsImg: Resource | string, goodsName: string | Resource, price: string | Resource, advertisingLanguage: string | Resource = $r('app.string.advertising_language'), evaluate: string | Resource = $r('app.string.evaluate')) {
    this.id = id;
    this.goodsImg = goodsImg;
    this.goodsName = goodsName;
    this.advertisingLanguage = advertisingLanguage;
    this.evaluate = evaluate;
    this.price = price;
  }
}

// 评论类型定义
export class CommentItem {
  user: string;
  avatar: Resource;
  content: string;
  time: string;
  rating: number; // 1-5 星

  constructor(user: string, content: string, rating: number) {
    this.user = user;
    this.avatar = $r('app.media.ic_avatar'); // 确保你有这个默认头像，或者用 goodsImg 代替
    this.content = content;
    this.time = new Date().toLocaleDateString();
    this.rating = rating;
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
  new GoodsListItemType(1, $r('app.media.clothing_1'), '云蔷君悦sky光遇cos服预言季武士裤全套c服', '¥86.2', '热门光遇同款造型', '9人看过'),
  new GoodsListItemType(2, $r('app.media.clothing_2'), '轩森图美式PU皮衣座山雕棉服男款冬季加绒加厚', '¥165', '美式硬朗加绒加厚', '已售500 99%好评'),
  new GoodsListItemType(3, $r('app.media.clothing_3'), '顶峰保罗美式PU皮夹克男秋冬季加绒加厚', '¥172.8', '经典皮衣宽松舒适', '已售3000 2万+人种草'),
  new GoodsListItemType(4, $r('app.media.clothing_4'), '花花公子毛衣男士外套男针织打底衫冬季', '¥133', '水貂绒柔软亲肤', '已售2000 1万+人种草'),
  new GoodsListItemType(5, $r('app.media.clothing_5'), 'LNHG轻奢高端品牌运动套装男士春秋开衫卫衣', '¥598', '轻奢运动风省心时尚', '已售700'),
  new GoodsListItemType(6, $r('app.media.clothing_6'), '【京东直采】纯棉t恤男圆领打底衫半袖情侣', '¥39.9', '精选纯棉透气百搭', '已售1万 99%好评'),
  new GoodsListItemType(7, $r('app.media.clothing_7'), '【京东直采】纯棉t恤男圆领打底衫半袖情侣', '¥39.9', '舒适纯棉多尺码', '已售1万 99%好评'),
  new GoodsListItemType(8, $r('app.media.clothing_8'), '【京东直采】短袖t恤男女宽松圆领速干', '¥39.9', '速干面料清爽透气', '已售4000 97%好评'),
  new GoodsListItemType(9, $r('app.media.clothing_9'), '班尼路S&K系列座山雕毛领双面穿外套男款', '¥269.1', '双面可穿保暖升级', '已售100'),
  new GoodsListItemType(10, $r('app.media.clothing_10'), '顶峰保罗美式PU皮夹克男秋冬季加绒加厚', '¥172.8', '美式经典皮衣风格', '已售3000 1万+人种草'),
  new GoodsListItemType(11, $r('app.media.clothing_11'), 'MAYBEYOND牛仔裤男秋冬季宽松直筒裤子', '¥79.9', '宽松直筒修饰腿型', '已售3万 1万+人种草'),
  new GoodsListItemType(12, $r('app.media.clothing_12'), '啄木鸟冲锋衣三合一男女士新款外套', '¥128', '三合一设计灵活穿搭', '已售4万 100+人好评'),
  new GoodsListItemType(13, $r('app.media.clothing_13'), 'POUM美式假两件夹克男士冬款加绒加厚', '¥164', '假两件拼接层次感强', '32人看过'),
  new GoodsListItemType(14, $r('app.media.clothing_14'), '【京东直采】纯棉t恤男圆领打底衫半袖情侣', '¥39.9', '基础白T纯棉舒适', '已售1万 99%好评'),
  new GoodsListItemType(15, $r('app.media.clothing_15'), '西域传奇cleanfit座山雕毛领棉服男外套', '¥137', '毛领连帽防寒保暖', '已售1000 98%好评'),
  new GoodsListItemType(16, $r('app.media.clothing_16'), 'KVSV高端男装保罗POLO衫男长袖2025春秋', '¥478', '高端POLO商务休闲', '已售100'),
  new GoodsListItemType(17, $r('app.media.clothing_17'), '啄木鸟加绒假两件卫衣男士冬季2025新款', '¥89', '假两件一体绒保暖', '已售300 100%好评'),
  new GoodsListItemType(18, $r('app.media.clothing_18'), '顶峰保罗美式牛仔裤男冬季高街直筒加绒', '¥111.9', '加绒牛仔裤温暖有型', '已售10万 3300+人种草'),
  new GoodsListItemType(19, $r('app.media.clothing_19'), '啄木鸟毛衣男冬季加厚半高领打底针织衫', '¥139', '半高领防风保暖', '已售1000 6600+人种草'),
  new GoodsListItemType(20, $r('app.media.clothing_20'), '真维斯卫衣套装一体搭配日常运动休闲', '¥134', '卫衣套装运动休闲', '已售600'),
  new GoodsListItemType(21, $r('app.media.clothing_21'), 'nasawassup麂皮绒夹克外套男秋冬季新款', '¥238', '麂皮绒质感细腻显瘦', '已售1000 4600+人种草'),
  new GoodsListItemType(22, $r('app.media.clothing_22'), 'Homlean重磅毛领连帽座山雕棉服男女款', '¥217.9', '重磅加绒御寒出色', '已售1000 1万+人种草'),
  new GoodsListItemType(23, $r('app.media.clothing_23'), '顶峰保罗美式PU皮夹克男秋冬季加绒加厚', '¥172.8', '经典皮衣穿出气场', '已售3000 1万+人种草'),
  new GoodsListItemType(24, $r('app.media.clothing_24'), 'qwqh高端设计师品牌不起球毛衣女半高领', '¥388', '设计师款不起球耐穿', '已售400'),
  new GoodsListItemType(25, $r('app.media.clothing_25'), 'JEEP吉普毛衣男士秋冬季宽松保暖圆领', '¥144', '宽松圆领保暖舒适', '已售2000 1万+人种草'),
  new GoodsListItemType(26, $r('app.media.furniture_1'), '源氏木语全实木沙发小户型客厅储物', '¥2549', '精选实木现代简约', '已售6000+'),
  new GoodsListItemType(27, $r('app.media.furniture_2'), '京东全屋定制全爱格板家具衣柜套餐', '¥26800', '全屋定制家具套餐', '已售1万+700+人复购'),
  new GoodsListItemType(28, $r('app.media.furniture_3'), '小木窝实木衣柜新中式黑胡桃收纳柜', '¥3104', '简约平开门大容量', '已售2000+1900+人好评'),
  new GoodsListItemType(29, $r('app.media.furniture_4'), '欧蒂家居免洗猫抓布艺沙发床实木组合', '¥4929', '免洗猫抓科技布', '已售1万+30天加购飙升5倍'),
  new GoodsListItemType(30, $r('app.media.furniture_5'), '跃文佛山榫卯实木床金花梨木主卧大床', '¥1426.47', '榫卯结构仿古大床', '已售100+'),
  new GoodsListItemType(31, $r('app.media.furniture_6'), '科将办公桌椅组合屏风工位卡座财务桌', '¥6759', '办公家具六人位', '已售200+100%好评'),
  new GoodsListItemType(32, $r('app.media.furniture_7'), '德维尔全屋定制卧室电视柜客餐厅柜子', '¥19800', '全屋定制家具套餐', '已售100+600+人种草'),
  new GoodsListItemType(33, $r('app.media.furniture_8'), '华鹤门厅定制入户空间整体定制柜', '¥23999', '入户空间整体定制', '已售2000+300+人复购'),
  new GoodsListItemType(34, $r('app.media.furniture_9'), '锐墨宋氏美学黑胡桃木全实木沙发', '¥12708.4', '宋氏美学新中式', '已售100+'),
  new GoodsListItemType(35, $r('app.media.furniture_10'), '京东全屋定制卧室衣柜家具订金', '¥2000', '全屋定制订金', '已售2万+2100+人复购'),
  new GoodsListItemType(36, $r('app.media.furniture_11'), 'DDC中古风劳伦斯沙发零靠墙电动', '¥4667.35', '中古风电动多功能', '已售600+100+人复购'),
  new GoodsListItemType(37, $r('app.media.furniture_12'), '科将职员办公桌椅组合干字8人位', '¥9185', '职员办公桌椅组合', '已售600+700+人种草'),
  new GoodsListItemType(38, $r('app.media.furniture_13'), '万楷家具床头柜实木小型简约现代', '¥14004.6', '实木床头柜免安装', ''),
  new GoodsListItemType(39, $r('app.media.furniture_14'), '木中央印尼黑酸枝客厅沙发财源滚滚', '¥46123', '红木家具财源滚滚', '已售500+6600+人种草'),
  new GoodsListItemType(40, $r('app.media.furniture_15'), '岁植功能沙发极简劳伦斯真皮电动', '¥3854.4', '极简真皮电动沙发', '已售2000+1万+人种草'),
  new GoodsListItemType(41, $r('app.media.furniture_16'), '庐歌家具组合套装全屋三室一厅', '¥18090', '全屋家具组合套装', '已售100+'),
  new GoodsListItemType(42, $r('app.media.furniture_17'), '欧蒂家居沙发客厅现代简约轻奢科技布', '¥5100', '轻奢科技布实木框', '已售2000+30天加购飙升5倍'),
  new GoodsListItemType(43, $r('app.media.furniture_18'), '好莱客全屋品质家品十件套', '¥26800', '全屋品质家品十件套', '100+人看过100%好评'),
  new GoodsListItemType(44, $r('app.media.furniture_19'), '朴愫木作实木床北美黑胡桃木储物', '¥9180', '北美黑胡桃木箱体', '已售200+2500+人种草'),
  new GoodsListItemType(45, $r('app.media.furniture_20'), '全友家居新中式茶几沙发组合', '¥14486', '新中式实木框架', '已售2000+'),
  new GoodsListItemType(46, $r('app.media.furniture_21'), '良禽佳木全屋定制实木家具书柜', '¥10000', '全屋定制实木家具', '已售1000+1900+人种草'),
  new GoodsListItemType(47, $r('app.media.furniture_22'), '王木匠非洲花梨大家风范沙发', '¥105600', '红木家具大家风范', '1000+人看过'),
  new GoodsListItemType(48, $r('app.media.furniture_23'), '全友全屋定制衣帽间开放式定做', '¥19800', '全屋定制24㎡衣柜', '已售1000+30天加购飙升5倍'),
  new GoodsListItemType(49, $r('app.media.furniture_24'), '源氏木语实木软靠床现代简约主卧', '¥2549', '实木软靠床原木风', '已售4000+'),
  new GoodsListItemType(50, $r('app.media.furniture_25'), '木中央印尼黑酸枝沙发组合国色', '¥50800', '红木家具国色套装', '已售400+30天加购飙升5倍'),
  new GoodsListItemType(51, $r('app.media.furniture_1'), '啄木鸟假两件连帽外套男士三件套装', '¥198', '韩版宽松高级感', '已售1000+'),
  new GoodsListItemType(52, $r('app.media.furniture_2'), '摘星少年男生秋冬毛呢连帽三件套装', '¥139', '宽松高街潮流搭', '已售3000+100+人种草'),
  new GoodsListItemType(53, $r('app.media.furniture_3'), 'NASALIKE美式夹克外套男秋冬季新款', '¥122.99', '宽松百搭痞帅风', '已售2000+100+人种草'),
  new GoodsListItemType(54, $r('app.media.furniture_4'), 'POUM潮牌加绒卫衣男秋季长袖打底衫', '¥68.58', '圆领宽松休闲款', '已售2万+100+人种草'),
  new GoodsListItemType(55, $r('app.media.furniture_5'), '小个子高级感穿搭西服套装', '¥439.2', '高级感西服套装', '已售2000+'),
  new GoodsListItemType(56, $r('app.media.furniture_6'), '武楠280g重磅美式纯棉短袖两件装', '¥69', '纯棉正肩打底衫', '已售1万+200+人种草'),
  new GoodsListItemType(57, $r('app.media.furniture_7'), '骆驼跑步鞋男女2025秋季网面新款', '¥239', '网面缓震百搭款', '已售200+94%好评'),
  new GoodsListItemType(58, $r('app.media.furniture_8'), '花花公子烟灰色牛仔裤男秋冬新款', '¥119', '美式宽松直筒潮', '已售2000+100+人种草'),
  new GoodsListItemType(59, $r('app.media.furniture_9'), '洛科驰发型师潮牌垫肩外套三件套', '¥203.84', '英伦雅痞酷帅风', '已售100+'),
  new GoodsListItemType(60, $r('app.media.furniture_10'), '安踏外套男秋冬季冲锋户外夹克衫', '¥199', '防泼水加绒立领', '已售1000+99%好评'),
  new GoodsListItemType(61, $r('app.media.furniture_11'), '安踏男鞋革面保暖运动鞋冬季新款', '¥179', '革面轻便防泼水', '已售1000+1900+人种草'),
  new GoodsListItemType(62, $r('app.media.furniture_12'), '啄木鸟休闲卫衣套装男春秋季两件套', '¥148', '潮牌韩版一套搭', '已售2万+1300+人种草'),
  new GoodsListItemType(63, $r('app.media.furniture_13'), '蕉内热皮302++女士摇粒绒短外套', '¥254', '保暖防风休闲款', '已售3000+'),
  new GoodsListItemType(64, $r('app.media.furniture_14'), '啄木鸟加绒休闲裤男秋冬季两件装', '¥79.9', '宽松潮牌阔腿款', '已售5000+99%好评'),
  new GoodsListItemType(65, $r('app.media.furniture_15'), '啄木鸟复古风加绒牛仔裤男秋冬季', '¥89', '直筒宽松美式潮', '已售3万+200+人种草'),
  new GoodsListItemType(66, $r('app.media.furniture_16'), '洛科驰港风POLO衫短袖套装男夏季', '¥168', '日系潮流一整套', '已售400+'),
  new GoodsListItemType(67, $r('app.media.furniture_17'), '特步运动套装男装短裤夏速干两件套', '¥104', '冰丝感透气速干', '已售8万+95%好评'),
  new GoodsListItemType(68, $r('app.media.furniture_18'), '特步男鞋冬季皮网面越野跑步鞋', '¥159', '轻便减震防滑款', '已售2000+400+人种草'),
  new GoodsListItemType(69, $r('app.media.furniture_19'), '骆驼追风者三合一户外冲锋衣男女', '¥292.8', '防风防水情侣款', '已售700+300+人种草'),
  new GoodsListItemType(70, $r('app.media.furniture_20'), '罗蒙高品质西服套装男士商务正装', '¥298', '职业正装十件套', '已售20万+'),
  new GoodsListItemType(71, $r('app.media.furniture_21'), '特步男鞋运动鞋秋冬网面透气新款', '¥149', '减震网面青少年', '已售6000+2000+人种草'),
  new GoodsListItemType(72, $r('app.media.furniture_22'), '百鹊亭秋冬潮牌毛衣男生三件套装', '¥198', '痞帅慵懒风穿搭', '67条评价900+人种草'),
  new GoodsListItemType(73, $r('app.media.furniture_23'), '鸿星尔克芷境3代专业马拉松跑鞋', '¥569', '全掌碳板竞速款', '已售1万+300+人种草'),
  new GoodsListItemType(74, $r('app.media.furniture_24'), '洛科驰假两件卫衣套装男春秋两件套', '¥186', '潮流痞帅高级感', '42人看过'),
  new GoodsListItemType(75, $r('app.media.furniture_25'), '安踏运动套装男女情侣短袖两件套', '¥129', '透气宽松健身款', '已售10万+3100+人种草'),
  new GoodsListItemType(76, $r('app.media.phone_1'), '尊享荣耀大内存快充电竞拍照手机', '¥1280', '大电池长续航护眼', '已售5000+'),
  new GoodsListItemType(77, $r('app.media.phone_2'), '荣耀WIN RT骁龙8至尊芯5G游戏手机', '¥3399', '万毫安大电池畅快玩', '5000+条评价99%好评'),
  new GoodsListItemType(78, $r('app.media.phone_3'), '小米Redmi Note13 5G小金刚品质手机', '¥799', '大电量OLED直屏', '已售100万+30天加购飙升5倍'),
  new GoodsListItemType(79, $r('app.media.phone_4'), '一加Ace 6T第五代骁龙8电竞屏手机', '¥2399', '超高刷屏游戏利器', '5万+条评价99%好评'),
  new GoodsListItemType(80, $r('app.media.phone_5'), '华为pura80pro新品超能续航手机', '¥2099', '长续航性能出众', '已售200+'),
  new GoodsListItemType(81, $r('app.media.phone_6'), '小米Redmi Note14 5G大电量手机', '¥899', '金刚品质大光圈相机', '已售50万+30天种草飙升5倍'),
  new GoodsListItemType(82, $r('app.media.phone_7'), '小米Redmi K80第三代骁龙8手机', '¥1819', '大电池续航强劲', '已售100万+30天加购飙升5倍'),
  new GoodsListItemType(83, $r('app.media.phone_8'), '荣耀X70十面抗摔护眼屏5G手机', '¥1599', 'IP69防水长续航', '已售60万+1800+人复购'),
  new GoodsListItemType(84, $r('app.media.phone_9'), '新款17系列5G全网通百元学生手机', '¥399', '超长续航电竞适用', '已售1000+'),
  new GoodsListItemType(85, $r('app.media.phone_10'), 'OPPO K12s长续航OLED直屏手机', '¥1099', '大电池学生游戏优选', '已售10万+98%好评'),
  new GoodsListItemType(86, $r('app.media.phone_11'), '华为畅享80超能续航耐摔手机', '¥1099', '长续航双五星耐摔', '已售4万+30天加购飙升5倍'),
  new GoodsListItemType(87, $r('app.media.phone_12'), 'vivo iQOO Z10 Turbo天玑8400手机', '¥1749', '蓝海电池超长续航', '10万+条评价600+人复购'),
  new GoodsListItemType(88, $r('app.media.phone_13'), '华为智选70Plus鸿蒙防水护眼手机', '¥1998', '五星防水海量存储', '已售2万+'),
  new GoodsListItemType(89, $r('app.media.phone_14'), '小米Redmi Turbo4 Pro骁龙8s手机', '¥1699', '长续航性能强劲', '已售80万+30天加购飙升5倍'),
  new GoodsListItemType(90, $r('app.media.phone_15'), '小米Redmi Note13Pro骁龙7S手机', '¥1049', '新2亿像素高光屏', '已售100万+30天加购飙升5倍'),
  new GoodsListItemType(91, $r('app.media.phone_16'), '尊享荣耀1TB大内存快充备用手机', '¥1380', '大容量长续航护眼', '已售5000+'),
  new GoodsListItemType(92, $r('app.media.phone_17'), '小米Redmi K90骁龙8至尊版手机', '¥2599', '青山护眼大电池', '已售10万+30天加购飙升5倍'),
  new GoodsListItemType(93, $r('app.media.phone_18'), '小米Redmi Turbo4天玑防水手机', '¥1349', 'IP68防水性能强悍', '已售40万+30天加购飙升5倍'),
  new GoodsListItemType(94, $r('app.media.phone_19'), '荣耀WIN骁龙8至尊版AI游戏手机', '¥4699', '涡轮散热续航持久', '2000+条评价99%好评'),
  new GoodsListItemType(95, $r('app.media.phone_20'), '华为mate70pro新品上市手机', '¥1168', '性能出众新品首发', '已售7000+'),
  new GoodsListItemType(96, $r('app.media.phone_21'), '华为智选80s 5G旗舰防水护眼手机', '¥1499', '鸿蒙守护五星防水', '已售4000+30天加购飙升5倍'),
  new GoodsListItemType(97, $r('app.media.phone_22'), '小米Redmi K80至尊版天玑9400+', '¥2219', '超大电池续航能打', '20万+条评价98%好评'),
  new GoodsListItemType(98, $r('app.media.phone_23'), 'vivo iQOO Neo11骁龙8电竞手机', '¥2698', '2K高刷屏游戏专用', '5万+条评价30天加购飙升5倍'),
  new GoodsListItemType(99, $r('app.media.phone_24'), 'HUERIAI 60Pro超薄电竞大屏手机', '¥699', '大电池全网通双卡', '已售2000+'),
  new GoodsListItemType(100, $r('app.media.phone_25'), 'vivo iQOO Z10 Turbo Pro快充手机', '¥1719', '120W闪充电竞优选', '20万+条评价30天加购飙升5倍')
];
