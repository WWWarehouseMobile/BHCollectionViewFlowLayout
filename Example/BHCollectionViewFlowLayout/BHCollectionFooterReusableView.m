//
//  BHCollectionFooterReusableView.m
//  
//
//  Created by 詹学宝 on 2019/5/5.
//

#import "BHCollectionFooterReusableView.h"
#import <Masonry/Masonry.h>

@implementation BHCollectionFooterReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.footerLabel];
        [self setupSubviewsContraints];
        
//        self.backgroundColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.8f];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark-
#pragma mark- Getters && Setters

- (UILabel *)footerLabel {
    if (!_footerLabel) {
        _footerLabel = [[UILabel alloc]init];
        _footerLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
        _footerLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13.0f];
    }
    return _footerLabel;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints {
    [self.footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.bottom.trailing.mas_equalTo(0);
    }];
}
@end
