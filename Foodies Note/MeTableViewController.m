//
//  MeTableViewController.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/11.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "MeTableViewController.h"
#import "YelpListing.h"
#import "PersonalCheckInTableViewCell.h"
#import "CheckInTableViewCell.h"
#import "MapCheckInTableViewCell.h"
#import "WebViewController.h"

@interface MeTableViewController () <FBLoginViewDelegate>

@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
}

- (void)viewWillAppear:(BOOL)animated{
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"checkin.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    self.checkinItems = (NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self.tableView reloadData];
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
    
    self.checkinNum = [NSString stringWithFormat:@"You checked in %lu places!", (unsigned long)self.checkinItems.count];
    
    /*
     assign level
     */
    
    self.level = [NSString stringWithFormat:@"Level: %lu", (unsigned long)self.checkinItems.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.checkinItems.count+2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowNo = indexPath.row;
    if(rowNo==0){
        static NSString *CellIdentifier = @"PersonalCheckInCell";
        PersonalCheckInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.profilePicture = self.profilePicture;
        //cell.name.text = self.name;
        cell.level.text = self.level;
        cell.checkinNum.text = self.checkinNum;
        NSLog(@"just a test2=%@",self.name);
        FBLoginView *loginView = [[FBLoginView alloc] init];
        loginView.delegate = cell;
        return cell;
        
    }
    if(rowNo==1){
        static NSString *CellIdentifier = @"MapCheckinCell";
        MapCheckInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.profilePicture = self.profilePicture;
        //cell.name.text = self.name;
        NSLog(@"HEIWEGOU");
        [cell refreshMap];
        return cell;
        
    }
    
    
    static NSString *CellIdentifier = @"CheckInCell";
    
    
    CheckInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    YelpListing *object = self.checkinItems[indexPath.row-2];
    
    [cell setCellData:object];
    
    return cell;

}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePicture.profileID = user.objectID;
    self.name = user.name;
    NSLog(@"just a test");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    self.hidesBottomBarWhenPushed = YES;
    //    MenuViewController *menuVC = [[MenuViewController alloc] init];
    //    menuVC.shopId = [[_shopData objectAtIndex:[indexPath row]] objectForKey:@"id"];
    //    [self.navigationController pushViewController:menuVC animated:YES];
    //    self.hidesBottomBarWhenPushed = NO;
    if(indexPath.row != 1 ||indexPath.row != 0){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WebViewController* webViewController = [storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
        
        YelpListing *ym=[self.checkinItems objectAtIndex:indexPath.row-2];
        webViewController.yelpObject=ym;
        //webViewController.restname = ;
        //webViewController.resturl = ;
        //NSLog(@"123=%@",ym.mobile_url);
        //webview.type=@"Rest_Details";
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rows in section 0 should not be selectable
    
    // first 3 rows in any section should not be selectable
    if ( indexPath.row <= 1 ) return nil;
    
    // By default, allow row to be selected
    return indexPath;
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

@end
