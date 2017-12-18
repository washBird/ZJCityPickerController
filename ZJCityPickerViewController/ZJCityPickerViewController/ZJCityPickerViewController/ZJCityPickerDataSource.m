//
//  ZJCityPickerDataSource.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/18.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJCityPickerDataSource.h"

@implementation ZJCityPickerDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialData];
    }
    return self;
}

- (void)initialData {
    _headerTypesArray = @[@(ZJCityPickerGroupModelTypeLocationCity), @(ZJCityPickerGroupModelTypeHistoryCity), @(ZJCityPickerGroupModelTypeHotCity)];
    
    _locationModel = [ZJCityPickerGroupModel locationGroupModel];
    _locationModel.cityArray = @[@(ZJCityPickerLocateStateLocating)];
    
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    _historyPath = [path stringByAppendingPathComponent:@"ZJCityHistoryList"];
    _maxHistoryCount = 3;
    _historyModel = [ZJCityPickerGroupModel historyGroupModel];
    _historyModel.cityArray = [NSArray arrayWithContentsOfFile:_historyPath];
    
    _hotModel = [ZJCityPickerGroupModel hotGroupModel];
    
    [self resetTotalArray];
    _needRefresh = YES;
}

- (void)resetTotalArray {
    NSMutableArray *totalArray = [NSMutableArray array];
    if (_headerTypesArray.count > 0) {
        for (NSNumber *num in _headerTypesArray) {
            if (num.integerValue == ZJCityPickerGroupModelTypeHotCity) {
                [totalArray addObject:_hotModel];
            }
            else if (num.integerValue == ZJCityPickerGroupModelTypeHistoryCity) {
                if (_historyModel.cityArray.count > 0) {
                    [totalArray addObject:_historyModel];
                }
            }
            else if (num.integerValue == ZJCityPickerGroupModelTypeLocationCity) {
                [totalArray addObject:_locationModel];
            }
        }
    }
    if (_normalArray.count > 0) {
        [totalArray addObjectsFromArray:_normalArray];
    }
    _totalArray = totalArray;
}

- (void)setHeaderTypesArray:(NSArray *)headerTypesArray {
    if (_headerTypesArray != headerTypesArray) {
        _headerTypesArray = headerTypesArray.copy;
        [self resetTotalArray];
        _needRefresh = YES;
    }
}

- (void)setNormalArray:(NSArray<ZJCityPickerGroupModel *> *)normalArray {
    if (_normalArray != normalArray) {
        _normalArray = normalArray.copy;
        [self resetTotalArray];
        _needRefresh = YES;
    }
}

- (void)modifyHotCities:(NSArray *)hotCities {
    if (_hotModel) {
        _hotModel.cityArray = hotCities;
        _needRefresh = YES;
    }
}

- (void)setHistoryPath:(NSString *)historyPath {
    if (historyPath != nil && ![historyPath isEqualToString:_historyPath]) {
        _historyPath = historyPath;
        _historyModel.cityArray = [NSArray arrayWithContentsOfFile:_historyPath];
        _needRefresh = YES;
    }
}

- (void)setMaxHistoryCount:(NSUInteger)maxHistoryCount {
    if (maxHistoryCount != _maxHistoryCount && _historyModel.cityArray.count > maxHistoryCount) {
        _maxHistoryCount = maxHistoryCount;
        _historyModel.cityArray = [_historyModel.cityArray subarrayWithRange:NSMakeRange(0, _maxHistoryCount)];
        [_historyModel.cityArray writeToFile:_historyPath atomically:YES];
        _needRefresh = YES;
    }
}

- (void)setSelectCity:(NSString *)selectCity {
    if (![selectCity isEqualToString:_selectCity]) {
        if (_historyModel.cityArray.count > 0) {
            NSMutableArray *array = [NSMutableArray arrayWithObject:selectCity];
            for (NSString *lastCity in _historyModel.cityArray) {
                if (![array containsObject:lastCity]) {
                    [array addObject:lastCity];
                    if (array.count == _maxHistoryCount) {
                        break;
                    }
                }
            }
            _historyModel.cityArray = array;
        }
        else {
            _historyModel.cityArray = @[_selectCity];
            if ([_headerTypesArray containsObject:@(ZJCityPickerGroupModelTypeHistoryCity)]) {
                [self resetTotalArray];
            }
        }
        [_historyModel.cityArray writeToFile:_historyPath atomically:YES];
        _needRefresh = YES;
    }
}

@end
