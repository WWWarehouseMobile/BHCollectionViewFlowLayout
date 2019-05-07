//
//  BHViewController.m
//  BHCollectionViewFlowLayout
//
//  Created by 詹学宝 on 05/05/2019.
//  Copyright (c) 2019 詹学宝. All rights reserved.
//

#import "BHViewController.h"
#import <Masonry/Masonry.h>
#import "BHCollectionViewCell.h"
#import "BHCollectionHeaderReusableView.h"
#import "BHCollectionFooterReusableView.h"
#import "BHCollectionViewFlowLayout.h"
#import "BHCollectionSectionBackgroundReusableView.h"
@interface BHViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) BHCollectionViewFlowLayout *flowLayout;
@end

@implementation BHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *addbarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertAction)];
    
    UIBarButtonItem *deletebarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAction)];
    self.navigationItem.rightBarButtonItems = @[addbarItem,deletebarItem];
//    self.navigationController.navigationItem.rightBarButtonItem = barItem;
	// Do any additional setup after loading the view, typically from a nib.
//    _dataArray = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dataList" ofType:@"plist"]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _dataArray = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dataList" ofType:@"plist"]];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [self.collectionView reloadData];
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [self.collectionView reloadData];
////        });
//    });

//    self.extendedLayoutIncludesOpaqueBars=YES;
//    self.modalPresentationCapturesStatusBarAppearance=NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;


}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];


}

- (void)insertAction {
    NSInteger i = arc4random() % self.dataArray.count;
    NSLog(@"i :%li",i);
    NSMutableDictionary *dict = self.dataArray[i];
    NSMutableArray *array = dict[@"grounpArray"];
    NSString *insertStr = [NSString stringWithFormat:@"就是这里+%li",i];
    [array addObject:insertStr];
    NSLog(@"添加了: %@",insertStr);
//    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:array.count-1 inSection:i]]];
//    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:i]];
    [self.collectionView reloadData];
//    [self.collectionView performBatchUpdates:^{
//        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:array.count-1 inSection:i]]];
//    } completion:^(BOOL finished) {
//        [self.collectionView reloadData];
//    }];
}

- (void)deleteAction {
    NSInteger i = arc4random() % self.dataArray.count;
    NSMutableDictionary *dict = self.dataArray[i];
    NSMutableArray *array = dict[@"grounpArray"];
    
    NSInteger j = arc4random() % array.count;
    NSLog(@"删除了: %@",array[j]);
    [array removeObjectAtIndex:j];
//    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:j inSection:i]]];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray[section][@"grounpArray"] count];
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(30, 30);
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 50.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 35.0f);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BHCollectionHeaderReusableView *headerView = (BHCollectionHeaderReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"com.xuebao.BHCollectionViewHeader.identifier" forIndexPath:indexPath];
        headerView.headerLabel.text = dict[@"grounpName"];
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        BHCollectionFooterReusableView *footerView = (BHCollectionFooterReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"com.xuebao.BHCollectionViewFooter.identifier" forIndexPath:indexPath];
        footerView.footerLabel.text = [NSString stringWithFormat:@"共 %li 个",
                                       [dict[@"grounpArray"] count]];
        return footerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BHCollectionViewCell *cell = (BHCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"com.xuebao.BHCollectionViewCell.identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.section][@"grounpArray"][indexPath.item];
    return cell;
}



- (BHCollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[BHCollectionViewFlowLayout alloc] init];
        [_flowLayout bh_registerClass:[BHCollectionSectionBackgroundReusableView class] forDecorationViewOfKind:@"com.xuebao.BHCollectionViewSectionBackgroundColor.identifier"];
        _flowLayout.estimatedItemSize = CGSizeMake(60.0f, 30.0f);
//        _flowLayout.itemSize = CGSizeMake(70, 30.0f);

        _flowLayout.minimumLineSpacing = 15.0f;
        _flowLayout.minimumInteritemSpacing = 20.0f;
//        _flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _flowLayout.decorationOffsetEdgeInsets = UIEdgeInsetsMake(-20,-8, -10, -8);

    }
    return _flowLayout;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        if (@available(iOS 11.0, *)) {
//            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
//        } else {
//            // Fallback on earlier versions
//        }
//        _collectionView.contentInset = UIEdgeInsetsMake(8, 15.0f, 8.0f, 15);
        [_collectionView registerClass:[BHCollectionViewCell class] forCellWithReuseIdentifier:@"com.xuebao.BHCollectionViewCell.identifier"];
        [_collectionView registerClass:[BHCollectionHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"com.xuebao.BHCollectionViewHeader.identifier"];
        [_collectionView registerClass:[BHCollectionFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"com.xuebao.BHCollectionViewFooter.identifier"];
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
