//
//  WaterFlowLayout.h
//  WaterFlowView
//
//  Created by chenguangjiang on 15/12/27.
//  Copyright © 2015年 dengchenglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,assign) NSInteger cloCount;
@property (nonatomic,weak) id <UICollectionViewDelegateFlowLayout> delegate;
@end
