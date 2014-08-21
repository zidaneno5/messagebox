//
//  PageIndicator.m
//  messagebox
//
//  Created by duyongchao on 14-7-25.
//  Copyright (c) 2014年 duyongchao. All rights reserved.
//

#import "PageIndicator.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define PAGENUM             2                                  //标签数量
#define PG_TAG_GAP          10                                  //标签间隔
#define TAG_WIDTH           (PAGENUM<=2?(SCREEN_WIDTH/2):130)   //标签宽度
#define TAG_HEIGHT          30                                  //标签宽度
#define TAG_IMG_WIDTH       20                                  //标签图标宽度
#define TAG_IMG_HEIGHT      18                                  //标签图标高度
#define TAG_LABEL_WIDTH     45                                  //标签文字宽度
#define TAG_LABEL_HEIGHT    15                                  //标签文字高度
#define DEFAULT_X       (PAGENUM<=2?(PAGENUM==1?(SCREEN_WIDTH/2-TAG_WIDTH/2):i*SCREEN_WIDTH/2+PG_TAG_GAP/2):(i*TAG_WIDTH+PG_TAG_GAP))
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation PageIndicator{
    int previousPage;
}
@synthesize indicator;
@synthesize imageScrollView,viewCollection,btnCollection,btnImgNameCollection;
- (id)initWithFrame:(CGRect)frame andImgDict:(NSMutableDictionary *)dict
{
    
    btnImgNameCollection=dict;
    _toolHeight=TAG_HEIGHT;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    indicator=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TAG_HEIGHT)];

    ///////////////////////////////////////////////////////////////////////00000
    //添加indicator约束
    [indicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:_toolHeight]];
    ///////////////////////////////////////////////////////////////////////111111
    indicator.contentSize=CGSizeMake((PAGENUM<=2?SCREEN_WIDTH:PAGENUM*TAG_WIDTH+PG_TAG_GAP), TAG_HEIGHT);
    indicator.pagingEnabled = NO;
    indicator.showsHorizontalScrollIndicator = NO;
    btnCollection=[NSMutableArray arrayWithCapacity:PAGENUM];
    viewCollection=[NSMutableArray arrayWithCapacity:PAGENUM];
    for(int i = 0; i < PAGENUM; i++) {
        UIButton *indicatorComponent=[[UIButton alloc]initWithFrame:CGRectMake(DEFAULT_X, 0, TAG_WIDTH-PG_TAG_GAP, 30)];
        [indicatorComponent setTitle:[NSString stringWithFormat:@"Inbox%d",i+1] forState:UIControlStateNormal];
        indicatorComponent.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        [indicatorComponent setTitleColor:(i==1?[[UIColor grayColor]colorWithAlphaComponent:0.8]:[UIColor colorWithRed:89.0/255 green:166.0/255 blue:212.0/255 alpha:1.0]) forState:UIControlStateNormal];
        //图片文字距离
        [indicatorComponent setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
        if (i==0) {
            [indicatorComponent setImage:[UIImage imageNamed:[btnImgNameCollection objectForKey:[NSString stringWithFormat:@"%d-h",i+1]]] forState:UIControlStateNormal];
        }else{
            [indicatorComponent setImage:[UIImage imageNamed:[btnImgNameCollection objectForKey:[NSString stringWithFormat:@"%d",i+1]]] forState:UIControlStateNormal];
        }
        [indicator addSubview:indicatorComponent];
        indicatorComponent.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.8];
        indicatorComponent.tag=i;
        [indicatorComponent addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [btnCollection addObject:indicatorComponent];
        if (PAGENUM<=2) {
            //添加button约束
            [indicatorComponent setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:indicatorComponent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:indicator attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:indicatorComponent attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:_toolHeight]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:indicatorComponent attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:TAG_WIDTH]];
            if (PAGENUM==1) {
                 [self addConstraint:[NSLayoutConstraint constraintWithItem:indicatorComponent attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:indicator attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
            }else{
                [self addConstraint:[NSLayoutConstraint constraintWithItem:indicatorComponent attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:indicator attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:i==0?-90:90]];
            }
        }
    }
    [self addSubview:indicator];
    indicator.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.99];
    
    // Do any additional setup after loading the view.
    imageScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TAG_HEIGHT, SCREEN_WIDTH, iPhone5?474:386)];
    //indicator.hidden=YES;
    //添加imageScrollView约束
    [imageScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:indicator attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageScrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];

    imageScrollView.contentSize = CGSizeMake(PAGENUM * SCREEN_WIDTH, imageScrollView.frame.size.height);
    imageScrollView.pagingEnabled = YES;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.delegate = self;
    UIView *view=[[UIView alloc]init];
    for(int i = 0; i < PAGENUM; i++) {
        view  = [[UIView alloc] initWithFrame:CGRectMake(i * 320.0f,  0.0f, 320.0f, imageScrollView.frame.size.height)];
        [view setBackgroundColor:[[UIColor grayColor]colorWithAlphaComponent:0.6]];
        view.tag= i;
        [imageScrollView addSubview:view];
        [viewCollection addObject:view];
        
    }
    [self addSubview:imageScrollView];
    NSLog(@"indicator initwithframe");
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"layoutSubviewslayoutSubviews@@@@@@@@@@@@@@@");
}
-(void)updateView
{
    if ([[UIApplication sharedApplication] statusBarOrientation]==UIDeviceOrientationLandscapeRight||[[UIApplication sharedApplication] statusBarOrientation]==UIDeviceOrientationLandscapeLeft) {
        for(int i = 0; i < PAGENUM; i++) {
            UIView* tempview=[viewCollection objectAtIndex:i];
            imageScrollView.contentSize = CGSizeMake(PAGENUM * imageScrollView.frame.size.width, imageScrollView.frame.size.height);
            [tempview setFrame: CGRectMake(i * imageScrollView.frame.size.width,  0.0f, imageScrollView.frame.size.width, imageScrollView.frame.size.height)];
            NSLog(@"横屏SCREEN_WIDTH:%f,height:%f,位置X：%f，位置Y：%f",SCREEN_WIDTH,imageScrollView.frame.size.height,tempview.frame.origin.x,tempview.frame.origin.y);
        }
    }else{
        for(int i = 0; i < PAGENUM; i++) {
            [[viewCollection objectAtIndex:i] setFrame: CGRectMake(i * SCREEN_WIDTH,  0.0f, SCREEN_WIDTH, imageScrollView.frame.size.height)];
            imageScrollView.contentSize = CGSizeMake(PAGENUM * SCREEN_WIDTH, imageScrollView.frame.size.height);
            NSLog(@"竖屏SCREEN_WIDTH:%f,height:%f",SCREEN_WIDTH,imageScrollView.frame.size.height);
        }
    }
    NSLog(@"------currentpage:%d",_currentpage);
    UIView *view=[viewCollection objectAtIndex:_currentpage];
    [imageScrollView setContentOffset:CGPointMake(view.frame.size.width * _currentpage, 0.0f) animated:YES];
}
-(IBAction)pageTurn{
    UIView *view=[viewCollection objectAtIndex:_currentpage];
    [imageScrollView setContentOffset:CGPointMake(view.frame.size.width * _currentpage, 0.0f) animated:YES];
    if (PAGENUM>2) {//小于2时标签不动
        [indicator setContentOffset:CGPointMake(((_currentpage>=(PAGENUM-2))?(TAG_WIDTH*PAGENUM-SCREEN_WIDTH+PG_TAG_GAP):TAG_WIDTH * _currentpage), 0.0f) animated:YES];
    }
    [UIView commitAnimations];
    [[btnCollection objectAtIndex:previousPage]setTitleColor:[[UIColor grayColor] colorWithAlphaComponent:0.8f] forState:UIControlStateNormal];
    [[btnCollection objectAtIndex:previousPage]setImage:[UIImage imageNamed:[btnImgNameCollection objectForKey:[NSString stringWithFormat:@"%d",previousPage+1]]] forState:UIControlStateNormal];
    [[btnCollection objectAtIndex:_currentpage] setTitleColor:[UIColor colorWithRed:89.0/255 green:166.0/255 blue:212.0/255 alpha:1.0] forState:UIControlStateNormal];
    [[btnCollection objectAtIndex:_currentpage] setImage:[UIImage imageNamed:[btnImgNameCollection objectForKey:[NSString stringWithFormat:@"%d-h",_currentpage+1]]] forState:UIControlStateNormal];
    
}

