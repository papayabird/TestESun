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

@interface ESCardPayViewController ()<UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate>{
    IBOutlet UITableViewCell *cardSelectViewCell;
    IBOutlet UITableViewCell *payWaySelectCell;
    IBOutlet UITableViewCell *cardMemberBarCodeCell;
    
    
    __weak IBOutlet UITableView *tableView;
    __weak IBOutlet UIScrollView *cardScrollView;
    __weak IBOutlet UIPageControl *pageControl;
    
    
    __weak IBOutlet UILabel *label;
}




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
        label.text = @"asbdfja"  ;
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changeCurrentPage:(id)sender {
    NSInteger page = pageControl.currentPage;
    
    CGFloat width, height;
    width = cardScrollView.frame.size.width;
    height = cardScrollView.frame.size.height;
    CGRect frame = CGRectMake(width*page, 0, width, height);
    
    [cardScrollView scrollRectToVisible:frame animated:YES];
}
@end
