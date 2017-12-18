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
#import "ZJCityPickerCollectionHeader.h"
#import "ZJCityPickerDataSource.h"

@interface ZJCityPickerViewAdapter()

@end

static NSString *const UITableViewHeaderFooterHeaderID = @"UITableViewHeaderFooterHeaderID";
static NSString *const ZJCityPickerCollectionHeaderReuseID = @"ZJCityPickerCollectionHeaderReuseID";

@implementation ZJCityPickerViewAdapter

+ (ZJCityPickerViewAdapter *)adapterWithTableView:(UITableView *)tableView {
    return [[ZJCityPickerViewAdapter alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:UITableViewHeaderFooterHeaderID];
        [_tableView registerClass:[ZJCityPickerCollectionHeader class] forCellReuseIdentifier:ZJCityPickerCollectionHeaderReuseID];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.totalArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZJCityPickerGroupModel *groupModel = _dataSource.totalArray[section];
    if (groupModel.type == ZJCityPickerGroupModelTypeNormal) {
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:UITableViewHeaderFooterHeaderID];
        //设置为clearcolor无效， 只能设置透明的图片实现透明效果
        header.contentView.backgroundColor = _appearance.backgroundColor;
        header.textLabel.text = _dataSource.totalArray[section].title;
        header.textLabel.textColor = _appearance.headerTextColor;
        header.textLabel.font = [UIFont systemFontOfSize:12];
        return header;
    }
    else {
        ZJCityPickerCollectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ZJCityPickerCollectionHeaderReuseID];
        header.model = groupModel;
        header.appearance = _appearance;
        header.selectedCity  = _dataSource.selectCity;
        return header;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _appearance.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [_appearance headerHeightWithGroupModel:_dataSource.isShowSearch ? nil : _dataSource.totalArray[section]];
}

@end
