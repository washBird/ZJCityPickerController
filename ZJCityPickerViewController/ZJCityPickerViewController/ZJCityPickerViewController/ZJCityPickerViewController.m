//
//  ZJCityPickerViewController.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJCityPickerViewController.h"

@interface ZJCityPickerViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ZJCityPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appearance = [ZJCityPickerAppearance appearance];
    [self setUpUI];
}

- (void)setUpUI {
    self.navigationItem.title = @"城市选择";
    self.view.backgroundColor = _appearance.backgroundColor;
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.searchBar.frame = CGRectMake(10, _appearance.navHeight + 6, self.view.frame.size.width - 20, 28);
    self.tableView.frame = CGRectMake(0, _appearance.navHeight + 40, self.view.frame.size.width, self.view.frame.size.height - 28);
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = _appearance.seperateColor;
        _tableView.backgroundColor = _appearance.backgroundColor;
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = _appearance.mainColor;
        _tableView.rowHeight = _appearance.rowHeight;
    }
    return _tableView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"搜索城市名或拼音";
        _searchBar.backgroundImage = [self imageWithColor:_appearance.backgroundColor];
        _searchBar.tintColor = _appearance.mainColor;
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        [_searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    }
    return _searchBar;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
