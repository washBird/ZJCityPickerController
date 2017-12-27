//
//  ZJCityPickerNormalHeader.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/27.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJCityPickerNormalHeader.h"
#import "UIColor+ZJHexString.h"

@interface ZJCityPickerNormalHeader()

@property (nonatomic, strong) UIView *topSeperateLine;
@property (nonatomic, strong) UIView *bottomSeperateLine;

@end

@implementation ZJCityPickerNormalHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat lineHeight = 1.0 / [UIScreen mainScreen].scale;
    _titleLabel.frame = CGRectMake(15, 0, width - 30, self.bounds.size.height);
    _topSeperateLine.frame = CGRectMake(0, 0, width, lineHeight);
    _bottomSeperateLine.frame = CGRectMake(0, height - lineHeight, width, lineHeight);
}

- (void)setUpUI {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_titleLabel];
    _topSeperateLine = [[UIView alloc] init];
    _topSeperateLine.backgroundColor = [UIColor zj_colorWithHexString:@"e5e5e5"];
    [self.contentView addSubview:_topSeperateLine];
    _bottomSeperateLine = [[UIView alloc] init];
    _bottomSeperateLine.backgroundColor = [UIColor zj_colorWithHexString:@"e5e5e5"];
    [self.contentView addSubview:_bottomSeperateLine];
}

@end
