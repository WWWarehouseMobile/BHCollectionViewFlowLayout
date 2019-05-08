//
//  BHCollectionViewCell.m
//  BHCollectionViewFlowLayout_Example
//
//  Created by 詹学宝 on 2019/5/5.
//  Copyright © 2019 詹学宝. All rights reserved.
//

#import "BHCollectionViewCell.h"
#import <Masonry/Masonry.h>


@implementation BHCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.textLabel];
        [self.contentView addSubview:self.deleteBtn];
        self.contentView.layer.cornerRadius = 6.f;
        self.contentView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(CGRectGetWidth([UIScreen mainScreen].bounds) - 70);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(15);
            make.trailing.mas_equalTo(-15);
        }];
        
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-17.f );
            make.left.equalTo(self.contentView.mas_right).offset(-10.f );
            make.size.mas_offset(CGSizeMake(16.f , 16.f ));
        }];
    }
    return self;
}

#pragma mark-
#pragma mark- Setter && Getter
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12.0f];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor =  [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1];
        _textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _textLabel;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn setImage:[UIImage imageNamed:@"删除.png"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    // 获得每个cell的属性集
//    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//    // 计算cell里面textfield的宽度
//    CGRect frame = [self.textLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.textLabel.font,NSFontAttributeName, nil] context:nil];
//
//    // 这里在本身宽度的基础上 又增加了10
//    frame.size.width += 30;
//    frame.size.height = 30;
//
//    if (CGRectGetWidth(frame) > CGRectGetWidth([UIScreen mainScreen].bounds) - 40) {
//        frame.size.width = CGRectGetWidth([UIScreen mainScreen].bounds) - 40;
//    }
//    // 重新赋值给属性集
//    attributes.frame = frame;
//
//    return attributes;
//}

@end
