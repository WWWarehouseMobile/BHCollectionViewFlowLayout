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
#import <BHCollectionViewFlowLayout/UICollectionView+BHEstimatedItem.h>

@interface BHViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) BHCollectionViewFlowLayout *flowLayout;
@end

@implementation BHViewController {
    
    BOOL _enableReloadAll;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *addbarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertItemAction)];
    
    UIBarButtonItem *deletebarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteItemAction)];
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

//    self.extendedLayoutIncludesOpaqueBars=YES;
//    self.modalPresentationCapturesStatusBarAppearance=NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;

    _enableReloadAll = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    [self.collectionView reloadData];

}

#pragma mark-
#pragma mark- CollectionView Action

- (void)insertItemAction {
    NSInteger i = arc4random() % self.dataArray.count;
    i = 0;
    NSMutableDictionary *dict = self.dataArray[i];
    NSMutableArray *array = dict[@"groupArray"];
    
    NSInteger j=0;
    if (array.count) {
        j = arc4random() % array.count;
    }
    NSString *insertStr = [NSString stringWithFormat:@"插入(%li,%li)",i,j];

    [array insertObject:insertStr atIndex:j];
    NSLog(@"添加了: %@",insertStr);
    [self.collectionView ei_insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:j inSection:i]] finishedReloadAll:_enableReloadAll];
}

- (void)deleteItemAction {
    NSInteger i = arc4random() % self.dataArray.count;
    i = 0;
    NSMutableDictionary *dict = self.dataArray[i];
    NSMutableArray *array = dict[@"groupArray"];
    
    NSInteger j = arc4random() % array.count;
    NSLog(@"删除了: %@  j:%li",array[j],j);
    
    [array removeObjectAtIndex:j];
    [self.collectionView ei_deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:j inSection:i]] finishedReloadAll:_enableReloadAll];
//    [self.collectionView reloadData];
}

- (void)reloadItemAction {
    NSInteger i = arc4random() % self.dataArray.count;
    i = 0;
    NSMutableDictionary *dict = self.dataArray[i];
    NSMutableArray *array = dict[@"groupArray"];
    
    NSInteger j = arc4random() % array.count;
    NSLog(@"更新之前: %@",array[j]);
    NSString *str = array[j];
    str = [NSString stringWithFormat:@"update:%@",str];
    [array replaceObjectAtIndex:j withObject:str];
    
    NSLog(@"dataArray:%@",self.dataArray);
    [self.collectionView ei_reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:j inSection:i]] finishedReloadAll:_enableReloadAll];
}

- (void)insertSectionAction {
    NSInteger i = arc4random() % self.dataArray.count;
    NSLog(@"i :%li",i);
    i = 1;
    NSMutableDictionary *dict = self.dataArray[i];
    NSDictionary *tempDict = [dict mutableCopy];
    [self.dataArray insertObject:tempDict atIndex:i];
    
    [self.collectionView ei_insertSections:[NSIndexSet indexSetWithIndex:i] finishedReloadAll:_enableReloadAll];
}

- (void)deleteSectionAction {
    NSInteger i = arc4random() % self.dataArray.count;
    NSLog(@"被删除的section :%li",i);
    i = 2;
    
    [self.dataArray removeObjectAtIndex:i];
    
    [self.collectionView ei_deleteSections:[NSIndexSet indexSetWithIndex:i] finishedReloadAll:_enableReloadAll];
}

- (void)reloadSectionAction {
    NSInteger i = arc4random() % self.dataArray.count;
    NSLog(@"被删除的section :%li",i);
    i = 0;
    
    NSMutableDictionary *dict = self.dataArray[i];
    NSMutableArray *groupArray = dict[@"groupArray"];
    NSString *groupName = dict[@"groupName"];
    groupName = [NSString stringWithFormat:@"更新section: %@",groupName];
    NSInteger j = arc4random() % groupArray.count;
    NSLog(@"更新之前: %@",groupArray[j]);
    NSString *str = groupArray[j];
    str = [NSString stringWithFormat:@"更新：%@",str];
    [groupArray replaceObjectAtIndex:j withObject:str];

    [self.collectionView ei_reloadSections:[NSIndexSet indexSetWithIndex:i] finishedReloadAll:_enableReloadAll];
}

- (void)reloadDataAction {
    NSInteger i = arc4random() % self.dataArray.count;
    NSLog(@"被删除的section :%li",i);
    i = 0;
    
    NSMutableDictionary *dict = self.dataArray[i];
    NSMutableArray *groupArray = dict[@"groupArray"];
    NSString *groupName = dict[@"groupName"];
    groupName = [NSString stringWithFormat:@"更新section: %@",groupName];
    NSInteger j = arc4random() % groupArray.count;
    NSLog(@"更新之前: %@",groupArray[j]);
    NSString *str = groupArray[j];
    str = [NSString stringWithFormat:@"更新：%@",str];
    [groupArray replaceObjectAtIndex:j withObject:str];

    [self.collectionView reloadData];
}

#pragma mark-
#pragma mark-UICollectionView DataSource && Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray[section][@"groupArray"] count];
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
        headerView.headerLabel.text = dict[@"groupName"];
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        BHCollectionFooterReusableView *footerView = (BHCollectionFooterReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"com.xuebao.BHCollectionViewFooter.identifier" forIndexPath:indexPath];
        footerView.footerLabel.text = [NSString stringWithFormat:@"共 %li 个",
                                       [dict[@"groupArray"] count]];
        return footerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BHCollectionViewCell *cell = (BHCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"com.xuebao.BHCollectionViewCell.identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.section][@"groupArray"][indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *groupName =  self.dataArray[indexPath.section][@"groupName"];
    if ([groupName isEqualToString:@"Action Group"]) {
        NSString *seletorStr = self.dataArray[indexPath.section][@"groupArray"][indexPath.item];
        SEL selector = NSSelectorFromString(seletorStr);
        [self performSelector:selector];
        
    }
}



- (BHCollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[BHCollectionViewFlowLayout alloc] init];
        _flowLayout.estimatedItemSize = CGSizeMake(200, 30.0f);
        _flowLayout.minimumLineSpacing = 15.0f;
        _flowLayout.minimumInteritemSpacing = 20.0f;
//        _flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        [_flowLayout bh_registerClass:[BHCollectionSectionBackgroundReusableView class] forDecorationViewOfKind:@"com.xuebao.BHCollectionViewSectionBackgroundColor.identifier"];
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
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        } else {
            // Fallback on earlier versions
        }
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
