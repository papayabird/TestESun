//
//  JGContainerViewController.m
//  JinGoo
//
//  Created by papayabird on 2016/6/22.
//  Copyright © 2016年 JG. All rights reserved.
//

#import "JGContainerViewController.h"
//#import "JGHomeViewController.h"

#define JGLeftMenuSpace 60

@interface JGContainerViewController ()

{
    UIView *coverRootVCView;
    UINavigationController *rootVC;
    UIViewController *tabbar;
}

@end

@implementation JGContainerViewController

+(JGContainerViewController *)sharedContainerManager
{
    static JGContainerViewController *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //加menu
    self.silderMenuVC = [ESLeftMenuViewController sharedLeftMenuViewManager];
    self.silderMenuVC.view.frame = self.view.bounds;
    [self.view addSubview:self.silderMenuVC.view];
    [self addChildViewController:self.silderMenuVC];
    [self.silderMenuVC didMoveToParentViewController:self];
}

- (void)setFirstRootVC:(UINavigationController *)vc
{
    rootVC = vc;
    
    [self.view addSubview:rootVC.view];
    rootVC.view.frame = self.view.bounds;
    [self addChildViewController:rootVC];
    [rootVC didMoveToParentViewController:self];
}

- (void)setRootViewVC:(UINavigationController *)vc
{
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = vc;
        if ([nav.viewControllers[0] isKindOfClass:[rootVC.viewControllers[0] class]]) {
            [self hideLeftMenu];
            return;
        }
    }
    
    //先移除
    [rootVC.view removeFromSuperview];
    [rootVC removeFromParentViewController];
    rootVC = nil;
    
    rootVC = vc;
    
    [self.view addSubview:rootVC.view];
    rootVC.view.frame = self.view.bounds;
    rootVC.view.frame = CGRectMake(rootVC.view.frame.size.width - JGLeftMenuSpace, 0, rootVC.view.frame.size.width, rootVC.view.frame.size.height);
    [self addChildViewController:rootVC];
    [rootVC didMoveToParentViewController:self];
    
    [self hideLeftMenu];
}

- (void)setTabbarVC:(UIViewController *)vc
{
    tabbar = vc;
    [self.view addSubview:tabbar.view];
    tabbar.view.frame = self.view.bounds;
    [self addChildViewController:tabbar];
    [tabbar didMoveToParentViewController:self];
}

- (void)showLeftMenu
{
    [UIView animateWithDuration:0.25f animations:^{
        
        tabbar.view.frame = CGRectMake(tabbar.view.frame.size.width - JGLeftMenuSpace, 0, tabbar.view.frame.size.width, tabbar.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        if (!coverRootVCView) {
            
            coverRootVCView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tabbar.view.frame.size.width, tabbar.view.frame.size.height)];
            
            coverRootVCView.userInteractionEnabled = YES;
            
            [tabbar.view addSubview:coverRootVCView];
            [tabbar.view bringSubviewToFront:coverRootVCView];
            
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
            [coverRootVCView addGestureRecognizer:tapGestureRecognizer];
        }
    }];
}

- (void)hideLeftMenu
{
    [UIView animateWithDuration:0.25f animations:^{
        
        tabbar.view.frame = CGRectMake(0, 0, tabbar.view.frame.size.width, tabbar.view.frame.size.height);

    } completion:^(BOOL finished) {
        
        if (coverRootVCView) {

            [coverRootVCView removeFromSuperview];
            coverRootVCView = nil;
        }
    }];
}

-(void) tapGestureHandler:(UIPanGestureRecognizer *)recognizer
{
    [self hideLeftMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
