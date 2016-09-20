//
//  ESShowCodeViewController.m
//  TestESun
//
//  Created by mpos on 2016/9/20.
//  Copyright © 2016年 ES. All rights reserved.
//

#import "ESShowCodeViewController.h"

#import "ZXMultiFormatWriter.h"
#import "ZXImage.h"


@interface ESShowCodeViewController (){

    __weak IBOutlet UIImageView *qrcodeImageview;
    __weak IBOutlet UIImageView *barcodeImageview;

    __weak IBOutlet UIButton *cancelPayBtn;
}


- (IBAction)actionBack:(id)sender;



@end

@implementation ESShowCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    
    
    // 產生 Qrcode
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix *qrcodeResult = [writer encode:@"http://www.google.com.tw"
                                  format:kBarcodeFormatQRCode
                                   width:qrcodeImageview.frame.size.width
                                  height:qrcodeImageview.frame.size.height
                                   error:&error];
    if (qrcodeResult) {
        CGImageRef image = [[ZXImage imageWithMatrix:qrcodeResult] cgimage];
        [qrcodeImageview setImage:[UIImage imageWithCGImage:image]];
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        NSString *errorMessage = [error localizedDescription];
        NSLog(@"barcode err: %@", errorMessage);
    }
    
    
    
    
    // 產生 Barcode
    ZXBitMatrix *barcodeResult = [writer encode:@"A000109"
                                  format:kBarcodeFormatCode128
                                   width:barcodeImageview.frame.size.width
                                  height:barcodeImageview.frame.size.height
                                   error:&error];
    if (barcodeResult) {
        CGImageRef image = [[ZXImage imageWithMatrix:barcodeResult] cgimage];
        [barcodeImageview setImage:[UIImage imageWithCGImage:image]];
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        NSString *errorMessage = [error localizedDescription];
        NSLog(@"barcode err: %@", errorMessage);
    }
    
    
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

- (IBAction)actionBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES ] ;
}


@end
