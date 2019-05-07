//
//  BHCollectionViewCell.h
//  BHCollectionViewFlowLayout_Example
//
//  Created by 詹学宝 on 2019/5/5.
//  Copyright © 2019 詹学宝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BHCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) UILabel * textLabel;

@property (nonatomic , strong) UIButton * deleteBtn;
@end

NS_ASSUME_NONNULL_END
