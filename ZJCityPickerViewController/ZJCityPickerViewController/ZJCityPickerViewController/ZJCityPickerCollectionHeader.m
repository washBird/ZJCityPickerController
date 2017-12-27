//
//  ZJCityPickerCollectionHeader.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/18.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJCityPickerCollectionHeader.h"
#import "UIColor+ZJHexString.h"

@implementation ZJCityPickerCollectionTitleCell
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
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
- (void)setUpUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
    self.contentView.layer.borderColor = [UIColor zj_colorWithHexString:@"dddddd"].CGColor;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor zj_colorWithHexString:@"7d7d7d"];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
}
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.contentView.layer.borderColor = _borderColor.CGColor;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.contentView.bounds;
}
@end

@implementation ZJCityPickerCollectionTitleHeader
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
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
- (void)setUpUI {
    self.backgroundColor = [UIColor clearColor];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor zj_colorWithHexString:@"7d7d7d"];
    _titleLabel.font = [UIFont systemFontOfSize:10];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(15, 0, self.frame.size.width - 15, self.frame.size.height);
}
@end

@interface ZJCityPickerCollectionHeader()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@end
static NSString *const ZJCityPickerCollectionTitleCellReuseID = @"ZJCityPickerCollectionTitleCellReuseID";
static NSString *const ZJCityPickerCollectionTitleHeaderReuseID = @"ZJCityPickerCollectionTitleHeaderReuseID";
@implementation ZJCityPickerCollectionHeader

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
    _collectionView.frame = self.contentView.bounds;
}

- (void)setUpUI {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(floor((width - 30 - 20) / 3) , 30);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 15, 15, 30);
    flowLayout.headerReferenceSize = CGSizeMake(width, 28);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[ZJCityPickerCollectionTitleCell class] forCellWithReuseIdentifier:ZJCityPickerCollectionTitleCellReuseID];
    [_collectionView registerClass:[ZJCityPickerCollectionTitleHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZJCityPickerCollectionTitleHeaderReuseID];
    _collectionView.scrollEnabled = NO;
    [self.contentView addSubview:_collectionView];
}

- (void)setAppearance:(ZJCityPickerAppearance *)appearance {
    _appearance = appearance;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.contentView.backgroundColor = _appearance.backgroundColor;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(floor((width - _appearance.sectionInset.left - _appearance.sectionInset.right - (_appearance.itemsOfLine - 1) * _appearance.itemMinSpace) / 3) , _appearance.itemHeight);
    flowLayout.minimumLineSpacing = _appearance.itemMinLineSpace;
    flowLayout.minimumInteritemSpacing = _appearance.itemMinSpace;
    flowLayout.sectionInset = _appearance.sectionInset;
    flowLayout.headerReferenceSize = CGSizeMake(width, _appearance.headerHeight);
    [self.collectionView reloadData];
}

- (void)setModel:(ZJCityPickerGroupModel *)model {
    _model = model;
    if (model) {
        [self.collectionView reloadData];
    }
}

- (void)setSelectedCity:(NSString *)selectedCity {
    _selectedCity = selectedCity;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _model.cityArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJCityPickerCollectionTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZJCityPickerCollectionTitleCellReuseID forIndexPath:indexPath];
    cell.titleLabel.textAlignment = NSTextAlignmentCenter;
    if (_model.type == ZJCityPickerGroupModelTypeLocationCity) {
        if (_model.locationState == ZJCityPickerLocateStateLocating) {
            cell.titleLabel.text = _appearance.locatingTip;
        }
        else if (_model.locationState == ZJCityPickerLocateStateFailure) {
            cell.titleLabel.text = _appearance.locationErrorTip;
            cell.titleLabel.textAlignment = NSTextAlignmentLeft;
        }
        else {
            cell.titleLabel.text = _model.cityArray[indexPath.row];
        }
    }
    else {
        cell.titleLabel.text = _model.cityArray[indexPath.row];
    }
    cell.titleLabel.textColor = [_selectedCity isEqualToString:cell.titleLabel.text]  ? _appearance.mainColor : _appearance.textColor;
    cell.borderColor = [_selectedCity isEqualToString:cell.titleLabel.text] ? _appearance.mainColor : _appearance.nomalBorderColor;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ZJCityPickerCollectionTitleHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:ZJCityPickerCollectionTitleHeaderReuseID forIndexPath:indexPath];
    header.titleLabel.text = _model.title;
    header.titleLabel.textColor = _appearance.headerTextColor;
    return header;
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_model.type == ZJCityPickerGroupModelTypeLocationCity && _model.locationState == ZJCityPickerLocateStateFailure) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        return CGSizeMake(width - _appearance.sectionInset.left - _appearance.sectionInset.right , _appearance.itemHeight);
    }
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.itemSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
