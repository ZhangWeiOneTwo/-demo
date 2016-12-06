//
//  ViewFactory.h
//  TemplateTest
//
//  Created by caijingpeng on 16/4/23.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewFactory : NSObject

/*
 *	@brief	创建navigation title view
 *
 *	@param 	title 	标题
 *
 *	@return	view
 */
+ (UIView *)navTitleView:(NSString *)title;

/**
 *	@brief	通用navigation 返回按钮
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    调用方法
 *
 *	@return	BarButtonItem
 */
+ (UIBarButtonItem *)navLeftBackBtn:(id)_target
                             action:(SEL)selector;

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
                         image:(UIImage *)image;

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
                         title:(NSString *)title;

/**
 *	@brief	显示toast提示框 1秒后自动消失
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)showToastWithMessage:(NSString *)message;

/**
 *	@brief	系统提示框
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)showAlertWithMessage:(NSString *)message delegate:(id)delegate;

/**
 *  @brief 风火轮加载信息
 *
 *  @param _targetView 对象
 *  @param _msg        提示信息
 */
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg;

+ (void)hideMBProgress:(UIView*)_targetView;



@end
