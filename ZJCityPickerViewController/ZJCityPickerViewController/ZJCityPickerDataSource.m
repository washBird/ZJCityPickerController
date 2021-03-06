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
    _historyModel = [ZJCityPickerGroupModel historyGroupModel];
    _maxHistoryCount = 3;
    _historyModel.cityArray = [NSArray arrayWithContentsOfFile:_historyPath];
    if (_historyModel.cityArray.count > _maxHistoryCount) {
        _historyModel.cityArray = [_historyModel.cityArray subarrayWithRange:NSMakeRange(0, _maxHistoryCount)];
    }
    
    _hotModel = [ZJCityPickerGroupModel hotGroupModel];
    
    _normalArray = [ZJCityPickerGroupModel normalGroupModelArray];
    [self resetTotalArray];
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
                    else {
                        if ([self isMatchWithoriginString:cityModel.pinyin matchString:[keyword lowercaseString]]) {
                            [searchArray addObject:cityModel];
                        }
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

- (BOOL)isMatchWithoriginString:(NSString *)originString matchString:(NSString *)matchString {
    if ([originString containsString:matchString]) {
        return YES;
    }
    NSInteger nowLocation = NSNotFound;
    NSString *searchString = originString;
    for (NSInteger index = 0; index < matchString.length; index ++ ) {
        nowLocation = [searchString rangeOfString:[matchString substringWithRange:NSMakeRange(index, 1)]].location;
        if (nowLocation == NSNotFound) {
            return NO;
        }
        if (nowLocation == searchString.length - 1) {//匹配到最后一个了
            return index == matchString.length - 1;
        }
        else {
            searchString = [searchString substringFromIndex:nowLocation + 1];
        }
    }
    return YES;
}
#pragma mark - Setter
- (void)setHeaderTypesArray:(NSArray *)headerTypesArray {
    if (_headerTypesArray != headerTypesArray) {
        _headerTypesArray = headerTypesArray.copy;
        [self resetTotalArray];
    }
}

- (void)setNormalArray:(NSArray<ZJCityPickerGroupModel *> *)normalArray {
    if (_normalArray != normalArray) {
        _normalArray = normalArray.copy;
        [self resetTotalArray];
    }
}

- (void)modifyHotCities:(NSArray *)hotCities {
    if (_hotModel) {
        _hotModel.cityArray = hotCities;
    }
}

- (void)setHistoryPath:(NSString *)historyPath {
    if (historyPath != nil && ![historyPath isEqualToString:_historyPath]) {
        _historyPath = historyPath;
        _historyModel.cityArray = [NSArray arrayWithContentsOfFile:_historyPath];
    }
}

- (void)setMaxHistoryCount:(NSUInteger)maxHistoryCount {
    if (maxHistoryCount != _maxHistoryCount ) {
        _maxHistoryCount = maxHistoryCount;
        _historyModel.cityArray = [NSArray arrayWithContentsOfFile:_historyPath];
        if (_historyModel.cityArray.count > maxHistoryCount) {
            _historyModel.cityArray = [_historyModel.cityArray subarrayWithRange:NSMakeRange(0, _maxHistoryCount)];
        }
    }
    
}


- (void)handleSelectedCity:(NSString *)city {
    if (![city isEqualToString:_selectCity]) {
        _selectCity = city;
        if (_historyModel.cityArray.count > 0) {
            NSMutableArray *array = [NSMutableArray arrayWithObject:city];
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
    }
}

@end
