//
//  ViewController.m
//  WaterFlowView
//
//  Created by chenguangjiang on 15/12/27.
//  Copyright © 2015年 dengchenglin. All rights reserved.
//

#import "ViewController.h"
#import "WaterFlowLayout.h"
#import "Cell.h"
@interface ViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic,copy) NSArray *dataSoure;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"MY_CELL"];
    [self loadData];
}
-(void)loadData{
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0;i < 100 ;i++){
        CGFloat height = 50 + arc4random()%100;
        [array addObject:[NSNumber numberWithFloat:height]];
    }
    self.dataSoure = array;
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.dataSoure.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger cloCount = ((WaterFlowLayout *)collectionViewLayout).cloCount;
    CGFloat itemWidth = (self.view.bounds.size.width - (cloCount - 1) *((WaterFlowLayout *)collectionViewLayout).minimumInteritemSpacing)/cloCount;
    return CGSizeMake(itemWidth, [self.dataSoure[indexPath.row] floatValue]);
}
//横间细
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0;
}
//竖间隙
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}


@end
