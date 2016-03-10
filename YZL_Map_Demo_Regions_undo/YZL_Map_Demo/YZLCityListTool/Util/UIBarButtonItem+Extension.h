//
//  UIBarButtonItem+Extension.h
//  YZL_Map_Demo
//
//  Created by YZL on 16/3/2.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**  */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
