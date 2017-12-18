//
//  ZJCityPickerAppearance.h
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJCityPickerAppearance : NSObject

//标签栏的sectionInset
@property (nonatomic, assign)  UIEdgeInsets sectionInset;

//每行的标签数
@property (nonatomic, assign) NSUInteger itemsOfLine;

//标签高度
@property (nonatomic, assign) CGFloat itemHeight;

//标签横向最小间距
@property (nonatomic, assign) CGFloat itemMinSpace;

//标签行间最小间距
@property (nonatomic, assign) CGFloat itemMinLineSpace;

//标题栏高度
@property (nonatomic, assign) CGFloat headerHeight;

//标签正常borderColor
@property (nonatomic, strong) UIColor *nomalBorderColor;

//头部文字颜色
@property (nonatomic, strong) UIColor *headerTextColor;

//文字正常颜色
@property (nonatomic, strong) UIColor *textColor;

//选中主色
@property (nonatomic, strong) UIColor *mainColor;

//分割线颜色
@property (nonatomic, strong) UIColor *seperateColor;

//头部背景color
@property (nonatomic, strong) UIColor *backgroundColor;

//城市列表行高度
@property (nonatomic, assign) CGFloat rowHeight;

//定位中文字
@property (nonatomic, copy) NSString *locatingTip;

//定位失败文字
@property (nonatomic, copy) NSString *locationErrorTip;

+ (instancetype)appearance;

- (CGFloat )navHeight;

@end
