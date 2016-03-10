//
//  YZLCityTool.h
//  YZL_Map_Demo
//
//  Created by YZL on 16/3/2.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YZLCityHeader.h"

@protocol YZLCityToolDelegate <NSObject>
// 获取被选中的城市名称
- (void)getSelectedCityName:(NSString *)cityName;
@end
@interface YZLCityTool : NSObject
/** 弹出城市列表 */
- (void)showCityListInVC:(UIViewController *)vc;

@property (nonatomic, assign) id<YZLCityToolDelegate> delegate;
@end
