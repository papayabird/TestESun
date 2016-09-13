//
//  ESStoreViewController.m
//  TestESun
//
//  Created by papayabird on 2016/9/13.
//  Copyright © 2016年 ES. All rights reserved.
//

#import "ESStoreViewController.h"
#import "JGContainerViewController.h"

@interface ESStoreViewController ()

@end

@implementation ESStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)leftMenuAction:(id)sender
{
    [[JGContainerViewController sharedContainerManager] showLeftMenu];
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
