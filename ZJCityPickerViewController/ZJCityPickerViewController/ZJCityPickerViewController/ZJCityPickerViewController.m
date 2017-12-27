//
//  ZJCityPickerViewController.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJCityPickerViewController.h"
#import "ZJCityPickerViewAdapter.h"
#import "ZJCityPickerLocation.h"

@interface ZJCityPickerViewController ()<UISearchBarDelegate, ZJCityPickerLocationDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) ZJCityPickerAppearance *appearance;

@property (nonatomic, strong) ZJCityPickerDataSource *dataSource;

@property (nonatomic, strong) ZJCityPickerViewAdapter *adapter;

@property (nonatomic, strong) ZJCityPickerLocation *location;

@end

@implementation ZJCityPickerViewController
+ (instancetype)pickerController {
    return [[ZJCityPickerViewController alloc] init];
}

+ (instancetype )pickerControllerWithAppearance:(ZJCityPickerAppearance *)apperance dataSource:(ZJCityPickerDataSource *)dataSource {
    ZJCityPickerViewController *picker = [[ZJCityPickerViewController alloc] init];
    picker.appearance = apperance;
    picker.dataSource = dataSource;
    return picker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self startLocation];
}

- (void)setUpUI {
    self.navigationItem.title = @"城市选择";
    self.view.backgroundColor = self.appearance.backgroundColor;
    _adapter = [ZJCityPickerViewAdapter adapterWithTableView:self.tableView appearance:self.appearance dataSource:self.dataSource];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (void)startLocation {
    if (!_location) {
        _location = [ZJCityPickerLocation locationWithDelegate:self];
    }
    _dataSource.locationModel.locationState = ZJCityPickerLocateStateLocating;
    [self.tableView reloadData];
    [_location startLocation];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.searchBar.frame = CGRectMake(10, _appearance.navHeight + 6, self.view.frame.size.width - 20, 28);
    self.tableView.frame = CGRectMake(0, _appearance.navHeight + 40, self.view.frame.size.width, self.view.frame.size.height - 28);
}

#pragma mark - ZJCityPickerLocationDelegate
- (void)zj_CityPickerLocationSuccessWithCity:(NSString *)city {
    if ([city hasSuffix:@"市"]) {
        city = [city substringToIndex:city.length - 1];
    }
    _dataSource.locationModel.locationState = ZJCityPickerLocateStateSuccess;
    _dataSource.locationModel.cityArray = @[city];
    [self.tableView reloadData];
}

- (void)zj_CityPickerLocationFailureLocation {
    _dataSource.locationModel.locationState = ZJCityPickerLocateStateFailure;
    [self.tableView reloadData];
}

- (void)zj_CityPickerLocationDidDeny {
    NSString *message = [NSString stringWithFormat:@"请到 \"设置->%@->位置\" 开启定位服务的访问权限",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"去设置" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    UIAlertAction *knowAction = [UIAlertAction actionWithTitle:@"知道了" style:(UIAlertActionStyleDefault) handler:nil];
    [alert addAction:knowAction];
    [alert addAction:settingAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)zj_CityPickerLocationNotOpenService {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请到 \"设置->隐私->定位服务\" 开启定位服务" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
    [alert addAction:action];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
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

- (ZJCityPickerAppearance *)appearance {
    if (!_appearance) {
        _appearance = [ZJCityPickerAppearance appearance];
    }
    return _appearance;
}

- (ZJCityPickerDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [ZJCityPickerDataSource dataSource];
    }
    return _dataSource;
}

@end
