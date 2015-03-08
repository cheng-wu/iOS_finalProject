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
    CLLocationManager *locationManager;
}
@property (nonatomic, strong) NSMutableArray *objects;

@end

@implementation DiscoverTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.delegate = self;
    
    issearchClicked=NO;
    
    SearchedArray   =[[NSMutableArray alloc]init];
    YelpDataArray   =[[NSMutableArray alloc]init];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    // 8:00 AM to 9:00 PM
    pagenum=0;
    
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
    

    [self getRestaurantsByLocation:@"Chicago" islonglat:NO];
    [self.tableView reloadData];
    
    
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
    
    //DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell" forIndexPath:indexPath];
    //cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    static NSString *CellIdentifier = @"RestaurantCell";
    
    
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setCellData:[YelpDataArray objectAtIndex:indexPath.row-1]];
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebViewController* webViewController = [storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
    
    YelpListing *ym=[YelpDataArray objectAtIndex:indexPath.row];
    webViewController.mobileUrl=ym.mobile_url;
    //NSLog(@"123=%@",ym.mobile_url);
    //webview.type=@"Rest_Details";
    [self.navigationController pushViewController:webViewController animated:YES];
       
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
        [locationManager stopUpdatingLocation];
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)search:(id)sender {
    
    //UITextField *textfield;
    NSString *textfield2;
    textfield2 = self.searchTerm.text;
    [self getRestaurantsByTerm:textfield2 islonglat:NO];
    [self.tableView reloadData];
}
@end