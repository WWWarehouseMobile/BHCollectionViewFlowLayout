//
//  BHCollectionViewFlowLayout.h
//  BHCollectionViewFlowLayout
//
//  Created by 詹学宝 on 2019/5/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



/**
 item左对齐
 */
@protocol BHCollectionViewFlowLayoutDelegate;
@interface BHCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<BHCollectionViewFlowLayoutDelegate> bh_delegate;
/**
 装饰视图的区域偏移量。
 默认区域：覆盖各section的item
 */
@property (nonatomic, assign) UIEdgeInsets decorationOffsetEdgeInsets;


/**
 若需要装饰视图，必须设置decorationViewOfElementKind 或 调用- (void)bh_registerClass:(Class)viewClass forDecorationViewOfKind:(NSString *)elementKind；
 */
@property (nonatomic, copy) NSString *decorationViewOfElementKind;
- (void)bh_registerClass:(Class)viewClass forDecorationViewOfKind:(NSString *)elementKind;

@end

@protocol BHCollectionViewFlowLayoutDelegate <NSObject>

@optional
- (void)collectionViewFlowLayout:(BHCollectionViewFlowLayout *)collectionViewFlowLayout layoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes;

- (void)bh_collectionViewFlowLayout:(BHCollectionViewFlowLayout *)collectionViewFlowLayout layoutChangeByContentSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
