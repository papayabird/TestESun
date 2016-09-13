//
//  VPTabbarViewController.m
//  Verpix
//
//  Created by papayabird on 2016/1/15.
//  Copyright © 2016年 Toppano. All rights reserved.
//

#import "VPTabbarViewController.h"
#import "JGContainerViewController.h"
#import "ESLeftMenuViewController.h"
#import "ESCardPayViewController.h"
#import "ESCardManagerViewController.h"
#import "ESStoreViewController.h"
#import "ESOtherCardViewController.h"

typedef NS_ENUM(NSUInteger, navList) {
    navListCardPayVC,
    navListCardManagerVC,
    navListStoreVC,
    navListOtherCardVC
};

@interface VPTabbarViewController ()

{
    __weak IBOutlet UIButton *homeButton;
    __weak IBOutlet UIButton *exploreButton;
    __weak IBOutlet UIButton *postButton;
    __weak IBOutlet UIButton *profileButton;
    
    NSMutableDictionary *navDict;
    UINavigationController *currentNav;
    ESLeftMenuViewController *leftMenuVC;
    UIViewController *leftMenuOfVC;
}

@property (weak, nonatomic) IBOutlet UIView *barContainer;

@end

@implementation VPTabbarViewController

+(VPTabbarViewController *)sharedTabbarManager
{
    static VPTabbarViewController *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[VPTabbarViewController alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        ESCardPayViewController *homeVC = [[ESCardPayViewController alloc] init];
        UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
        homeNav.navigationBar.hidden = YES;
        
        ESCardManagerViewController *postVC = [[ESCardManagerViewController alloc] init];
        UINavigationController *postNav = [[UINavigationController alloc] initWithRootViewController:postVC];
        postNav.navigationBar.hidden = YES;
        
        ESStoreViewController *storeVC = [[ESStoreViewController alloc] init];
        UINavigationController *storeNav = [[UINavigationController alloc] initWithRootViewController:storeVC];
        storeNav.navigationBar.hidden = YES;
        
        ESOtherCardViewController *otherCardVC = [[ESOtherCardViewController alloc] init];
        UINavigationController *otherCardNav = [[UINavigationController alloc] initWithRootViewController:otherCardVC];
        otherCardNav.navigationBar.hidden = YES;
        
        navDict = [NSMutableDictionary dictionary];

        [navDict setObject:homeNav forKey:[NSString stringWithFormat:@"%lu",(unsigned long)navListCardPayVC]];
        [navDict setObject:postNav forKey:[NSString stringWithFormat:@"%lu",(unsigned long)navListCardManagerVC]];
        [navDict setObject:storeNav forKey:[NSString stringWithFormat:@"%lu",(unsigned long)navListStoreVC]];
        [navDict setObject:otherCardNav forKey:[NSString stringWithFormat:@"%lu",(unsigned long)navListOtherCardVC]];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //第一次先初始化
    [self resetTabbar];
    
    [self setButtonImageWithTitle];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Button Init

- (void)setButtonImageWithTitle
{
    homeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    exploreButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    postButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    profileButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)resetTabbar
{
    //清除TabbarVC裡面的data
//    [[NSNotificationCenter defaultCenter] postNotificationName:kResetTabbarRemoveVCData object:nil];
    
    //隱藏舊的
    [currentNav.view removeFromSuperview];
    currentNav = navDict[[NSString stringWithFormat:@"%lu",(unsigned long)navListCardPayVC]];
    [self selectItemAction:navListCardPayVC];
    [self addTabbar];
}

#pragma mark - Tab Bar

- (void)addTabbar
{
    //加入內容
    [self addChildViewController:currentNav];
    currentNav.view.frame = self.view.frame;
    [self.view addSubview:currentNav.view];
    [self.view sendSubviewToBack:currentNav.view];
}

-(void)showBar
{
    if (self.isBarAnimation == YES) {
        return;
    }
    self.isBarAnimation = YES;
    
    [self.view bringSubviewToFront:self.barContainer];
    
    [UIView animateWithDuration:0.25f
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.barContainer.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 0);
                         
                     } completion:^(BOOL finished) {
                         self.isBarAnimation = NO;
                         self.isBarShow = YES;
                     }];
}

-(void)hiddenBar
{
    if (self.isBarAnimation == YES) {
        return;
    }
    self.isBarAnimation = YES;
    
    [UIView animateWithDuration:0.25f
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.barContainer.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, self.view.frame.size.height, 0);
                         
                     } completion:^(BOOL finished) {
                         
                         self.isBarAnimation = NO;
                         self.isBarShow = NO;
                     }];
}

#pragma mark - Tab Bar Action

-(void)selectItemAction:(int)tag
{
    for (UIView *view in self.barContainer.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            
//            NSLog(@"%i",(int)[button tag]);
            
            if ((int)[button tag] == tag) {
                button.selected = YES;
            }
            else {
                button.selected = NO;
            }
        }
    }
}

-(IBAction)itemAction:(UIButton *)sender
{
    if ([currentNav isEqual: navDict[[NSString stringWithFormat:@"%li",(long)[sender tag]]]]) {

        if ([currentNav.viewControllers count] == 1) {
            
        }
        else {
            
            UIViewController *rootVC = currentNav.viewControllers[0];
            [currentNav setViewControllers:@[rootVC] animated:YES];
        }
    }
    
    [self selectItemAction:(int)[sender tag]];
    
    //隱藏舊的
    [currentNav.view removeFromSuperview];
    
    currentNav = navDict[[NSString stringWithFormat:@"%li",(long)[sender tag]]];
    
    [self removeLeftMenuVC];
    
    [self addTabbar];
}

#pragma mark - LeftMenu
- (void)addViewControllerFromLeftMenu:(UIViewController *)vc
{
    [self removeLeftMenuVC];
    leftMenuOfVC = vc;
    //隱藏舊的
    [currentNav.view removeFromSuperview];
    
    [self addChildViewController:leftMenuOfVC];
    leftMenuOfVC.view.frame = self.view.bounds;
    [self.view addSubview:leftMenuOfVC.view];
    [self.view sendSubviewToBack:leftMenuOfVC.view];
    [[JGContainerViewController sharedContainerManager] hideLeftMenu];
}

- (void)removeLeftMenuVC
{
    [leftMenuOfVC removeFromParentViewController];
    [leftMenuOfVC.view removeFromSuperview];
    leftMenuOfVC = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
