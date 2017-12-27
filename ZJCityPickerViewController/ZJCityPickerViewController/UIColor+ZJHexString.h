//
//  UIColor+ZJHexString.h
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZJHexString)

+ (UIColor *)zj_colorWithHexString:(NSString *)hexString;

+ (UIColor *)zj_colorWithHexString:(NSString *)hexString alpha:(CGFloat )alpha;

@end
