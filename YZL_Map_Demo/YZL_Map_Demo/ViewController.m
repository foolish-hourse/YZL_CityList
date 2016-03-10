//
//  ViewController.m
//  YZL_Map_Demo
//
//  Created by YZL on 16/3/2.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import "ViewController.h"
#import "YZLCityTool.h"

@interface ViewController () <YZLCityToolDelegate>
//被选择的城市名称标签
@property (nonatomic, strong) UILabel *cityLabel;
//测试按钮
@property (nonatomic, strong) UIButton *testButton;

@property (nonatomic, strong) YZLCityTool *tool;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //触发懒加载
    self.cityLabel.hidden = NO;
    self.testButton.hidden = NO;
}

#pragma mark - Lazy Load
- (UILabel *)cityLabel{
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.text = @"选择的城市名";
        _cityLabel.frame = CGRectMake(100, 140, 120, 20);
        _cityLabel.textColor = [UIColor blackColor];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_cityLabel];
    }
    return _cityLabel;
}

- (UIButton *)testButton{
    if (!_testButton) {
        _testButton = [[UIButton alloc] init];
        _testButton.backgroundColor = [UIColor grayColor];
        [_testButton setTitle:@"弹出城市列表" forState:UIControlStateNormal];
        _testButton.frame = CGRectMake(100, 100, 120, 20);
        [_testButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_testButton];
        [_testButton addTarget:self action:@selector(showCityList) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testButton;
}

#pragma mark - SEL Methods
- (void)showCityList{
    NSLog(@"click success！");
    //调用工具类方法，弹出城市列表
    self.tool = [[YZLCityTool alloc] init];
    self.tool.delegate = self;
    [self.tool showCityListInVC:self];
}

- (void)getSelectedCityName:(NSString *)cityName{
    self.cityLabel.text = cityName;
}
@end
