//
//  JGContainerViewController.h
//  JinGoo
//
//  Created by papayabird on 2016/6/22.
//  Copyright © 2016年 JG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESLeftMenuViewController.h"
@interface JGContainerViewController : UIViewController


@property (strong, nonatomic) ESLeftMenuViewController *silderMenuVC;

+(JGContainerViewController *)sharedContainerManager;

//- (void)setFirstRootVC:(UINavigationController *)vc;

//- (void)setRootViewVC:(UINavigationController *)rootVC;

- (void)setTabbarVC:(UIViewController *)vc;


- (void)showLeftMenu;
- (void)hideLeftMenu;
@end
