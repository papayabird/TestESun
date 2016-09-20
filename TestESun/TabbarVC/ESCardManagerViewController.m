//
//  ESCardManagerViewController.m
//  TestESun
//
//  Created by papayabird on 2016/9/13.
//  Copyright © 2016年 ES. All rights reserved.
//

#import "ESCardManagerViewController.h"
#import "JGContainerViewController.h"

@interface ESCardManagerViewController ()

{
    __weak IBOutlet UIImageView *cardImageView;
    
    
}

@end

@implementation ESCardManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    cardImageView.image = [self drawFront:cardImageView.image
                                     text:@"1111-2222-3333-4444"
                                  atPoint:CGPointMake(cardImageView.bounds.size.width * 0.1, cardImageView.bounds.size.height * 0.5)];
}

- (UIImage*)drawFront:(UIImage*)image text:(NSString*)text atPoint:(CGPoint)point
{
    /*
     <Error>: CGContextSaveGState: invalid context 0x0. If you want to see the backtrace, please set CG_CONTEXT_SHOW_BACKTRACE environmental variable.
     <Error>: CGContextTranslateCTM: invalid context 0x0. If you want to see the backtrace, please set CG_CONTEXT_SHOW_BACKTRACE environmental variable.
     <Error>: CGContextRestoreGState: invalid context 0x0. If you want to see the backtrace, please set CG_CONTEXT_SHOW_BACKTRACE environmental variable.
     出错原因：设置app的状态栏样式的使用使用了旧的方式，在info.plist里面设置了View controller-based status bar appearance为NO，默认为YES，一般式iOS6的时候使用这种方式，iOS7，8也兼容，但是到了iOS9就报了警告。
     
     文／_会飞的鱼（簡書作者）
     原文鏈接：http://www.jianshu.com/p/4dd5773270f4
     著作權歸作者所有，轉載請聯繫作者獲得授權，並標註“簡書作者”。
     */
    
    UIFont *font = [UIFont systemFontOfSize:cardImageView.bounds.size.width/20];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, (point.y - 5), image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = NSMakeRange(0, [attString length]);
    
    [attString addAttribute:NSFontAttributeName value:font range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range];
    
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(1.0f, 1.5f);
    [attString addAttribute:NSShadowAttributeName value:shadow range:range];
    
    [attString drawInRect:CGRectIntegral(rect)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
