//
//  UICollectionView+BHExtend.m
//  BHCollectionViewFlowLayout
//
//  Created by 詹学宝 on 2019/5/7.
//

#import "UICollectionView+BHEstimatedItem.h"

@implementation UICollectionView (BHEstimatedItem)

- (void)ei_insertSections:(NSIndexSet *)sections {
    [self ei_insertSections:sections finishedReloadAll:NO];
}

- (void)ei_deleteSections:(NSIndexSet *)sections {
    [self ei_deleteSections:sections finishedReloadAll:NO];
}

- (void)ei_reloadSections:(NSIndexSet *)sections {
    [self ei_reloadSections:sections finishedReloadAll:NO];
}

- (void)ei_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ei_insertItemsAtIndexPaths:indexPaths finishedReloadAll:NO];
}

- (void)ei_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ei_deleteItemsAtIndexPaths:indexPaths finishedReloadAll:NO];
}

- (void)ei_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ei_reloadItemsAtIndexPaths:indexPaths finishedReloadAll:NO];
}

- (void)ei_insertSections:(NSIndexSet *)sections finishedReloadAll:(BOOL)finishedReload{
    float systemDeviceVersion = [self ei_systemDeviceVersion];
    if (systemDeviceVersion < 10.0) {
        [self reloadData];
    }else if (finishedReload) {
        [self ei_performBatchUpdates:^{
            [self insertSections:sections];
        }];
    }else {
        [self insertSections:sections];
    }
}

- (void)ei_deleteSections:(NSIndexSet *)sections finishedReloadAll:(BOOL)finishedReload{
    float systemDeviceVersion = [self ei_systemDeviceVersion];
    if (systemDeviceVersion < 10.0) {
        [self reloadData];
    }else if (finishedReload) {
        [self ei_performBatchUpdates:^{
            [self deleteSections:sections];
        }];
    }else {
        [self deleteSections:sections];
    }
}

- (void)ei_reloadSections:(NSIndexSet *)sections finishedReloadAll:(BOOL)finishedReload{
    float systemDeviceVersion = [self ei_systemDeviceVersion];
    if (systemDeviceVersion < 11.0) {
        [self reloadData];
    }else if (finishedReload) {
        [self ei_performBatchUpdates:^{
            [self reloadSections:sections];
        }];
    }else {
        [self reloadSections:sections];
    }
}

- (void)ei_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths finishedReloadAll:(BOOL)finishedReload{
    float systemDeviceVersion = [self ei_systemDeviceVersion];
    if (systemDeviceVersion < 10.0) {
        if ([self ei_isVisibleOfIndexPaths:indexPaths]) {
            [self reloadData];
        }else {
//            [self ei_performBatchUpdates:^{
//                [self insertItemsAtIndexPaths:indexPaths];
//            }];
            NSLog(
                  @"\n------------------------------------------------------------ warning !!!!!!!!! ------------------------------------------------------------\n----------------------------------------------------------------------------------------------------------------------------------------------\n 作者留言：\n尝试了很多办法未果。\n个人觉得是苹果对此未妥善处理。\n若你了解此种情况如何处理的，请提issue。\n若想避免此种情况，请先将indexPaths滚动到可视区域\n---------------------------------------------------------------------------------------------------------------------------------------------- \n----------------------------------------------------------------------------------------------------------------------------------------------\n\n");
        }
    }else if (finishedReload) {
        [self ei_performBatchUpdates:^{
            [self insertItemsAtIndexPaths:indexPaths];
        }];
    }else {
        [self insertItemsAtIndexPaths:indexPaths];
    }
}

- (void)ei_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths finishedReloadAll:(BOOL)finishedReload{
    float systemDeviceVersion = [self ei_systemDeviceVersion];
    if (systemDeviceVersion < 10.0) {
        if ([self ei_isVisibleOfIndexPaths:indexPaths]){
            [self reloadData];
        }else {
            [self ei_performBatchUpdates:^{
                [self deleteItemsAtIndexPaths:indexPaths];
            }];
        }
        
    }else if (finishedReload) {
        [self ei_performBatchUpdates:^{
            [self deleteItemsAtIndexPaths:indexPaths];
        }];
    }else {
        [self deleteItemsAtIndexPaths:indexPaths];
    }
}

- (void)ei_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths finishedReloadAll:(BOOL)finishedReload{
    float systemDeviceVersion = [self ei_systemDeviceVersion];
    if (systemDeviceVersion < 10.0f) {
        if ([self ei_isVisibleOfIndexPaths:indexPaths]) {
            [self reloadData];
        }else {
            [self ei_performBatchUpdates:^{
                [self reloadItemsAtIndexPaths:indexPaths];
            }];
        }
    }else if (systemDeviceVersion < 11.0) {
        [self reloadData];
    }else if (finishedReload) {
        [self ei_performBatchUpdates:^{
            [self reloadItemsAtIndexPaths:indexPaths];
        }];
    }else {
        [self reloadItemsAtIndexPaths:indexPaths];
    }
}

- (void)ei_performBatchUpdates:(void (NS_NOESCAPE ^ _Nullable)(void))updates {
    [self performBatchUpdates:updates completion:^(BOOL finished) {
        if (finished) {
            [self reloadData];
        }
    }];
}

- (BOOL)ei_isVisibleOfIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    NSMutableSet *visibleItems = [NSMutableSet setWithArray:self.indexPathsForVisibleItems];
    NSSet *updateItems = [NSSet setWithArray:indexPaths];
    [visibleItems intersectSet:updateItems];
    return [visibleItems isEqualToSet:updateItems];
}


- (float)ei_systemDeviceVersion {
    return [[UIDevice currentDevice].systemVersion floatValue];
}

@end
