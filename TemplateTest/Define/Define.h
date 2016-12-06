//
//  Define.h
//  Template-OC
//
//  Created by niedi on 15/4/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#ifndef Template_OC_Define_h
#define Template_OC_Define_h

/* 
 AppDelegate
 */
#define SHARED_APP_DELEGATE             (AppDelegate *)[UIApplication sharedApplication].delegate

//创建名为weakSelf的弱引用self对象
#define WEAKSELF typeof(self) __weak weakSelf = self

/*  UIColor
 */
#define UIColorFromRGB(rgbValue)	    UIColorFromRGBA(rgbValue,1.0)

#define UIColorFromRGBA(rgbValue,a)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


/*  DocumentPath
 */
#define DocumentPath                    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


/*  iOS版本
 */
#define IOS7                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS7Dot0                        ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0 ? YES : NO)
#define IOS8                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)


/*  屏幕尺寸
 */
#define IPHONE4                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE5                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6PLUS                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//UI适配
#define UIAdaptiveRate(x) ((float) x * kScreenWidth / 375.0)
#define FONT(x) [UIFont fontWithName:FONTNAME size:UIAdaptiveRate(x)]


/*  设备方向
 */
#define Portrait            ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait ? YES : NO)
#define PortraitUpsideDown  ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown ? YES : NO)
#define LandscapeLeft       ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft ? YES : NO)
#define LandscapeRight      ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight ? YES : NO)


/*  宽高
 */
#define CONTENT_HEIGHT                  ([UIScreen mainScreen].bounds.size.height - 64)
#define kScreenHeight                   [UIScreen mainScreen].bounds.size.height
#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width

#define kx3Rate                              (IPHONE6PLUS ? 1.5 : 1)
#define kLineHeight                          (0.5 * kx3Rate)

/*  较iPhone4屏宽比例
 */
#define kScreenRate                     ([UIScreen mainScreen].bounds.size.width / 320.0f)


/*  颜色
 CD For Color Define
 */
#define CD_Text                         UIColorFromRGB(0x333333)
#define CD_TextMid                      UIColorFromRGB(0x393939)
#define CD_TextLight                    UIColorFromRGB(0x999999)
#define LightGray                       UIColorFromRGB(0xcac9cf)   //浅灰
#define CD_Border                       UIColorFromRGB(0xffbc90)

//MYP add 字体颜色
#define CD_TextBlack                    UIColorFromRGB(0x000000)//黑色
#define CD_TextDeepGray                 UIColorFromRGB(0x666666)//深灰
//色调
#define CD_MainColor                    UIColorFromRGB(0x09b878)//主色调
#define CD_LineColor                    UIColorFromRGB(0xeeeeee)//线条颜色,画线
#define CDBACKGROUND                    UIColorFromRGB(0xebebeb)//背景色
#define CD_ClickColor                   UIColorFromRGB(0xF5F5F5)//点击色
//辅色
#define CD_Red                          UIColorFromRGB(0xe05842)//红色
#define CD_Orange                       UIColorFromRGB(0xf99c35)//橙色
#define CD_Green                        UIColorFromRGB(0x03b293)//绿色
#define CD_Blue                         UIColorFromRGB(0x4eb6cf)//蓝色
#define CD_Purple                       UIColorFromRGB(0xbd8dd3)//紫色
#define CD_SelectedText                 UIColorFromRGB(0xff6600)
#define CD_TagColor                     UIColorFromRGB(0x03b293) //标签的颜色
#define CD_GrayColor                    UIColorFromRGB(0xb7b7b7)
/*  字体
 TF For Text Font
 */
#define FONTNAME                        @"Helvetica Neue"
#define Font_Number                     @"Helvetica Neue LT Pro"
//#define FONT(fontSize)                  [UIFont fontWithName:FONTNAME size:fontSize]

/*  存储命名
 UD For userdefaults
 */
#define UDFirstLanunch                  @"firstLaunch"          // 首次启动


#define IMAGE(imagename)                [UIImage imageNamed:imagename]

/*  定义
 DF For Define
 */
#define DFSHARE_TITLE                   @"和我一起做一只懒懒的考拉"



/*  key
 K For Key
 */

#define KUMENG                                  @""



/*  通知
 NT For Notification
 */
#define NTPAY_SUCCESS                                     @"pay_success"

#define kLocationSuccessNotification            @"kLocationSuccessNotification"
#define kLocationFailNotification               @"kLocationFailNotification"
#define kLoginSuccessNotification               @"loginSuccessNotification"

/*
 各种key值
 */

//友盟key
#define UmengAppkey @"5211818556240bc9ee01db2f"

#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#endif

