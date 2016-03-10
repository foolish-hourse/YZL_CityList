//
//  YZLCityTool.m
//  YZL_Map_Demo
//
//  Created by YZL on 16/3/2.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import "YZLCityTool.h"
#import "YZLCityListViewController.h"
#import "YZLCityNavigationController.h"


@implementation YZLCityTool
/** 弹出城市列表 */
- (void)showCityListInVC:(UIViewController *)vc{
    YZLCityListViewController *cityVC = [[YZLCityListViewController alloc] init];
    YZLCityNavigationController *nav = [[YZLCityNavigationController alloc] initWithRootViewController:cityVC];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [vc presentViewController:nav animated:YES completion:nil];
    //注册成为城市选择时的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSelectedCity:) name:YZLCityDidChangeNotification object:nil];
}

#pragma mark - SEL Methods
//接收被选城市的通知方法
- (void)receiveSelectedCity:(NSNotification *)notification{
    NSDictionary *message = notification.userInfo;
    [self.delegate getSelectedCityName:message[YZLSelectedCityNameNotification]];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YZLCityDidChangeNotification object:nil];
}
@end
