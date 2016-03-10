//
//  YZLCityListViewController.m
//  YZL_Map_Demo
//
//  Created by YZL on 16/3/2.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import "YZLCityListViewController.h"
#import "YZLCitySearchResultTableViewController.h"
#import "YZLCityGroup.h"
#import "YZLCityHeader.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "UIBarButtonItem+Extension.h"

@interface YZLCityListViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
// 城市组别
@property (nonatomic, strong) NSArray *cityGroups;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) YZLCitySearchResultTableViewController *citySearchResultVC;
// 搜索框内的文字
@property (nonatomic, copy) NSString *searchText;
@end

@implementation YZLCityListViewController
#pragma mark - lazy load
- (YZLCitySearchResultTableViewController *)citySearchResultVC{
    if (!_citySearchResultVC) {
        YZLCitySearchResultTableViewController *citySearchResultVC = [[YZLCitySearchResultTableViewController alloc] init];
        _citySearchResultVC = citySearchResultVC;
        [self addChildViewController:_citySearchResultVC];
        [self.view addSubview:_citySearchResultVC.view];
        [_citySearchResultVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.top.mas_equalTo(self.searchBar.mas_bottom).mas_equalTo(15);
        }];
    }
    return _citySearchResultVC;
}

#pragma mark - View func
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置遮盖不可见
    self.coverButton.alpha = 0;
    // 初始化导航栏的背景
    UIImage *image = [YZLCityListViewController resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) forImage:[UIImage imageNamed:@"bg_textfield"]];
    [self.searchBar setBackgroundImage:image];
    // 基本设置
    self.title = @"切换城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"btn_navigation_close" highImage:@"btn_navigation_close_hl"];
    // 右边字母的颜色
    self.tableView.sectionIndexColor = [UIColor blackColor];
    // 加载城市数据
    self.cityGroups = [YZLCityGroup mj_objectArrayWithFilename:@"cityGroups.plist"];
}

#pragma mark - searchBarDelegateMethod
//键盘弹出:搜索框开始编辑文字的时候调用
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    // 1.隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // 2.修改搜索框的背景图片
    UIImage *image = [YZLCityListViewController resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) forImage:[UIImage imageNamed:@"bg_textfield_hl"]];
    [searchBar setBackgroundImage:image];
    // 3.显示搜索框右边的取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    // 4.显示遮盖
    [UIView animateWithDuration:0.5 animations:^{
        self.coverButton.alpha = 0.5;
    }];
}

//键盘退下:搜索框结束编辑文字的时候调用
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    // 1.显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 2.修改搜索框的背景图片
    UIImage *image = [YZLCityListViewController resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) forImage:[UIImage imageNamed:@"bg_textfield"]];
    [searchBar setBackgroundImage:image];
    // 3.隐藏搜索框右边的取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    // 4.隐藏遮盖
    [UIView animateWithDuration:0.5 animations:^{
        self.coverButton.alpha = 0.0;
    }];
    // 5.移除搜索结果
    self.citySearchResultVC.view.hidden = YES;
    searchBar.text = nil;
}

//搜索框结束编辑文字的时候调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

//搜索框里面的文字变化的时候调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length) {
        self.citySearchResultVC.view.hidden = NO;
        self.citySearchResultVC.searchText = searchText;
    } else {
        self.citySearchResultVC.view.hidden = YES;
    }
}

//点击遮盖
- (IBAction)coverClick:(id)sender {
    [self.searchBar resignFirstResponder];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YZLCityGroup *group = self.cityGroups[section];
    return group.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    YZLCityGroup *group = self.cityGroups[indexPath.section];
    cell.textLabel.text = group.cities[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    YZLCityGroup *group = self.cityGroups[section];
    return group.title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return [self.cityGroups valueForKeyPath:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YZLCityGroup *group = self.cityGroups[indexPath.section];
    [[NSNotificationCenter defaultCenter] postNotificationName:YZLCityDidChangeNotification object:nil userInfo:@{YZLSelectedCityNameNotification : group.cities[indexPath.row]}];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Tool Methods
//关闭城市列表
- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//九切片切图
+ (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)inset forImage:(UIImage *)image{
    return [image resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YZLCityDidChangeNotification object:nil];
}

@end
