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

@interface ZJCityPickerViewAdapter : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ZJCityPickerDataSource *dataSource;

@property (nonatomic, weak) UITableView *tableView;
//UI样式
@property (nonatomic, strong) ZJCityPickerAppearance *appearance;

+ (ZJCityPickerViewAdapter *)adapterWithTableView:(UITableView *)tableView appearance:(ZJCityPickerAppearance *)appearance dataSource:(ZJCityPickerDataSource *)dataSource;

- (instancetype)initWithTableView:(UITableView *)tableView appearance:(ZJCityPickerAppearance *)appearance dataSource:(ZJCityPickerDataSource *)dataSource;

@end
