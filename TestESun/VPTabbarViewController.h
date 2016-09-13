//
//  VPTabbarViewController.h
//  Verpix
//
//  Created by papayabird on 2016/1/15.
//  Copyright © 2016年 Toppano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPTabbarViewController : UIViewController

#pragma mark - Tab Bar
@property (nonatomic) BOOL isBarAnimation;
@property (nonatomic) BOOL isBarShow;
@property (nonatomic) BOOL isNavAnimation;
@property (nonatomic) BOOL isNavShow;

-(void)showBar;
-(void)hiddenBar;

-(void)showNav;
-(void)hiddenNav;

- (void)resetTabbar;

+(VPTabbarViewController *)sharedTabbarManager;
- (void)addViewControllerFromLeftMenu:(UIViewController *)vc;

//@property (nonatomic) Reachability *rech;

@end
