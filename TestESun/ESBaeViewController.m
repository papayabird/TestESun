//
//  ESBaeViewController.m
//  TestESun
//
//  Created by mpos on 2016/9/20.
//  Copyright © 2016年 ES. All rights reserved.
//

#import "ESBaeViewController.h"
#import "JGContainerViewController.h"

@interface ESBaeViewController (){

    
     UIView *navBarView;
    __weak IBOutlet UILabel *navTitle;
    __weak IBOutlet UIButton *leftBtn;
    __weak IBOutlet UIButton *rightBtn;
}

@end

@implementation ESBaeViewController
@synthesize showMenu ;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ESBaeViewController" owner:self options:nil];
    navBarView = [topLevelObjects objectAtIndex:1];
//    navBarView.frame = CGRectMake(0,0 ,self.view.bounds.size.width, 70)  ;

    
    navBarView.backgroundColor = [UIColor redColor] ;
    navTitle.text = @"title" ;
    
    if(showMenu){
        [leftBtn setTitle:@"Menu" forState:UIControlStateNormal ] ;
        [leftBtn addTarget:self action:@selector(actionShowMenu:) forControlEvents:UIControlEventTouchUpInside]  ;
    }else{
        [leftBtn setTitle:@"<Back" forState:UIControlStateNormal ] ;
        [leftBtn addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside] ;
    }
    
    [rightBtn setTitle:@"rightBtn" forState:UIControlStateNormal ] ;
    [self.view addSubview:navBarView ] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionShowMenu:(id)sender {
        [[JGContainerViewController sharedContainerManager] showLeftMenu];
}


- (void)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES ] ;
}
@end
