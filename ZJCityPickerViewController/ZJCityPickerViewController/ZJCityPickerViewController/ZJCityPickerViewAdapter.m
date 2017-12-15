//
//  ZJCityPickerViewAdapter.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJCityPickerViewAdapter.h"
#import "ZJCityPickerAppearance.h"
#import "UIColor+ZJHexString.h"

@interface ZJCityPickerViewAdapter()

@end

static NSString *const UITableViewHeaderFooterHeaderID = @"UITableViewHeaderFooterHeaderID";

@implementation ZJCityPickerViewAdapter

+ (ZJCityPickerViewAdapter *)adapterWithTableView:(UITableView *)tableView {
    return [[ZJCityPickerViewAdapter alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _dataArray = @[@"a",@"b",@"c"];
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:UITableViewHeaderFooterHeaderID];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:UITableViewHeaderFooterHeaderID];
    header.contentView.backgroundColor = _appearance.backgroundColor;
    header.textLabel.text = _dataArray[section];
    header.textLabel.textColor = _appearance.textColor;
    header.textLabel.font = [UIFont systemFontOfSize:12];
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _appearance.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _appearance.headerHeight;
}

@end
