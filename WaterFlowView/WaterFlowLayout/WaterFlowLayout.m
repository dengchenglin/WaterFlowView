//
//  WaterFlowLayout.m
//  WaterFlowView
//
//  Created by chenguangjiang on 15/12/27.
//  Copyright © 2015年 dengchenglin. All rights reserved.
//

#import "WaterFlowLayout.h"
@implementation WaterFlowLayout{
    NSMutableArray *_colHeightArr;
    NSMutableDictionary *_frameDictionary;
}
-(instancetype)init{
    if(self = [super init]){
        _cloCount = 3;
    };
    return self;
}
-(void)prepareLayout{
    _colHeightArr = [NSMutableArray array];
    _frameDictionary = [NSMutableDictionary dictionary];
    for(int i = 0;i < _cloCount;i++){
        [_colHeightArr addObject:[NSNumber numberWithFloat:0]];
    }
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    self.minimumInteritemSpacing = [self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:0];
    self.minimumLineSpacing = [self.delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:0];
    for(int i = 0;i < cellCount;i++){
        CGFloat itemWidth = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]].width;
        CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]].height;
        NSInteger minClo = 0;
        for(int j = 0;j < _colHeightArr.count ;j++){
            if([[_colHeightArr objectAtIndex:j] floatValue] < [_colHeightArr[minClo] floatValue]){
                minClo = j;
            }
        }
        CGFloat top = [_colHeightArr[minClo] floatValue];
        CGFloat left = minClo * (itemWidth + self.minimumInteritemSpacing);
        
        CGRect frame = CGRectMake(left, top, itemWidth, itemHeight);
        [_frameDictionary setObject:[NSIndexPath indexPathForItem:i inSection:0] forKey:NSStringFromCGRect(frame)];
        _colHeightArr[minClo] = [NSNumber numberWithFloat:top + self.minimumLineSpacing + itemHeight];
    }
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *array = [NSMutableArray array];
    for(NSString *frameStr in _frameDictionary.allKeys){
        if(CGRectIntersectsRect(CGRectFromString(frameStr), rect)){
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:_frameDictionary[frameStr]];
            attributes.frame = CGRectFromString(frameStr);
            [array addObject:attributes];
        }
    }
    return array;
}
-(CGSize)collectionViewContentSize{
    NSInteger maxClo = 0;
    for(int i = 0;i < _colHeightArr.count ;i++){
        if([[_colHeightArr objectAtIndex:i] floatValue] > [_colHeightArr[maxClo] floatValue]){
            maxClo = i;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, [[_colHeightArr objectAtIndex:maxClo] floatValue]);
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

@end
