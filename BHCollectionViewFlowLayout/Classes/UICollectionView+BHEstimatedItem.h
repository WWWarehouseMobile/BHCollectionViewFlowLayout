//
//  UICollectionView+BHExtend.h
//  BHCollectionViewFlowLayout
//
//  Created by 詹学宝 on 2019/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 @warning 使用estimatedItem时 ！！！
 当collectionView的使用预估item尺寸（estimatedItem）属性时，调用系统的updateItem系列方法会存在一些问题。
 此类封装的方法，一定程度减少了问题的发生，请酌情调用
 */
@interface UICollectionView (BHEstimatedItem)

- (void)ei_insertSections:(NSIndexSet *)sections;
- (void)ei_deleteSections:(NSIndexSet *)sections;
- (void)ei_reloadSections:(NSIndexSet *)sections;

- (void)ei_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)ei_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)ei_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

- (void)ei_insertSections:(NSIndexSet *)sections finishedReloadAll:(BOOL)finishedReload;
- (void)ei_deleteSections:(NSIndexSet *)sections finishedReloadAll:(BOOL)finishedReload;
- (void)ei_reloadSections:(NSIndexSet *)sections finishedReloadAll:(BOOL)finishedReload;


/**
 插入items

 @param indexPaths 将要插入item的indexPath数组
 
 @warning  当iOS系统小于10.0版本，且插入的item不在可视区域时。调用此方法之后，视图滚动到indexPaths区域时，会crash。
                    - 目前，尝试了很多办法未果
                    - 个人觉得是苹果对此未妥善处理
                    - 若你了解此种情况如何处理的，请提issue。
 
                    - !!! 若想避免此种情况，请先将indexPaths滚动到可视区 !!!
 
 @param finishedReload 是否需要在插入之后，调用reloadData
 */
- (void)ei_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths finishedReloadAll:(BOOL)finishedReload;
- (void)ei_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths finishedReloadAll:(BOOL)finishedReload;
- (void)ei_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths finishedReloadAll:(BOOL)finishedReload;

@end

NS_ASSUME_NONNULL_END
