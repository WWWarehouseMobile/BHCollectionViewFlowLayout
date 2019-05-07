//
//  BHCollectionHeaderReusableView.m
//  BHCollectionViewFlowLayout_Example
//
//  Created by 詹学宝 on 2019/5/5.
//  Copyright © 2019 詹学宝. All rights reserved.
//

#import "BHCollectionHeaderReusableView.h"
#import <Masonry/Masonry.h>

@implementation BHCollectionHeaderReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headerLabel];
        [self setupSubviewsContraints];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark-
#pragma mark- Getters && Setters

- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc]init];
        _headerLabel.textColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1];
        _headerLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15.0f];
    }
    return _headerLabel;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints {
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.bottom.trailing.mas_equalTo(0);
    }];
}
@end
