//
//  Utility.m
//  UtilityDemo
//
//  Created by wuxiaohong on 15/3/30.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "Utility.h"
//#import "Reachability.h"
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>

@implementation Utility

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180 / M_PI;};

/*
 *  获取字符串字数   汉字算两个字 英文算一个字
 *
 *  @param text 传入字符串
 *
 *  @return 返回字符串位数
 */
+ (int)calculateTextLength:(NSString *)text
{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number += 1;
        }
        else
        {
            number += 0.5f;
        }
    }
    return number;
}

/*
 *  计算字符串的宽度和高度
 *
 *  @param string 入参的字符串
 *  @param font
 *  @param cSize
 *
 *  @return
 */
+ (CGSize)calculateStringSize:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [string boundingRectWithSize:cSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    return rect.size;
}

/**
 *  计算两点经纬度之间的距离
 *
 *  @param coordinate1 经度
 *  @param coordinate2 纬度
 *
 *  @return 返回距离
 */
+ (double)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2
{
    if (CLLocationCoordinate2DIsValid(coordinate1) &&
        CLLocationCoordinate2DIsValid(coordinate2)) {
        
        CLLocation  *currentLocation = [[CLLocation alloc] initWithLatitude:coordinate1.latitude
                                                                  longitude:coordinate1.longitude];
        CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:coordinate2.latitude
                                                               longitude:coordinate2.longitude];
        CLLocationDistance distance = [currentLocation distanceFromLocation:otherLocation];
        return distance;
    }
    return 0.00;
}

/**
 *  校验手机号
 *
 *  @param mobileNum 入参string
 *
 *  @return 返回bool
 */
+ (BOOL)validateMobile:(NSString *)mobileNum
{
    if (mobileNum.length == 11)
    {
        NSString *strFirstNum = [[mobileNum substringFromIndex:0] substringToIndex:1];
        if ([strFirstNum isEqualToString:@"1"])
        {
            return YES;
        }
        return NO;
    }
    else
    {
        return NO;
    }
}

/**
 *  判断固定电话
 *
 *  @param phoneNum 手机号码
 *
 *  @return
 */
+ (BOOL)validatePhoneTel:(NSString *)phoneNum
{
    //先判断位数
    if (phoneNum.length == 11 || phoneNum.length == 12 || phoneNum.length == 13)
    {
        NSString *strLine = @"-";
        NSString *str1 = [[phoneNum substringFromIndex:2] substringToIndex:1];
        NSString *str2 = [[phoneNum substringFromIndex:3] substringToIndex:1];
        NSLog(@"str1 = %@\n str2 = %@",str1,str2);
        if ([str1 isEqualToString:strLine] || [str2 isEqualToString:strLine])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

/**
 *  校验密码有效性
 *
 *  @param pwd 密码
 *
 *  @return
 */
+ (BOOL)validatePassword:(NSString *)pwd
{
    if (pwd.length >= 6 && pwd.length <= 16)
    {
        if ([pwd containsString:@" "])
        {
            return NO;
        }
        return YES;
    }
    return NO;
}

/**
 *	@brief	隐藏电话号码
 *
 *	@param 	pNum 	电话号码
 *
 *	@return 186****1325
 */

+ (NSString *)securePhoneNumber:(NSString *)pNum
{
    if (pNum.length <= 11)
    {
        return pNum;
    }
    NSString *result = [NSString stringWithFormat:@"%@****%@", [pNum substringToIndex:3], [pNum substringFromIndex:7]];
    return result;
}

/**
 *	@brief	判断是否 全为空格
 *
 *	@param 	string
 *
 *	@return
 */

+ (BOOL)isAllSpaceWithString:(NSString *)string
{
    for (int i = 0; i < string.length; i++)
    {
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        if (![str isEqualToString:@" "])
        {
            return NO;
        }
    }
    return YES;
}

/**
 *  反转数组
 *
 *  @param targetArray 传入可变数组
 */

+ (void)reverseArray:(NSMutableArray *)targetArray
{
    for (int i = 0; i < targetArray.count / 2.0f; i++)
    {
        [targetArray exchangeObjectAtIndex:i withObjectAtIndex:(targetArray.count - 1 - i)];
    }
}

/**
 *  获取当前版本
 *
 *  @return
 */
+ (NSString *)getLocalAppVersion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *version = [dict objectForKey:@"CFBundleVersion"];
    return version;
}

/**
 *  图像保存路径
 *
 *  @return
 */
+ (NSString *)savedPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    return documentsDirectory;
}

/**
 *  将时间戳转换为指定格式时时间
 *
 *  @param strTimestamp  传入的时间戳
 *  @param strDateFormat 时间的格式
 *
 *  @return 返回的时间
 */
