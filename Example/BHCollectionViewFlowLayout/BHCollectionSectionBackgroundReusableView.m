//
//  BHCollectionSectionBackgroundReusableView.m
//  BHCollectionViewFlowLayout_Example
//
//  Created by 詹学宝 on 2019/5/6.
//  Copyright © 2019 詹学宝. All rights reserved.
//

#import "BHCollectionSectionBackgroundReusableView.h"

@implementation BHCollectionSectionBackgroundReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.8f];
    self.layer.cornerRadius = 8.f;
}

@end
