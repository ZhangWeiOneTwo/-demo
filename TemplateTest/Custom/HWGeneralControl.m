//
//  HWGeneralControl.m
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWGeneralControl.h"

@implementation HWGeneralControl

//创建通用的UILabel
+(UILabel *)createLabel:(CGRect)generalRect font:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment labelColor:(UIColor *)labelColor
{
    UILabel *generalLabel = [[UILabel alloc]initWithFrame:generalRect];
    generalLabel.font = FONT(fontSize);
    generalLabel.backgroundColor = [UIColor clearColor];
    generalLabel.textAlignment = textAligment;
    generalLabel.textColor = labelColor;
    return generalLabel;
}
//创建通用的UIImageview
+(UIImageView *)createImageView:(CGRect)generalRect image:(NSString *)ImageStr
{
    UIImageView *generalImage = [[UIImageView alloc]initWithFrame:generalRect];
    generalImage.backgroundColor = [UIColor clearColor];
    generalImage.image = [UIImage imageNamed:ImageStr];
    return generalImage;
}
//创建通用的UITextField
+(UITextField *)createTextFiledView:(CGRect)generalRect delegate:(id)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor tag:(NSInteger)tag
{
    UITextField *generalTextFiled = [[UITextField alloc]initWithFrame:generalRect];
    generalTextFiled.font = FONT(fontSize);
    generalTextFiled.tag = tag;
    generalTextFiled.backgroundColor = [UIColor clearColor];
    generalTextFiled.textAlignment = textAligment;
    generalTextFiled.textColor = textColor;
    generalTextFiled.delegate = delegate;
    return generalTextFiled;
}

