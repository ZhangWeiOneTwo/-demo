//
//  HWBaseViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

@interface HWBaseViewController ()

@end

@implementation HWBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

#pragma mark -
#pragma mark Public method

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark System method

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
