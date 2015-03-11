//
//  WebViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/6.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "WebViewController.h"
#import "AsyncImageView.h"


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
    NSURL *HYHAppsURL = [NSURL URLWithString:self.yelpObject.url];
                         
                         NSURLRequest *Request = [NSURLRequest requestWithURL:HYHAppsURL];
                         
                         [self.webview loadRequest:Request];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    //self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSLog(@"123321");
    NSLog(@"124=%@",HYHAppsURL);
    
    NSLog(@"223344=%@",self.yelpObject.coordinate);
    
    self.latitude = [self.yelpObject.coordinate valueForKey:@"latitude"];
    self.longitude = [self.yelpObject.coordinate valueForKey:@"longitude"];
    
    
    //float latitude = [[components objectAtIndex:1] floatValue];
    //float longitude = [[components objectAtIndex:2] floatValue];
    //NSString *loc = [components objectAtIndex:3];
    
    
    //self.webview.backgroundColor = [UIColor whiteColor];
    //self.view.alpha=0;
    //[self.webview reload];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue]);
    annotation.title = self.yelpObject.name;
    annotation.subtitle = self.yelpObject.address;
    [self.mapView addAnnotation:annotation];
    
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [self.latitude floatValue];
    region.center.longitude = [self.longitude floatValue];
    region.span.longitudeDelta = 0.015f;
    region.span.longitudeDelta = 0.015f;
    [self.mapView setRegion:region animated:YES];
    [self.mapView setCenterCoordinate:region.center animated:YES];
    
    self.restaurantName.text=self.yelpObject.name;
    self.restaurantAddress.text=[self.yelpObject.address description];
    if(self.yelpObject.image_url)
        self.rest_ImageView.imageURL=[NSURL URLWithString:self.yelpObject.image_url];
    self.rating_ImageView.imageURL=[NSURL URLWithString:self.yelpObject.rating_img_url_large];
    self.phoneLabel.text=[NSString stringWithFormat:@"Ph: %@",self.yelpObject.display_phone];
    //self.review_countlabel.text=[NSString stringWithFormat:@"Reviewed by %@users",rmodel.review_count];
    self.reviewer.imageURL =[NSURL URLWithString:self.yelpObject.snippet_image_url];
    self.review.text = self.yelpObject.snippet_text;

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
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WriteNoteViewController* writeNoteController = [storyboard instantiateViewControllerWithIdentifier:@"WriteNote"];
    
    YelpListing *ym= self.yelpObject;
    writeNoteController.yelpObject=ym;

    [self.navigationController pushViewController:writeNoteController animated:YES];
    
}
@end
