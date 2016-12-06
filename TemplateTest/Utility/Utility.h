//
//  Utility.h
//  UtilityDemo
//
//  Created by wuxiaohong on 15/3/30.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    ControllerType_Register = 0,
    ControllerType_Forgot,
    ControllerType_ChangePhone
    
}ControllerType;

@interface Utility : NSObject

CGFloat DegreesToRadians(CGFloat degrees);
CGFloat RadiansToDegrees(CGFloat radians);

/*
 *  获取字符串字数   汉字算两个字 英文算一个字
 *
 *  @param text 传入字符串
 *
 *  @return 返回字符串位数
 */
+ (int)calculateTextLength:(NSString *)text;

//动态计算字符串高度
+ (CGSize)calculateStringSize:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize;
//计算两点经纬度之间的距离
+ (double)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2;

//校验手机号
+ (BOOL)validateMobile:(NSString *)mobileNum;

//判断固话
+ (BOOL)validatePhoneTel:(NSString *)phoneNum;

// 判断有效密码
+ (BOOL)validatePassword:(NSString *)pwd;

// 手机号部分隐藏
+ (NSString *)securePhoneNumber:(NSString *)pNum;

// 判断字符是否全为空格
+ (BOOL)isAllSpaceWithString:(NSString *)string;

// 反转数组
+ (void)reverseArray:(NSMutableArray *)targetArray;

//获取当前版本号
+ (NSString *)getLocalAppVersion;

//图像保存路径
+ (NSString *)savedPath;

//将时间戳转换为时间
+ (NSString *)getTimeByTimestamp:(NSString *)strTimestamp dateFormat:(NSString *)strDateFormat;

//将时间转换为时间戳
+ (NSString *)getTimeStampWithDate:(NSString *)strDate;

//千分位的格式
+ (NSString *)conversionThousandth:(NSString *)string;

//判断网络
+ (BOOL)isConnectionAvailable;

//生成指定大小的图片 图片中心为指定显示的图片
+ (UIImage * )getPlaceHolderImage:(CGSize)size string:(NSString *)imageName;

// 设置图片
+ (void)showPicWithUrl:(NSString *)urlStr imageView:(UIImageView *)iconImgV;

+ (void)showPicWithUrl:(NSString *)urlStr imageView:(UIImageView *)iconImgV placeholder:(NSString *)placeholder;

+ (NSString *)getDeviceIPAddresses;

@end
