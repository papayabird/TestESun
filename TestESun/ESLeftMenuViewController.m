//
//  ESLeftMenuViewController.m
//  TestESun
//
//  Created by papayabird on 2016/9/13.
//  Copyright © 2016年 ES. All rights reserved.
//

#import "ESLeftMenuViewController.h"
#import "VPTabbarViewController.h"
#import "ESLeftMenuOneViewController.h"
#import "ESLeftMenuTwoViewController.h"
@interface ESLeftMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ESLeftMenuViewController

+(ESLeftMenuViewController *)sharedLeftMenuViewManager
{
    static ESLeftMenuViewController *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%i",(int)indexPath.row];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:indexPath.row * 55/255.0f
                                                       green:indexPath.row * 65/255.0f
                                                        blue:indexPath.row * 75/255.0f
                                                       alpha:1];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *addVC;
    
    switch (indexPath.row) {
        case 0:
            addVC = [[ESLeftMenuOneViewController alloc] init];
            break;
        case 1:
            addVC = [[ESLeftMenuTwoViewController alloc] init];
            break;
        default:
            break;
    }
    
    [[VPTabbarViewController sharedTabbarManager] addViewControllerFromLeftMenu:addVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
