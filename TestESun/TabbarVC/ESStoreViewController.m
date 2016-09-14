//
//  ESStoreViewController.m
//  TestESun
//
//  Created by papayabird on 2016/9/13.
//  Copyright © 2016年 ES. All rights reserved.
//

#import "ESStoreViewController.h"
#import "JGContainerViewController.h"
#import "ZXMultiFormatWriter.h"
#import "ZXImage.h"
@interface ESStoreViewController ()

{
    __weak IBOutlet UIImageView *barcodeImageView;
    
}

@end

@implementation ESStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    // 產生 Barcode
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix *result = [writer encode:@"A000109"
                                  format:kBarcodeFormatCode128
                                   width:barcodeImageView.frame.size.width
                                  height:barcodeImageView.frame.size.height
                                   error:&error];
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        [barcodeImageView setImage:[UIImage imageWithCGImage:image]];
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        NSString *errorMessage = [error localizedDescription];
        NSLog(@"barcode err: %@", errorMessage);
    }
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
