//
//  ZJCityPickerGroupModel.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/18.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJCityPickerGroupModel.h"

@implementation ZJCityPickerGroupModel

+ (ZJCityPickerGroupModel *)hotGroupModel {
    ZJCityPickerGroupModel *model = [[ZJCityPickerGroupModel alloc] init];
    model.type = ZJCityPickerGroupModelTypeHotCity;
    model.cityArray = @[@"上海",@"北京",@"广州",@"杭州",@"深圳",@"武汉",@"成都",@"重庆",@"南京",@"西安"];
    model.title = @"热门城市";
    model.indexTitle = @"热门";
    return model;
}

+ (ZJCityPickerGroupModel *)locationGroupModel {
    ZJCityPickerGroupModel *model = [[ZJCityPickerGroupModel alloc] init];
    model.type = ZJCityPickerGroupModelTypeLocationCity;
    model.locationState = ZJCityPickerLocateStateLocating;
    model.cityArray = @[];
    model.title = @"定位城市";
    model.indexTitle = @"定位";
    return model;
}

+ (ZJCityPickerGroupModel *)historyGroupModel {
    ZJCityPickerGroupModel *model = [[ZJCityPickerGroupModel alloc] init];
    model.type = ZJCityPickerGroupModelTypeHistoryCity;
    model.cityArray = @[];
    model.title = @"历史访问城市";
    model.indexTitle = @"历史";
    return model;
}

@end
