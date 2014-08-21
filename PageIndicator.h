//
//  PageIndicator.h
//  messagebox
//
//  Created by duyongchao on 14-7-25.
//  Copyright (c) 2014年 duyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PageIndicatorDelegate


@optional
-(IBAction)buttonPressed:(UIButton *)sender;

@end
@interface PageIndicator : UIView<UIScrollViewDelegate>
@property(strong, nonatomic) IBOutlet UIScrollView *indicator;
@property(strong, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property(retain, nonatomic) NSMutableArray *viewCollection,*btnCollection;
@property(retain, nonatomic) NSMutableDictionary *btnImgNameCollection;
/*
 button的图标名集合：
 dictionary 格式（object-key）
 btn1_img_Name               - @"1"
 btn1_img_highlighted_Name   - @"1-h"
 btn2_img_Name               - @"2"
 btn2_img_highlighted_Name   - @"2-h"
        .
        .
        .
 */


@property (nonatomic, retain) id<PageIndicatorDelegate> delegate;
@property(assign, nonatomic) int toolHeight,currentpage;
-(int)currentpage;
-(int)toolHeight;
- (id)initWithFrame:(CGRect)frame andImgDict:(NSMutableDictionary *)dict;
-(void)updateView;
//-(void)add2Scrollview:(id)Subview1,Subview2,...,nil;
-(void)add2Scrollview:(id)Subview,...;

@end
