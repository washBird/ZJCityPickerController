//
//  UIColor+ZJHexString.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "UIColor+ZJHexString.h"

@implementation UIColor (ZJHexString)

static inline CGFloat RGBValueWithHexString(NSString *hexString) {
    unsigned int rgbValue = 0;
    NSScanner *hexValueScanner = [NSScanner scannerWithString:[@"0x" stringByAppendingString:hexString]];
    [hexValueScanner scanHexInt:&rgbValue];
    return rgbValue / 255.0;
}

+ (UIColor *)zj_colorWithHexString:(NSString *)hexString {
    return [self zj_colorWithHexString:hexString alpha:1];
}

+ (UIColor *)zj_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    if (hexString.length != 6 && hexString.length != 7) {
        return nil;
    }
    if (hexString.length == 7) {
        hexString = [hexString substringFromIndex:1];
    }
    return [UIColor colorWithRed:RGBValueWithHexString([hexString substringWithRange:NSMakeRange(0, 2)]) green:RGBValueWithHexString([hexString substringWithRange:NSMakeRange(2, 2)]) blue:RGBValueWithHexString([hexString substringWithRange:NSMakeRange(4, 2)]) alpha:alpha];
}

@end
