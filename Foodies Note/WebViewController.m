//
//  WebViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/6.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    self.webview.scrollView.bounces=NO;
    [self.webview.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.webview.scrollView setShowsVerticalScrollIndicator:NO];
    self.webview.scalesPageToFit=YES;
    */
    
    //[self.Webview loadRequest:[NSURLRequest requestWithURL:homepage]];
    //self.webview.delegate=self;
    //self.webview.scalesPageToFit = YES;
    //[self.view addSubview:self.webview];
    //NSURL *HYHAppsURL = [NSURL URLWithString:self.mobileUrl];
    NSURL *HYHAppsURL = [NSURL URLWithString:self.mobileUrl];
                         
                         NSURLRequest *Request = [NSURLRequest requestWithURL:HYHAppsURL];
                         
                         [self.webview loadRequest:Request];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    //self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSLog(@"123321");
    NSLog(@"124=%@",HYHAppsURL);
    
    //self.webview.backgroundColor = [UIColor whiteColor];
    //self.view.alpha=0;
    //[self.webview reload];

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

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)WriteNote:(id)sender {
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //WriteNoteViewController* singleNote = [storyboard instantiateViewControllerWithIdentifier:@"NoteDetailView"];
    
    //YelpListing *ym=[YelpDataArray objectAtIndex:indexPath.row];
    //webViewController.mobileUrl=ym.mobile_url;
    //NSLog(@"123=%@",ym.mobile_url);
    //webview.type=@"Rest_Details";
    //[self.navigationController pushViewController:singleNote animated:YES];
    //[self presentViewController:singleNote animated: YES completion:nil];
    
}
@end
