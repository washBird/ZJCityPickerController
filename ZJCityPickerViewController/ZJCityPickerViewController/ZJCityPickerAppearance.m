//
//  ZJCityPickerAppearance.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJCityPickerAppearance.h"
#import "UIColor+ZJHexString.h"
#import "ZJCityPickerGroupModel.h"

@implementation ZJCityPickerAppearance

+ (instancetype)appearance {
    return [[ZJCityPickerAppearance alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _backgroundColor = [UIColor zj_colorWithHexString:@"f3f3f3"];
        _seperateColor = [UIColor zj_colorWithHexString:@"e6e6e6"];
        _headerTextColor = [UIColor zj_colorWithHexString:@"7d7d7d"];
        _textColor = [UIColor zj_colorWithHexString:@"7d7d7d"];
        _nomalBorderColor = [UIColor zj_colorWithHexString:@"dddddd"];
        _mainColor = [UIColor zj_colorWithHexString:@"2bc76d"];
        
        _sectionInset = UIEdgeInsetsMake(5, 15, 15, 30);
        _itemMinLineSpace = 10;
        _itemMinSpace = 10;
        _itemsOfLine = 3;
        _itemHeight = 30;
        _headerHeight = 28;
        _rowHeight = 48;
        
        _locatingTip = @"定位中...";
        _locationErrorTip = @"定位失败，点击重试！";
    }
    return self;
}

- (CGFloat)navHeight {
    return ([[UIApplication sharedApplication] statusBarFrame].size.height + 44);
}

- (CGFloat)headerHeightWithGroupModel:(ZJCityPickerGroupModel *)groupModel {
    if (groupModel == nil) {
        return 0;
    }
    if (groupModel.type == ZJCityPickerGroupModelTypeNormal) {
        return _headerHeight;
    }
    return [self calculateHeaderHeightWithItemsCount:groupModel.cityArray.count];
}

- (CGFloat)calculateHeaderHeightWithItemsCount:(NSInteger )itemsCount {
    CGFloat sectionHeight = _sectionInset.top + _sectionInset.bottom + _headerHeight;
    CGFloat columns = (itemsCount - 1) / _itemsOfLine + 1;
    CGFloat itemsHeight = columns * _itemHeight + (columns > 0 ? (columns - 1) * _itemMinLineSpace : 0);
    return itemsHeight + sectionHeight;
}

@end