//创建通用的UIButton
+(UIButton *)createButton:(CGRect)generalRect font:(CGFloat)fontSize buttonTitleColor: (UIColor *)buttonColor imageStr:(NSString *)imageStr backImage:(NSString *)backImageStr title:(NSString *)titleStr
{
    UIButton *generalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    generalButton.frame = generalRect;
    [generalButton setBackgroundImage:[UIImage imageNamed:backImageStr] forState:UIControlStateNormal];
    [generalButton.titleLabel setFont:FONT(fontSize)];
    [generalButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [generalButton setTitleColor:buttonColor forState:UIControlStateNormal];
    [generalButton setTitle:titleStr forState:UIControlStateNormal];
    generalButton.backgroundColor = [UIColor clearColor];
    return generalButton;
    
}
//创建UIView
+(UIView *)createView:(CGRect)generalRect
{
    UIView *generalView = [[UIView alloc]initWithFrame:generalRect];
    generalView.backgroundColor = [UIColor whiteColor];
    return generalView;
}

//创建通用的UITextview
+(UITextView *)createTextView:(CGRect)generalRect font:(CGFloat )fontSize textColor:(UIColor *)textColor delegate:(id)delegate textAligment:(NSTextAlignment)textAligment
{
    UITextView *generalTextView = [[UITextView alloc]initWithFrame:generalRect];
    generalTextView.font = FONT(fontSize);
    generalTextView.backgroundColor = [UIColor clearColor];
    generalTextView.textAlignment = textAligment;
    generalTextView.textColor = textColor;
    generalTextView.delegate = delegate;
    return generalTextView;
}
//创建UITableView
+(UITableView *)createTableView:(CGRect)generalRect dataSource:(id)dataSourceDelegate delegate:(id)delegateTemp
{
    UITableView *generalTableView = [[UITableView alloc]initWithFrame:generalRect style:UITableViewStylePlain];
    generalTableView.delegate = delegateTemp;
    generalTableView.dataSource = dataSourceDelegate;
    generalTableView.backgroundColor = [UIColor clearColor];
    generalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return generalTableView;
}

+(CGRect)returnLabelFactualSize:(UILabel *)caculationLabel font:(NSInteger)fontSize
{
    caculationLabel.numberOfLines = 0;
    caculationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    caculationLabel.textAlignment = NSTextAlignmentCenter;
    CGRect textLabelFrame = caculationLabel.frame;
    caculationLabel.frame = textLabelFrame;
    CGSize labelSize = [caculationLabel.text sizeWithFont:FONT(fontSize)
                                        constrainedToSize:CGSizeMake(MAXFLOAT, caculationLabel.frame.size.height)
                                            lineBreakMode:NSLineBreakByWordWrapping];
    
    textLabelFrame.size.width = labelSize.width ;
    return textLabelFrame;
    
}
+(CGRect)returnLabelFactualHeightSize:(UILabel *)caculationLabel font:(NSInteger)fontSize
{
    caculationLabel.numberOfLines = 0;
    caculationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    caculationLabel.textAlignment = NSTextAlignmentLeft;
    CGRect textLabelFrame = caculationLabel.frame;
    caculationLabel.frame = textLabelFrame;
    CGSize labelSize = [caculationLabel.text sizeWithFont:FONT(fontSize)
                                        constrainedToSize:CGSizeMake(caculationLabel.frame.size.width, MAXFLOAT)
                                            lineBreakMode:NSLineBreakByWordWrapping];
    
    textLabelFrame.size.height = labelSize.height ;
    return textLabelFrame;
    
}
//画线
+(void)drawLine:(CGRect)lineRect sectionOneTempView:(UIView *)sectionOneViewTemp
{
    UIImageView *lineImageV = [[UIImageView alloc] initWithFrame:lineRect];
    lineImageV.image = [UIImage imageWithColor:CD_LineColor];
//    lineImageV.backgroundColor = CD_LineColor;
    [sectionOneViewTemp  addSubview:lineImageV];
}

/*----创建通用autolayout视图-----*/

+ (UIView *)viewWithAutoLayout
{
    UIView *generalView = [[UIView alloc]init];
    return generalView;
}

+ (UILabel *)labelWithAutoLayoutFont:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment labelColor:(UIColor *)labelColor
{
    UILabel *generalLabel = [[UILabel alloc]init];
    generalLabel.font = FONT(fontSize);
    generalLabel.backgroundColor = [UIColor clearColor];
    generalLabel.textAlignment = textAligment;
    generalLabel.textColor = labelColor;
    return generalLabel;
}

+ (UIImageView *)imageViewWithAutoLayoutImage:(NSString *)ImageStr
{
    UIImageView *generalImage = [[UIImageView alloc]init];
    generalImage.backgroundColor = [UIColor clearColor];
    generalImage.image = [UIImage imageNamed:ImageStr];
    return generalImage;
}

+ (UIButton *)buttonWithAutoLayoutFont:(CGFloat)fontSize buttonTitleColor:(UIColor *)buttonColor imageStr:(NSString *)imageStr backImage:(NSString *)backImageStr title:(NSString *)titleStr
{
    UIButton *generalButton = [[UIButton alloc]init];
    [generalButton setBackgroundImage:[UIImage imageNamed:backImageStr] forState:UIControlStateNormal];
    [generalButton.titleLabel setFont:FONT(fontSize)];
    [generalButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [generalButton setTitleColor:buttonColor forState:UIControlStateNormal];
    [generalButton setTitle:titleStr forState:UIControlStateNormal];
    generalButton.backgroundColor = [UIColor clearColor];
    return generalButton;
}

+ (UITextField *)textFiledWithAutoLayoutDelegate:(id)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor tag:(NSInteger)tag
{
    UITextField *generalTextFiled = [[UITextField alloc]init];
    generalTextFiled.font = FONT(fontSize);
    generalTextFiled.tag = tag;
    generalTextFiled.backgroundColor = [UIColor clearColor];
    generalTextFiled.textAlignment = textAligment;
    generalTextFiled.textColor = textColor;
    generalTextFiled.delegate = delegate;
    return generalTextFiled;
}

+ (UITextView *)textViewWithAutoLayoutFont:(CGFloat)fontSize textColor:(UIColor *)textColor delegate:(id)delegate textAligment:(NSTextAlignment)textAligment
{
    UITextView *generalTextView = [[UITextView alloc]init];
    generalTextView.font = FONT(fontSize);
    generalTextView.backgroundColor = [UIColor clearColor];
    generalTextView.textAlignment = textAligment;
    generalTextView.textColor = textColor;
    generalTextView.delegate = delegate;
    return generalTextView;
}


@end
