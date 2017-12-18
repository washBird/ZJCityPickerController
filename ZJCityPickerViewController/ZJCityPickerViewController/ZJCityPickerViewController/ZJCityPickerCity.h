//
//  ZJCityPickerCity.h
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/18.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJCityPickerCity : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *pinyin;

+ (instancetype )modelWithDictionary:(NSDictionary *)dict;

+ (NSArray<ZJCityPickerCity *> *)modelArrayWithDictArray:(NSArray <NSDictionary *> *)dictArray;

+ (NSArray<ZJCityPickerCity *> *)defaultCitiesArray;

@end
