//
//  ZJCityPickerViewAdapter.h
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJCityPickerAppearance;

@interface ZJCityPickerViewAdapter : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) ZJCityPickerAppearance *appearance;

+ (ZJCityPickerViewAdapter *)adapterWithTableView:(UITableView *)tableView;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end
