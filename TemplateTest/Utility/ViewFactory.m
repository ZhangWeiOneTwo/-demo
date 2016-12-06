//
//  ViewFactory.m
//  TemplateTest
//
//  Created by caijingpeng on 16/4/23.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import "ViewFactory.h"
#import "MBProgressHUD.h"

@implementation ViewFactory

/**
 *	@brief	创建navigation title view
 *
 *	@param 	title 	标题
 *
 *	@return	view
 */
+ (UIView *)navTitleView:(NSString *)title
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont fontWithName:FONTNAME size:19.0f];
    lab.textColor = [UIColor whiteColor];
    lab.text = title;
    return lab;
}

/**
 *	@brief	通用navigation 返回按钮
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    调用方法
 *
 *	@return	BarButtonItem
 */
+ (UIBarButtonItem *)navLeftBackBtn:(id)_target
                             action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 50, 30)];
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(6, -3, 6, 35);
    UIBarButtonItem *left_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return left_btn;
}

/**
 *  navigationItem
 *
 *  @param _target  对象
 *  @param selector 方法
 *  @param image    图片
 *
 *  @return
 */
+ (UIBarButtonItem *)navButton:(id)_target
                        action:(SEL)selector
                         image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(0, 0, 25, 44);
    [btn setImage:image forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

/**
 *  navigationItem
 *
 *  @param _target  对象
 *  @param selector 方法
 *  @param title    标题
 *
 *  @return
 */
+ (UIBarButtonItem *)navButton:(id)_target
                        action:(SEL)selector
                         title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(13);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

/**
 *	@brief	显示toast提示框 1秒后自动消失
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)showToastWithMessage:(NSString *)message
{
    AppDelegate *appDel = SHARED_APP_DELEGATE;
    
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:appDel.window];
    [appDel.window addSubview:progressHUD];
    progressHUD.detailsLabelText = message;
    progressHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    progressHUD.yOffset = -100.0f;
    //    HUD.xOffset = 100.0f;
    
    [progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [progressHUD removeFromSuperview];
    }];
}

/**
 *	@brief	系统提示框
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)showAlertWithMessage:(NSString *)message delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

/**
 *  @brief 风火轮加载信息
 *
 *  @param _targetView 对象
 *  @param _msg        提示信息
 */
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg
{
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:_targetView];
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    [progressHUD show:YES];
    progressHUD.labelText = _msg;
    [_targetView addSubview:progressHUD];
}

+ (void)hideMBProgress:(UIView*)_targetView
{
    [MBProgressHUD hideHUDForView:_targetView animated:YES];
}




@end
