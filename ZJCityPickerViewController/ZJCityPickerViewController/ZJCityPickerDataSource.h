//
//  ZJCityPickerDataSource.h
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/18.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJCityPickerGroupModel.h"

@interface ZJCityPickerDataSource : NSObject

@property (nonatomic, strong, readonly) NSArray<ZJCityPickerGroupModel *> *totalArray;
@property (nonatomic, strong, readonly) NSArray *indexTitlesArray;

// A, B, C, ...
@property (nonatomic, copy) NSArray<ZJCityPickerGroupModel *> *normalArray;

//改变（定位，历史，热门）的顺序，或者删除 [location,history,hot]
@property (nonatomic, copy) NSArray *headerTypesArray;

@property (nonatomic, strong, readonly) ZJCityPickerGroupModel *locationModel;
@property (nonatomic, strong, readonly) ZJCityPickerGroupModel *historyModel;
@property (nonatomic, strong, readonly) ZJCityPickerGroupModel *hotModel;

//历史缓存path NSCachesDirectory/ZJCityHistoryList
@property (nonatomic, copy) NSString *historyPath;
//最大历史缓存数 3
@property (nonatomic, assign) NSUInteger maxHistoryCount;

//选中的city
@property (nonatomic, copy) NSString *selectCity;


//搜索
@property (nonatomic, assign, readonly) BOOL isShowSearch;
@property (nonatomic, copy, readonly) NSArray *searchCities;

+ (instancetype )dataSource;

- (void)handleSelectedCity:(NSString *)city;

//修改热门城市
- (void)modifyHotCities:(NSArray *)hotCities;

- (void)searchCityWithKeyword:(NSString *)keyword completion:(void (^)(NSArray *searchArray))completion;

@end
