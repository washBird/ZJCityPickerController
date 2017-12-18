//
//  ZJCityPickerCity.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/18.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJCityPickerCity.h"

@implementation ZJCityPickerCity

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    ZJCityPickerCity *city = [[ZJCityPickerCity alloc] init];
    city.name = dict[@"name"];
    city.pinyin = dict[@"pinyin"];
    return city;
}

+ (NSArray<ZJCityPickerCity *> *)modelArrayWithDictArray:(NSArray<NSDictionary *> *)dictArray {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        [array addObject:[ZJCityPickerCity modelWithDictionary:dict]];
    }
    return array.copy;
}

#pragma mark - default cities
+ (NSArray<ZJCityPickerCity *> *)defaultCitiesArray {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"ZJCityPickerViewControllerSource" ofType:@"bundle"]];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:[bundle pathForResource:@"ZJCityPickerCities" ofType:@"plist"]];
    return [ZJCityPickerCity modelArrayWithDictArray:plistArray];
}

@end
