//
//  ZJCityPickerCollectionHeader.h
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/18.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJCityPickerAppearance.h"
#import "ZJCityPickerGroupModel.h"

@protocol ZJCityPickerCollectionHeaderDelegate<NSObject>
@optional
- (void)zj_CityPickerCollectionHeaderClickIndex:(NSInteger )index city:(NSString *)city;
- (void)zj_CityPickerCollectionHeaderClickRefresh;
@end

@interface ZJCityPickerCollectionTitleCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIColor *borderColor;
@end

@interface ZJCityPickerCollectionTitleHeader : UICollectionReusableView
@property (nonatomic, strong) UILabel *titleLabel;
@end

@interface ZJCityPickerCollectionHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) ZJCityPickerAppearance *appearance;

@property (nonatomic, strong) ZJCityPickerGroupModel *model;

@property (nonatomic, copy) NSString *selectedCity;

@property (nonatomic, weak) id<ZJCityPickerCollectionHeaderDelegate> delegate;

@end