//关于 va_list va_start va_arg va_end 几个宏
//　　va_list params; //定义一个指向个数可变的参数列表指针;
//　　va_start(params,Subview);//va_start 得到第一个可变参数地址,
//　　va_arg(params,id);//指向下一个参数地址
//　　va_end(params); //置空指针
-(void)add2Scrollview:(id)Subview,...
{
    //NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    va_list params; //定义一个指向个数可变的参数列表指针;
    va_start(params,Subview);//va_start 得到第一个可变参数地址,
    id arg;
    if (Subview) {
        //将第一个参数添加到array
        arg = Subview;
        //[argsArray addObject:arg];
        //va_arg 指向下一个参数地址
        //这里是问题的所在 网上的例子，没有保存第一个参数地址，后边循环，指针将不会在指向第一个参数
        int i=0;
        do {
            if ( arg ){
                //[argsArray addObject:arg];
                [[viewCollection objectAtIndex:i]addSubview:arg];
                [arg setTranslatesAutoresizingMaskIntoConstraints:NO];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:arg attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[viewCollection objectAtIndex:i] attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:arg attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:[viewCollection objectAtIndex:i] attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:arg attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[viewCollection objectAtIndex:i] attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:arg attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:[viewCollection objectAtIndex:i] attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
                i++;
            }

        } while ((arg = va_arg(params,id)));

        //置空  
        va_end(params);  
        //这里循环 将看到所有参数  
//        for (NSNumber *num in argsArray) {  
//            NSLog(@"%d", [num intValue]);  
//        }  
    }
}
-(IBAction)buttonPressed:(UIButton *)sender
{
    NSLog(@"button%d pressed!",(int)sender.tag);
    if (previousPage!=_currentpage) {
        previousPage=_currentpage;
    }
    _currentpage=(int)sender.tag;
    [self pageTurn];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    previousPage=_currentpage;
    CGFloat pageWidth = imageScrollView.frame.size.width;
    int page = floor((imageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	_currentpage=page;
    [self pageTurn];
    NSLog(@"scrollViewDidEndDecelerating");
    //[[viewCollection objectAtIndex:_currentpage] setHidden:NO];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView_
{
//    for (UIView*view in viewCollection) {
//        if (view.tag!=_currentpage) {
//            [view setHidden:YES];
//        }else{
//            [view setHidden:NO];
//        }
//    }
//    NSLog(@"scrollViewDidScroll");
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (previousPage!=_currentpage) {
        previousPage=_currentpage;
    }
    NSLog(@"drag will begin!");
}
-(int)currentpage
{
    return _currentpage;
}
-(int)toolHeight
{
    return _toolHeight;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
