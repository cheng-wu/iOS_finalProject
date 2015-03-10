//
//  DiscoverTableViewController.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/2/27.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "HeaderTableViewCell.h"
#import "YELPAPISample.h"
#import <CoreLocation/CoreLocation.h>
#import "YelpListing.h"
#import "DiscoverTableViewCell.h"
#import "WebViewController.h"

@interface DiscoverTableViewController ()<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *SearchedArray;
    NSMutableArray *YelpDataArray;
    BOOL issearchClicked;
    int pagenum;
    
}
@property (nonatomic, strong) NSMutableArray *objects;

@end

@implementation DiscoverTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // ** Don't forget to add NSLocationWhenInUseUsageDescription in MyApp-Info.plist and give it a string
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.delegate = self;
    
    issearchClicked=NO;
    
    SearchedArray   =[[NSMutableArray alloc]init];
    YelpDataArray   =[[NSMutableArray alloc]init];
    
    // 8:00 AM to 9:00 PM
    pagenum=0;
    
    
    // Create a location manager
    self.latitude = self.locationManager.location.coordinate.latitude;
    self.longitude = self.locationManager.location.coordinate.longitude;
    
    NSLog(@"wocacacaca%f",self.latitude);
    NSLog(@"woca%f",self.longitude);
    
    NSString *myLocation = [NSString stringWithFormat:@"%f,%f", self.latitude,self.longitude];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    /*
     
     fake search click below!!!!!
     
     */
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    //self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.view endEditing:YES];
    issearchClicked=NO;
    
    
    [self getRestaurantsByLocation:myLocation islonglat:YES];
    [self.tableView reloadData];
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return YelpDataArray.count+1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    NSInteger rowNo = indexPath.row;
    if (rowNo == 0)//第一个
    {
        static NSString *cellId = @"HeaderCell";
        HeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        
        if (cell == nil)
        {
            cell = [[HeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.discover = self;
        return cell;
    }
    
    if (rowNo ==1){
        static NSString *cellId = @"MapCell";
        MapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        
        if (cell == nil)
        {
            cell = [[MapTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.discover = self;
        cell.locationManager = [[CLLocationManager alloc] init];
        cell.locationManager = self.locationManager;
        NSLog(@"why2 = %f", cell.locationManager.location.coordinate.latitude);
        NSLog(@"why = %f", self.locationManager.location.coordinate.latitude);
        [cell.mapView setShowsUserLocation:YES];
        
        MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = self.locationManager.location.coordinate.latitude;
        region.center.longitude = self.locationManager.location.coordinate.longitude;
        region.span.longitudeDelta = 0.015f;
        region.span.longitudeDelta = 0.015f;
        [cell.mapView setRegion:region animated:YES];
        
        [cell.mapView setCenterCoordinate:region.center animated:YES];
 
        return cell;
        
    }
    
    //DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell" forIndexPath:indexPath];
    //cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    static NSString *CellIdentifier = @"RestaurantCell";
    
    
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setCellData:[YelpDataArray objectAtIndex:indexPath.row-2]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)//第一个
    {
        return 180.0f;
    }
    else
    {
        return 152.0f;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    self.hidesBottomBarWhenPushed = YES;
    //    MenuViewController *menuVC = [[MenuViewController alloc] init];
    //    menuVC.shopId = [[_shopData objectAtIndex:[indexPath row]] objectForKey:@"id"];
    //    [self.navigationController pushViewController:menuVC animated:YES];
    //    self.hidesBottomBarWhenPushed = NO;
    if(indexPath.row != 1){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WebViewController* webViewController = [storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
        
        YelpListing *ym=[YelpDataArray objectAtIndex:indexPath.row-2];
        webViewController.mobileUrl=ym.mobile_url;
        //NSLog(@"123=%@",ym.mobile_url);
        //webview.type=@"Rest_Details";
        [self.navigationController pushViewController:webViewController animated:YES];
    }
       
}

#pragma mark - Segues

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        NSLog(@"longitude=%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
        NSLog(@"latitude=%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        [self  getRestaurantsByLocation:[NSString stringWithFormat:@"%.8f,%.8f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude] islonglat:YES];
        [self.locationManager stopUpdatingLocation];
    }
}

-(void)getRestaurantsByLocation:(NSString*)location islonglat:(BOOL)islonglat
{
    
    if ([location length]<1) return;
    
    YELPAPISample *someApi=[YELPAPISample new];
    [someApi getServerResponseForLocation:location term:@"Restaurant,food" iSLonglat:islonglat withSuccessionBlock:^(NSDictionary *topBusinessJSON)
     {
         NSLog(@"Data From Server is %@",topBusinessJSON);
         
         if (!topBusinessJSON)
         {  
             NSLog(@"Response = Not avaialable");
             
             UIAlertView *myAlert=[[UIAlertView alloc]initWithTitle:@"Oops!!" message:@"Sorry! No listings found. Please search another location." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             [myAlert show];
         }
         else
         {
             [self separAteParametres:topBusinessJSON];
         }
     } andFailureBlock:^(NSError *error) {
         
     }];
    
}

-(void)getRestaurantsByTerm:(NSString*)term islonglat:(BOOL)islonglat
{
    if ([term length]<1) return;
    
    YELPAPISample *someApi=[YELPAPISample new];
    [someApi getServerResponseForLocation:@"Chicago" term:term iSLonglat:islonglat withSuccessionBlock:^(NSDictionary *topBusinessJSON)
     {
         NSLog(@"Data From Server is %@",topBusinessJSON);
         
         if (!topBusinessJSON)
         {
             NSLog(@"Response = Not avaialable");
             
             UIAlertView *myAlert=[[UIAlertView alloc]initWithTitle:@"Oops!!" message:@"Sorry! No listings found. Please search another location." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             [myAlert show];
         }
         else
         {
             [self separAteParametres:topBusinessJSON];
         }
     } andFailureBlock:^(NSError *error) {
         
     }];
    //[self.tableView reloadData];
    
}

-(void)separAteParametres:(NSDictionary*)params
{
    [YelpDataArray removeAllObjects];
    
    if ([params valueForKey:@"error"])
        return ;
    
    NSArray *businessArray=[params valueForKey:@"businesses"];
    for (NSDictionary *bdict in businessArray)
    {
        
        YelpListing *yelpModel=[YelpListing new];
        
        yelpModel.restaurant_id=[bdict valueForKey:@"id"];
        yelpModel.is_claimed=[bdict valueForKey:@"is_claimed"];
        yelpModel.is_closed=[bdict valueForKey:@"is_closed"];
        
        NSDictionary *locationDict= [bdict valueForKey:@"location"];
        
        yelpModel.city=[locationDict valueForKey:@"city"];
        yelpModel.address=[locationDict valueForKey:@"address"];
        yelpModel.coordinate=[locationDict valueForKey:@"coordinate"];
        yelpModel.country_code= [locationDict valueForKey:@"country_code"];
        
        NSArray *addressArray=[locationDict valueForKey:@"display_address"];
        
        NSString *final_Address=@"";
        for (NSString *sttring in addressArray){
            final_Address = [NSString stringWithFormat:@"%@, %@",final_Address,sttring];
        }
        
        
        yelpModel.display_address= final_Address;
        yelpModel.geo_accuracy= [locationDict valueForKey:@"geo_accuracy"];
        yelpModel.neighborhoods= [locationDict valueForKey:@"neighborhoods"];
        yelpModel.state_code=[locationDict valueForKey:@"state_code"];
        
        
        yelpModel.mobile_url=[bdict valueForKey:@"mobile_url"];
        yelpModel.name=[bdict valueForKey:@"name"];
        yelpModel.rating=[bdict valueForKey:@"rating"];
        yelpModel.rating_img_url=[bdict valueForKey:@"rating_img_url"];
        yelpModel.rating_img_url_large=[bdict valueForKey:@"rating_img_url_large"];
        yelpModel.rating_img_url_small=[bdict valueForKey:@"rating_img_url_small"];
        yelpModel.url=[bdict valueForKey:@"url"];
        yelpModel.review_count=[bdict valueForKey:@"review_count"];
        yelpModel.display_phone=[bdict valueForKey:@"display_phone"];
        if (!yelpModel.display_phone)
        {
            yelpModel.display_phone=([bdict valueForKey:@"phone"])?[bdict valueForKey:@"phone"]:@"Not updated";
        }
        yelpModel.image_url=[bdict valueForKey:@"image_url"];
        yelpModel.phone=[bdict valueForKey:@"phone"];
        
        yelpModel.snippet_image_url=[bdict valueForKey:@"snippet_image_url"];
        yelpModel.snippet_text=[bdict valueForKey:@"snippet_text"];
        
        [YelpDataArray addObject:yelpModel];
    }
    
    [self.tableView reloadData];
    
    
}

- (IBAction)search:(id)sender {
    
    //UITextField *textfield;
    NSString *textfield2;
    textfield2 = self.searchTerm.text;
    [self getRestaurantsByTerm:textfield2 islonglat:NO];
    [self.tableView reloadData];
}
@end
