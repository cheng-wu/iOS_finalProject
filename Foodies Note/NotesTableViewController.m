//
//  NotesTableViewController.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/8.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "NotesTableViewController.h"
#import "NoteTableViewCell.h"
#import "NoteDetailViewController.h"
#import "AsyncImageView.h"

@interface NotesTableViewController ()

@end

@implementation NotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //data source load
    /*
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"notes.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    self.notes = (NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
     
     */
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    //self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.staticedit = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                       style:UIBarButtonItemStyleDone
                                                      target:self action:@selector(edit)];
    self.navigationItem.leftBarButtonItem = self.staticedit;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"notes.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    self.notes = (NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.notes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteTableViewCell *cell = (NoteTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
    
    Note *object = self.notes[self.notes.count-indexPath.row-1];
    
    cell.year.text = object.year;
    cell.month.text = object.month;
    cell.day.text = object.date;
    cell.week.text = object.week;
    cell.title.text = object.title;
    cell.content.text = object.content;
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:object.imagepath];
    NSLog(@"imagepath==%@",object.imagepath);
    NSLog(@"day==%@",object.date);
    if (object.imagepath!=nil) {
        cell.image.image = savedImage;
    }
    else
    {
        cell.image.imageURL = [NSURL URLWithString:object.restimageurl];
    }
    
    // Configure the cell...
    
    return cell;
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
        NoteDetailViewController* detailview = [storyboard instantiateViewControllerWithIdentifier:@"notedetailview"];
        
        
        Note *object = self.notes[self.notes.count-indexPath.row-1];
        detailview.notedetail = object;
        NSLog(@"55555555555=%@",detailview.notedetail.imagepath);
        NSLog(@"66666666666=%@",detailview.notedetail.title);
        NSLog(@"77777777777=%@",detailview.notedetail.imagepaths);
        //YelpListing *ym=[YelpDataArray objectAtIndex:indexPath.row-2];
        //webViewController.yelpObject=ym;
        //webViewController.restname = ;
        //webViewController.resturl = ;
        //NSLog(@"123=%@",ym.mobile_url);
        //webview.type=@"Rest_Details";
        [self.navigationController pushViewController:detailview animated:YES];
    }
    
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

- (void)edit {
    if ([self.tableView isEditing]) {
        // If the tableView is already in edit mode, turn it off. Also change the title of the button to reflect the intended verb (‘Edit’, in this case).
        [self.tableView setEditing:NO animated:YES];
        [self.staticedit setTitle:@"Edit"];
        
        
    }else {
        // Turn on edit mode
        [self.tableView setEditing:YES animated:YES];
        
        [self.staticedit setTitle:@"Done"];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //delete mode
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //delete
        [self.notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //update disc
        NSError * err = nil;
        NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
        NSURL *file = [docs URLByAppendingPathComponent:@"notes.plist"];
        NSData * note = [NSKeyedArchiver archivedDataWithRootObject:self.notes];
        [note writeToURL:file atomically:NO];
        
        //DetailViewController *controller = [[DetailViewController alloc]init];
        
        
    }
}
@end
