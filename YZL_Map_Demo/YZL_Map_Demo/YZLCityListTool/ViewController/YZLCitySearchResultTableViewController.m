//
//  YZLCitySearchResultTableViewController.m
//  YZL_Map_Demo
//
//  Created by YZL on 16/3/2.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import "YZLCitySearchResultTableViewController.h"
#import "YZLCityModel.h"
#import "YZLCityHeader.h"
#import "MJExtension.h"

@interface YZLCitySearchResultTableViewController ()
/** 存储搜索结果的城市数组 */
@property (nonatomic, strong) NSArray *resultCities;
@end

@implementation YZLCitySearchResultTableViewController
#pragma mark - lazy load
static NSArray *_cities;
+ (NSArray *)cities{
    if (_cities == nil) {
        _cities = [YZLCityModel mj_objectArrayWithFilename:@"cities.plist"];;
    }
    return _cities;
}

#pragma mark - View func
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - set Methods
- (void)setSearchText:(NSString *)searchText{
    _searchText = [searchText copy];
    searchText = searchText.lowercaseString;
    // 谓词\过滤器:能利用一定的条件从一个数组中过滤出想要的数据
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@ or pinYin contains %@ or pinYinHead contains %@", searchText, searchText, searchText];
    self.resultCities = [[YZLCitySearchResultTableViewController cities] filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    YZLCityModel *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"共有%ld个搜索结果", self.resultCities.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YZLCityModel *city = self.resultCities[indexPath.row];
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:YZLCityDidChangeNotification object:nil userInfo:@{YZLSelectedCityNameNotification : city.name}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