+ (NSString *)getTimeByTimestamp:(NSString *)strTimestamp dateFormat:(NSString *)strDateFormat
{
    if ([strTimestamp isEqualToString:@"0"] || [strTimestamp length] == 0) {
        return @"";
    }
    long long time;
    if (strTimestamp.length == 10) {
        time = [strTimestamp longLongValue];
    }
    else if (strTimestamp.length == 13) {
        time = [strTimestamp longLongValue] / 1000;
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:strDateFormat];
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

/**
 *  通过时间获得时间戳     传入时间格式为YYYY-MM-dd HH:mm:ss
 *
 *  @param strDate 时间戳
 *
 *  @return 时间
 */
+ (NSString *)getTimeStampWithDate:(NSString *)strDate
{
    NSDateFormatter*formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:strDate];
    
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    NSString * str  = [NSString stringWithFormat:@"%@000",timeStamp];
    return str;
}

//!!!!: 千分位格式
/**
 *  千分位格式
 *
 *  @param string 入参
 *
 *  @return
 */
+ (NSString *)conversionThousandth:(NSString *)string
{
    double value = [string doubleValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
    return formattedNumberString;
}

/**
 *  判断网络
 *
 *  @return
 */
//+ (BOOL)isConnectionAvailable
//{
//    BOOL isExistenceNetwork = YES;
//    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//    switch ([reach currentReachabilityStatus])
//    {
//        case NotReachable:
//            isExistenceNetwork = NO;
//            break;
//        case ReachableViaWiFi:
//            isExistenceNetwork = YES;
//            break;
//        case ReachableViaWWAN:
//            isExistenceNetwork = YES;
//            break;
//            
//        default:
//            break;
//    }
//    
//    return isExistenceNetwork;
//}

/**
 *  生成指定大小的图片 图片中心为指定显示的图片
 *
 *  @param size      尺寸
 *  @param imageName 图片名字
 *
 *  @return
 */
+ (UIImage * )getPlaceHolderImage:(CGSize)size string:(NSString *)imageName
{
    if(size.height < 0 || size.width < 0)
    {
        return nil;
    }
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = [UIColor blackColor];
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.center = CGPointMake(CGRectGetWidth(view.frame) / 2.0, CGRectGetHeight(view.frame) / 2.0);
    [view addSubview:imageView];
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

+ (void)showPicWithUrl:(NSString *)urlStr imageView:(UIImageView *)iconImgV placeholder:(NSString *)placeholder
{
    if (urlStr == nil || urlStr.length == 0) {
        iconImgV.image = IMAGE(placeholder);
        return;
    }
    
    if (![urlStr isKindOfClass:[NSString class]]) {
        return;
    }
    
    __weak UIImageView *weakImgV = iconImgV;
    
    NSString *url;
    if ([urlStr hasPrefix:@"http://"] || [urlStr hasPrefix:@"https://"])
    {
        url = urlStr;
    }
    else
    {
        url = [NSString stringWithFormat:@"%@%@",@"http://",urlStr];
    }
    [iconImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", urlStr]] placeholderImage:IMAGE(placeholder) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (error == nil)
        {
            weakImgV.image = image;
            //            if (cacheType == SDImageCacheTypeMemory)
            //            {
            //                weakImgV.image = image;
            //                [weakImgV performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
            //
            //            }
            //            else
            //            {
            //                [weakImgV performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
            //
            //                CATransition *transition = [CATransition animation];
            //                transition.duration = 0.5f;
            //                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            //                transition.type = kCATransitionFade;
            //                [weakImgV.layer addAnimation:transition forKey:nil];
            //            }
            
        }
        else
        {
            //            [weakImgV performSelector:@selector(setImage:) withObject:IMAGE(placeholder) afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
            weakImgV.image = IMAGE(placeholder);
        }
        
    }];
}


+ (void)showPicWithUrl:(NSString *)urlStr imageView:(UIImageView *)iconImgV
{
    __weak UIImageView *weakImgV = iconImgV;
    
    [iconImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", urlStr]] placeholderImage:[Utility getPlaceHolderImage:iconImgV.frame.size string:@"img_dl_failed"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        if (error == nil)
        {
            [weakImgV performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
        }
        else
        {
            [weakImgV performSelector:@selector(setImage:) withObject:[Utility getPlaceHolderImage:weakImgV.frame.size string:@"img_dl_failed"] afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
        }
        
    }];
}

+ (NSString *)getDeviceIPAddresses
{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0)
    {
        return @"error";
    }
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0)
    {
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; )
        {
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len)
            {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    NSString *deviceIP = @"error";
    for (int i=0; i < ips.count; i++)
    {
        if (ips.count > 0)
        {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}


@end
