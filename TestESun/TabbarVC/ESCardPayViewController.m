//
//  ESCardPayViewController.m
//  TestESun
//
//  Created by papayabird on 2016/9/13.
//  Copyright © 2016年 ES. All rights reserved.
//

#import "ESCardPayViewController.h"
#import "JGContainerViewController.h"
#import "ESCardSelectViewCell.h"
#import "ESPayWaySelectCell.h"
#import "ESCardMemberBarCodeCell.h"
#import "ZXMultiFormatWriter.h"
#import "ZXImage.h"


#import "ESShowCodeViewController.h"
#import "ESCameraViewController.h"

@interface ESCardPayViewController ()<UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate>{
    IBOutlet UITableViewCell *cardSelectViewCell;
    IBOutlet UITableViewCell *payWaySelectCell;
    IBOutlet UITableViewCell *cardMemberBarCodeCell;
    
    
    __weak IBOutlet UITableView *tableView;
    
    __weak IBOutlet UIScrollView *cardScrollView;
    __weak IBOutlet UIPageControl *pageControl;
    
    
    
    __weak IBOutlet UIButton *showCodeBtn;
    
    
    
    __weak IBOutlet UIImageView *barCodeImageView;
   
}

- (IBAction)changeCurrentPage:(id)sender;

- (IBAction)actionShowCode:(id)sender;
- (IBAction)actionCamera:(id)sender;


@end

@implementation ESCardPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tableView.delegate = self ;
    tableView.dataSource = self ;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
 

    [pageControl setNumberOfPages:3];
    [pageControl setCurrentPage:0];
    
    [cardScrollView setPagingEnabled:YES];
    [cardScrollView setShowsHorizontalScrollIndicator:NO];
    [cardScrollView setShowsVerticalScrollIndicator:NO];
    [cardScrollView setScrollsToTop:NO];
    [cardScrollView setDelegate:self];
    
    CGFloat width, height;
    width = cardScrollView.frame.size.width;
    height = cardScrollView.frame.size.height;
    [cardScrollView setContentSize:CGSizeMake(width * 3, height)];
    
    //製作ScrollView的內容
    for (int i=0; i!=pageControl.numberOfPages; i++) {
        CGRect frame = CGRectMake((320-230)/2 + (320*i), 0, 230 , 145);
        UIImageView* cardImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card"]] ;
        cardImage.frame = frame ;
        [cardScrollView addSubview:cardImage] ;
    }
    
    
    
    
    

    // 產生 Barcode
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix *result = [writer encode:@"A000109"
                                  format:kBarcodeFormatCode128
                                   width:barCodeImageView.frame.size.width
                                  height:barCodeImageView.frame.size.height
                                   error:&error];
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        [barCodeImageView setImage:[UIImage imageWithCGImage:image]];
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

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    
    if(indexPath.row == 0){
        cell = cardSelectViewCell ;

    }else if(indexPath.row == 1){
        
        cell = payWaySelectCell ;
    
    }else if(indexPath.row == 2){
        cell = cardMemberBarCodeCell ;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
    
    
 
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0){
        return 200 ;
        
    }else if(indexPath.row == 1){
    
        return 100 ;
        
    }else{
        
        return 100 ;
    }

    

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat width = cardScrollView.frame.size.width;
    NSInteger currentPage = ((cardScrollView.contentOffset.x - width / 2) / width) + 1;
    [pageControl setCurrentPage:currentPage];
}


- (IBAction)changeCurrentPage:(id)sender {
    NSInteger page = pageControl.currentPage;
    
    CGFloat width, height;
    width = cardScrollView.frame.size.width;
    height = cardScrollView.frame.size.height;
    CGRect frame = CGRectMake(width*page, 0, width, height);
    
    [cardScrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)actionShowCode:(id)sender {
    NSLog(@"actionShowCode") ;
    
    ESShowCodeViewController*showCodeViewController = [[ESShowCodeViewController alloc]init] ;
    
    [self.navigationController pushViewController:showCodeViewController animated:YES ] ;
    
    
}

- (IBAction)actionCamera:(id)sender {
    ESCameraViewController* cameraViewController = [[ESCameraViewController alloc]init] ;
    
    [self.navigationController pushViewController:cameraViewController animated:YES ] ;

}
@end
