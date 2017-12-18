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

typedef NS_ENUM(NSInteger , ZJCityPickerLocateState) {
    ZJCityPickerLocateStateNone = 0,//非定位
    ZJCityPickerLocateStateSuccess,
    ZJCityPickerLocateStateLocating,
    ZJCityPickerLocateStateFailure,
};

@interface ZJCityPickerGroupModel : NSObject

@property (nonatomic, assign) ZJCityPickerGroupModelType type;

@property (nonatomic, assign) ZJCityPickerLocateState locationState;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *indexTitle;

@property (nonatomic, copy) NSArray *cityArray;

+ (ZJCityPickerGroupModel *)locationGroupModel;
+ (ZJCityPickerGroupModel *)hotGroupModel;
+ (ZJCityPickerGroupModel *)historyGroupModel;

@end
