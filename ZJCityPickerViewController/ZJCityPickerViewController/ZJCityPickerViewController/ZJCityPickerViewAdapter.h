//
//  ZJCityPickerViewAdapter.h
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJCityPickerAppearance;
@class ZJCityPickerGroupModel;

@interface ZJCityPickerViewAdapter : NSObject<UITableViewDelegate, UITableViewDataSource>

//group model array
@property (nonatomic, strong) NSArray<ZJCityPickerGroupModel *> *dataArray;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) ZJCityPickerAppearance *appearance;

@property (nonatomic, copy) NSString *selectedCity;

+ (ZJCityPickerViewAdapter *)adapterWithTableView:(UITableView *)tableView;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end
