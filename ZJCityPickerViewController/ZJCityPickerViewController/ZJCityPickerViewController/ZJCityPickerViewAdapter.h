//
//  ZJCityPickerViewAdapter.h
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJCityPickerAppearance;
@class ZJCityPickerDataSource;

@protocol ZJCityPickerViewAdapterDelegate<NSObject>
@optional
- (void)zj_CityPickerViewAdapterLocationRefresh;
- (void)zj_CityPickerViewAdapterSelectCity:(NSString *)selectCity;
- (void)zj_CityPickerViewScrollViewBeginDragging;
@end

@interface ZJCityPickerViewAdapter : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) ZJCityPickerDataSource *dataSource;
//UI样式
@property (nonatomic, strong) ZJCityPickerAppearance *appearance;

@property (nonatomic, weak) id<ZJCityPickerViewAdapterDelegate> delegate;

+ (ZJCityPickerViewAdapter *)adapterWithTableView:(UITableView *)tableView appearance:(ZJCityPickerAppearance *)appearance dataSource:(ZJCityPickerDataSource *)dataSource;

- (instancetype)initWithTableView:(UITableView *)tableView appearance:(ZJCityPickerAppearance *)appearance dataSource:(ZJCityPickerDataSource *)dataSource;

@end
