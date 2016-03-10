//
//  YZLCityModel.m
//  YZL_Map_Demo
//
//  Created by YZL on 16/3/2.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import "YZLCityModel.h"
#import "YZLRegionModel.h"
#import "MJExtension.h"


@implementation YZLCityModel
- (NSDictionary *)objectClassInArray{
    return @{@"regions" : [YZLRegionModel class]};
}
@end
