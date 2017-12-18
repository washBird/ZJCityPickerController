//
//  ZJCityPickerGroupModel.h
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/18.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , ZJCityPickerGroupModelType) {
    ZJCityPickerGroupModelTypeNormal = 0, //A,B,C...
    ZJCityPickerGroupModelTypeHotCity,
    ZJCityPickerGroupModelTypeHistoryCity,
    ZJCityPickerGroupModelTypeLocationCity,
};

@interface ZJCityPickerGroupModel : NSObject

@property (nonatomic, assign) ZJCityPickerGroupModelType type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *indexTitle;

@property (nonatomic, copy) NSArray *cityArray;

@end
