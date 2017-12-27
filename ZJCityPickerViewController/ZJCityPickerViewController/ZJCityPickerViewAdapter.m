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
#import "ZJCityPickerCity.h"
#import "ZJCityPickerNormalHeader.h"

@interface ZJCityPickerViewAdapter()<ZJCityPickerCollectionHeaderDelegate>

@end

static NSString *const UITableViewCellReuseID = @"UITableViewCellReuseID";
static NSString *const ZJCityPickerCollectionHeaderReuseID = @"ZJCityPickerCollectionHeaderReuseID";
static NSString *const ZJCityPickerNormalHeaderReuseID = @"ZJCityPickerNormalHeaderReuseID";

@implementation ZJCityPickerViewAdapter

+ (ZJCityPickerViewAdapter *)adapterWithTableView:(UITableView *)tableView appearance:(ZJCityPickerAppearance *)appearance dataSource:(ZJCityPickerDataSource *)dataSource{
    return [[ZJCityPickerViewAdapter alloc] initWithTableView:tableView appearance:appearance dataSource:dataSource];
}

- (instancetype)initWithTableView:(UITableView *)tableView appearance:(ZJCityPickerAppearance *)appearance dataSource:(ZJCityPickerDataSource *)dataSource{
    self = [super init];
    if (self) {
        _tableView = tableView;
        _appearance = appearance;
        _dataSource = dataSource;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[ZJCityPickerNormalHeader class] forHeaderFooterViewReuseIdentifier:ZJCityPickerNormalHeaderReuseID];
        [_tableView registerClass:[ZJCityPickerCollectionHeader class] forHeaderFooterViewReuseIdentifier:ZJCityPickerCollectionHeaderReuseID];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCellReuseID];
        _tableView.rowHeight = _appearance.rowHeight;
        _tableView.sectionIndexColor = _appearance.mainColor;
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.isShowSearch ? 1 : _dataSource.totalArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataSource.isShowSearch) {
        return _dataSource.searchCities.count;
    }
    ZJCityPickerGroupModel *groupModel = _dataSource.totalArray[section];
    return groupModel.type == ZJCityPickerGroupModelTypeNormal ? groupModel.cityArray.count : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZJCityPickerGroupModel *groupModel = _dataSource.totalArray[section];
    if (groupModel.type == ZJCityPickerGroupModelTypeNormal) {
        ZJCityPickerNormalHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ZJCityPickerNormalHeaderReuseID];
        //设置为clearcolor无效， 只能设置透明的图片实现透明效果
        header.contentView.backgroundColor = _appearance.backgroundColor;
        header.titleLabel.text = _dataSource.totalArray[section].title;
        header.titleLabel.textColor = _appearance.headerTextColor;
        header.titleLabel.font = [UIFont systemFontOfSize:12];
        header.seperateColor = _appearance.seperateColor;
        return header;
    }
    else {
        ZJCityPickerCollectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ZJCityPickerCollectionHeaderReuseID];
        header.model = groupModel;
        header.appearance = _appearance;
        header.selectedCity  = _dataSource.selectCity;
        header.delegate = self;
        return header;
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _dataSource.isShowSearch ? @[] : _dataSource.indexTitlesArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJCityPickerCity *city = _dataSource.isShowSearch ? _dataSource.searchCities[indexPath.row] : _dataSource.totalArray[indexPath.section].cityArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellReuseID forIndexPath:indexPath];
    cell.textLabel.textColor = _appearance.textColor;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = city.name;
    cell.accessoryType = [_dataSource.selectCity isEqualToString:cell.textLabel.text] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    cell.tintColor = _appearance.mainColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [_appearance headerHeightWithGroupModel:_dataSource.isShowSearch ? nil : _dataSource.totalArray[section]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJCityPickerCity *cityModel = _dataSource.isShowSearch ? _dataSource.searchCities[indexPath.row] : _dataSource.totalArray[indexPath.section].cityArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(zj_CityPickerViewAdapterSelectCity:)]) {
        [self.delegate zj_CityPickerViewAdapterSelectCity:cityModel.name];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(zj_CityPickerViewScrollViewBeginDragging)]) {
        [self.delegate zj_CityPickerViewScrollViewBeginDragging];
    }
}
#pragma mark - ZJCityPickerCollectionHeaderDelegate
- (void)zj_CityPickerCollectionHeaderClickRefresh {
    if ([self.delegate respondsToSelector:@selector(zj_CityPickerViewAdapterLocationRefresh)]) {
        [self.delegate zj_CityPickerViewAdapterLocationRefresh];
    }
}

- (void)zj_CityPickerCollectionHeaderClickIndex:(NSInteger)index city:(NSString *)city {
    if ([self.delegate respondsToSelector:@selector(zj_CityPickerViewAdapterSelectCity:)]) {
        [self.delegate zj_CityPickerViewAdapterSelectCity:city];
    }
}

@end
