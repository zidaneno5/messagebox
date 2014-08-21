//
//  Ad0ViewController.m
//  messagebox
//
//  Created by duyongchao on 14-7-25.
//  Copyright (c) 2014年 duyongchao. All rights reserved.
//

#import "Ad0ViewController.h"
#import "PageIndicator.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define STATUSBAR_HEIGHT ([[UIApplication sharedApplication]statusBarFrame].size.height)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
@interface Ad0ViewController (){
    PageIndicator *indicator;
}

@end

@implementation Ad0ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"View Pager";
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    [navBar setTranslucent:NO];
///////////////////////////////////////////////////////////////////////
    //添加navBar约束
    [navBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:navBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:navBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:navBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:navBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:IOS7?64:44]];
///////////////////////////////////////////////////////////////////////

    if ([UINavigationBar instancesRespondToSelector:
         @selector (setBarTintColor:)]) {
        [navBar setBarTintColor:[UIColor colorWithRed:89.0/255 green:166.0/255 blue:212.0/255 alpha:0.8]];
    } else {
        [navBar setTintColor:[UIColor colorWithRed:89.0/255 green:166.0/255 blue:212.0/255 alpha:0.8]];
    }
    [self.navigationItem setTitle:@"Linkr"];
    [navBar pushNavigationItem:self.navigationItem animated:YES];
    //老写法
    //NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[UIColor whiteColor],UITextAttributeTextShadowColor,[UIFont boldSystemFontOfSize:20.0],UITextAttributeFont,CGSizeMake(0, -1.0),UITextAttributeTextShadowOffset, nil];
//自定义shadow
//    NSShadow *shadow=[[NSShadow alloc]init];
//    shadow.shadowColor=[UIColor grayColor];
//    shadow.shadowOffset=CGSizeMake(0, -1.0);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName,nil/*shadow*/,NSShadowAttributeName, nil];
    navBar.titleTextAttributes=dict;
    [self.view addSubview:navBar];
    
    
    CGRect indicatorframe=CGRectMake(0, IOS7?64:44, SCREEN_WIDTH,SCREEN_HEIGHT-64);//添加约束后不起作用
    NSMutableDictionary *imgdict=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"message_receive_p",@"1-h",@"message_send_p",@"2-h",@"message_send",@"2",@"message_receive",@"1", nil];
    indicator=[[PageIndicator alloc]initWithFrame:indicatorframe andImgDict:imgdict];
///////////////////////////////////////////////////////////////////////
    //添加indicator约束
    [indicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:IOS7?64:44]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
///////////////////////////////////////////////////////////////////////
    
    indicator.backgroundColor=[[UIColor blueColor]colorWithAlphaComponent:0.2];
    [self.view addSubview:indicator];
    [indicator add2Scrollview:self.tableview,self.SendTable,nil];
    [[indicator.btnCollection objectAtIndex:0]setTitle:@"Inbox" forState:UIControlStateNormal];
    [[indicator.btnCollection objectAtIndex:1]setTitle:@"Sendbox" forState:UIControlStateNormal];
    NSLog(@"main viewdidload");

}
-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"willAnimateRotationToInterfaceOrientation");
    [indicator updateView];
}
-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    //[indicator updateView];
    NSLog(@"didRotateFromInterfaceOrientation");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
