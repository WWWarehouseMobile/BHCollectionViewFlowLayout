//
//  BHCollectionViewFlowLayout.m
//  BHCollectionViewFlowLayout
//
//  Created by 詹学宝 on 2019/5/5.
//

#import "BHCollectionViewFlowLayout.h"

@interface BHCollectionViewFlowLayout ()

@property (nonatomic, strong) NSMutableDictionary *sectionRectDict;


@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;
@end

@implementation BHCollectionViewFlowLayout{
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sectionRectDict = [[NSMutableDictionary alloc] init];
        _deleteIndexPaths = [[NSMutableArray alloc] init];
    }
    return self;
}

- (UIEdgeInsets)edgeInsetsInSection:(NSInteger)section {
    UIEdgeInsets edgeInsets = [self sectionInset];
    id delegate = self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
       edgeInsets = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    return edgeInsets;
}

- (void)bh_registerClass:(Class)viewClass forDecorationViewOfKind:(NSString *)elementKind {
    [self registerClass:viewClass forDecorationViewOfKind:elementKind];
    self.decorationViewOfElementKind = elementKind;
}

- (void)prepareLayout {
    [super prepareLayout];
    [self.deleteIndexPaths removeAllObjects];
    [self.sectionRectDict removeAllObjects];
}

- (CGSize)collectionViewContentSize {
    return [super collectionViewContentSize];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributesArray = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
    for (NSInteger i=0; i<attributesArray.count; i++) {
        UICollectionViewLayoutAttributes *layoutAttibutes = attributesArray[i];
        if (layoutAttibutes.representedElementCategory == UICollectionElementCategoryCell) {
            [self updateRectForLayoutAttributes:layoutAttibutes];
        }
    }
    
    if (self.decorationViewOfElementKind) {
        [self.sectionRectDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSInteger section = [key integerValue];
            NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
            if (itemCount) {
                UICollectionViewLayoutAttributes *decorationLayoutAttributes = [self layoutAttributesForDecorationViewOfKind:self.decorationViewOfElementKind atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
                if (decorationLayoutAttributes) {
                    [attributesArray addObject:decorationLayoutAttributes];
                }
            }

        }];
    }
    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self updateRectForLayoutAttributes:currentItemAttributes];
    return currentItemAttributes;
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *supplementaryLayoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
//    return supplementaryLayoutAttributes;
//}



- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *decorationLayoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    if ([self.sectionRectDict objectForKey:@(indexPath.section)]) {
        CGRect rect = [[self.sectionRectDict objectForKey:@(indexPath.section)] CGRectValue];
        UIEdgeInsets edgeInsets = [self edgeInsetsInSection:indexPath.section];
        CGFloat viewWidth = [self collectionViewContentSize].width;
        if (rect.size.width < viewWidth - edgeInsets.left - edgeInsets.right) {
            rect.size.width = viewWidth - edgeInsets.left - edgeInsets.right;
        }
        rect.origin.x = edgeInsets.left;
        rect = UIEdgeInsetsInsetRect(rect, self.decorationOffsetEdgeInsets);
        
        decorationLayoutAttributes.frame = rect;
    }
    decorationLayoutAttributes.zIndex = -1;
    return decorationLayoutAttributes;
}

- (void)updateRectForLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    NSIndexPath *indexPath = layoutAttributes.indexPath;
    UIEdgeInsets sectionInset = [self edgeInsetsInSection:indexPath.section];
    CGRect rect = layoutAttributes.frame;
    UICollectionViewLayoutAttributes *previousItemAttributes;
    if (indexPath.item > 0) {
        NSIndexPath* previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
        previousItemAttributes = [self layoutAttributesForItemAtIndexPath:previousIndexPath];
    }
    
    if (previousItemAttributes.center.y != layoutAttributes.center.y) {
        rect.origin.x = sectionInset.left;
        layoutAttributes.frame = rect;
        
        if (self.decorationViewOfElementKind) {
            NSValue *value = [self.sectionRectDict objectForKey:@(layoutAttributes.indexPath.section)];
            if (value) {
                value = [NSValue valueWithCGRect:CGRectUnion(value.CGRectValue, layoutAttributes.frame)];
            }else {
                value = [NSValue valueWithCGRect:layoutAttributes.frame];
            }
            [self.sectionRectDict setObject:value forKey:@(layoutAttributes.indexPath.section)];
        }
    }else {
        rect.origin.x = previousItemAttributes.frame.origin.x + previousItemAttributes.frame.size.width + self.minimumInteritemSpacing;
        layoutAttributes.frame = rect;
    }
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems {
    [super prepareForCollectionViewUpdates:updateItems];
    for(UICollectionViewUpdateItem *update in updateItems){

        switch (update.updateAction) {
            case UICollectionUpdateActionDelete:
                //删除事件
                [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
                break;

            default:
                break;
        }

    }
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    if ([self.deleteIndexPaths containsObject:itemIndexPath]){
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];

        attributes.alpha = 0.0;

        //消失的一个动画效果
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    }
    return attributes;
}


@end
