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

- (void)viewDidAppear:(BOOL)animated{
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
        //cell.profilePicture = self.profilePicture;
        //cell.name.text = self.name;
        cell.level.text = self.level;
        cell.checkinNum.text = self.checkinNum;
        NSLog(@"just a test2=%@",self.name);
        return cell;
        
    }
    if(rowNo==1){
        static NSString *CellIdentifier = @"MapCheckinCell";
        MapCheckInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //cell.profilePicture = self.profilePicture;
        //cell.name.text = self.name;
        NSLog(@"just a test2=%@",self.name);
        cell.checkInDataArray = self.checkinItems;
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
