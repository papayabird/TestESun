//
//  ESLoadingPageViewController.m
//  TestESun
//
//  Created by mpos on 2016/9/20.
//  Copyright © 2016年 ES. All rights reserved.
//

#import "ESLoadingPageViewController.h"
#import "VPTabbarViewController.h"
#import "JGContainerViewController.h"
#import "AppDelegate.h"
#import "UIImageView+AnimationCompletion.h"

@interface ESLoadingPageViewController (){
    UIImageView* gifImageView ;
}

@end

@implementation ESLoadingPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect frame = CGRectMake(0,0 ,320 ,100 ) ;
//
//    
//    
//    gifImageView = [[UIImageView alloc] initWithFrame:frame];
//
//    gifImageView.animationImages = [self animationImages]; //获取Gif图片列表
//    gifImageView.animationDuration = 1;     //执行一次完整动画所需的时长
//    gifImageView.animationRepeatCount = 1;  //动画重复次数
//
//    [gifImageView startAnimating];
//    
//    [self.view addSubview:gifImageView];

    gifImageView = [[UIImageView alloc] initWithFrame:frame];
    gifImageView.animationImages = [self animationImages];
    gifImageView.animationDuration = 2.0f;
   gifImageView.animationRepeatCount = 1;
    

    
    [gifImageView startAnimatingWithCompletionBlock:^(BOOL success){
        VPTabbarViewController *tabbarVC = [VPTabbarViewController sharedTabbarManager];
        JGContainerViewController *containerVC = [JGContainerViewController sharedContainerManager];
        [containerVC setTabbarVC:tabbarVC];
         [[[[UIApplication sharedApplication] delegate] window] setRootViewController: containerVC];

    }];
    
    [self.view addSubview:gifImageView];

   
}


- (NSArray *)animationImages
{
    NSFileManager *fielM = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Loading" ofType:@"bundle"];
    NSArray *arrays = [fielM contentsOfDirectoryAtPath:path error:nil];
    
    NSMutableArray *imagesArr = [NSMutableArray array];
    for (NSString *name in arrays) {
        UIImage *image = [UIImage imageNamed:[(@"Loading.bundle") stringByAppendingPathComponent:name]];
        if (image) {
            [imagesArr addObject:image];
        }
    }
    
    return imagesArr;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated] ;
    
//    while(![gifImageView isAnimating]){
//    
//        VPTabbarViewController *tabbarVC = [VPTabbarViewController sharedTabbarManager];
//        JGContainerViewController *containerVC = [JGContainerViewController sharedContainerManager];
//        [containerVC setTabbarVC:tabbarVC];
//         [[[[UIApplication sharedApplication] delegate] window] setRootViewController: containerVC];
//    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
