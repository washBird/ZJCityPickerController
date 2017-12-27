//
//  ZJCityPickerDataSource.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/18.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJCityPickerDataSource.h"
#import "ZJCityPickerCity.h"

@implementation ZJCityPickerDataSource

+ (instancetype)dataSource {
    return [[ZJCityPickerDataSource alloc] init];
}

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
    
    _normalArray = [ZJCityPickerGroupModel normalGroupModelArray];
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
    _indexTitlesArray = [_totalArray valueForKeyPath:@"indexTitle"];
}

#pragma mark - Search
- (void)searchCityWithKeyword:(NSString *)keyword completion:(void (^)(NSArray *))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{//异步查询
        if (keyword.length == 0 ) {
            _isShowSearch = NO;
            _searchCities = nil;
        }
        else {
            _isShowSearch = YES;
            NSMutableArray *searchArray = [NSMutableArray array];
            for (ZJCityPickerGroupModel *group in self.normalArray) {
                for (ZJCityPickerCity *cityModel in group.cityArray) {
                    //正则匹配
                    if ([cityModel.name containsString:keyword]) {
                        [searchArray addObject:cityModel];
                    }
                    else if([cityModel.pinyin containsString:keyword]){
                        [searchArray addObject:cityModel];
                    }
                }
            }
            _searchCities = searchArray.copy;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(_searchCities);
            }
        });
    });
}
#pragma mark - Setter
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
        _selectCity = selectCity;
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
