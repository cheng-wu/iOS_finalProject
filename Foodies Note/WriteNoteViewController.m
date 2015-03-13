//
//  WriteNoteViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/7.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "WriteNoteViewController.h"
#import "AsyncImageView.h"
#import "PhotoCollectionViewCell.h"
#import "NotesTableViewController.h"
#import "DiscoverTableViewController.h"


@interface WriteNoteViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property BOOL isFullScreen;
@property NSInteger photonumber;

@end

@implementation WriteNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Text.placeholder = @"Say something...";
    [self.Text becomeFirstResponder];
    //self.navigationController.title = @"New Note";
    //self.navigationController.title.
    //self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    //self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    //self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
    //self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:nil action:nil];
    //NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"photoCell" owner:self options:nil];
    
    // 如果路径不存在，return nil
    
    // 加载nib
    //self.view = [arrayOfViews objectAtIndex:0];
    
    //[self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photoCell"];
    
    self.view.userInteractionEnabled= YES;
    self.photonumber = 0;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.imagepaths=[[NSMutableArray alloc]initWithCapacity:5];
    //[self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photoCell"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger year = [comps year];
    //NSInteger week = [comps weekday];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    //NSInteger hour = [comps hour];
    //NSInteger min = [comps minute];
    //NSInteger sec = [comps second];
    //NSString *month2;
    
    //Note * note = [[Note alloc] init];
    //note.content = self.Text.text;
    self.year.text = [NSString stringWithFormat: @"%ld", (long)year];
    if (month == 1) {
        self.month.text = [NSString stringWithFormat: @"JAN"];
    }
    else if(month == 2){
        self.month.text = [NSString stringWithFormat: @"FEB"];
    }
    else if(month == 3){
        self.month.text = [NSString stringWithFormat: @"MAR"];
    }
    else if(month == 4){
        self.month.text = [NSString stringWithFormat: @"APR"];
    }
    else if(month == 5){
        self.month.text = [NSString stringWithFormat: @"MAY"];
    }
    else if(month == 6){
        self.month.text = [NSString stringWithFormat: @"JUN"];
    }
    else if(month == 7){
        self.month.text = [NSString stringWithFormat: @"JUL"];
    }
    else if(month == 8){
        self.month.text = [NSString stringWithFormat: @"AUG"];
    }
    else if(month == 9){
        self.month.text = [NSString stringWithFormat: @"SEP"];
    }
    else if(month == 10){
        self.month.text = [NSString stringWithFormat: @"OCT"];
    }
    else if(month == 11){
        self.month.text = [NSString stringWithFormat: @"NOV"];
    }
    else if(month == 12){
        self.month.text = [NSString stringWithFormat: @"DEC"];
    }
    self.restname.text = self.yelpObject.name;
    self.restimage.imageURL =[NSURL URLWithString:self.yelpObject.image_url];
    //NSLog(@"1234566789=%@",self.yelpObject.image_url);
    //NSLog(@"1111=%@",self.yelpObject.address);
    //NSLog(@"1111=%@",self.yelpObject.name);
    self.restlocation.text = [self.yelpObject.display_address description];
    
    //self.restimage
    //self.month.text = note.month;
    //note.month = [NSString stringWithFormat: @"%ld", (long)month];

    //    note.week = [NSString stringWithFormat: @"%ld", (long)week];
    
    self.day.text = [NSString stringWithFormat: @"%ld", (long)day];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 180.0-1, 375, 1)];
    line.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    [self.view addSubview:line];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 300.0-1, 375, 1)];
    line2.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    [self.view addSubview:line2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                initWithTarget:self
                              action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.image.autoresizesSubviews = NO;
    [self.collectionView reloadData];
   
}
-(void) viewDidLayoutSubviews
{

}

-(void) viewWillAppear:(BOOL)animated
{
     //self.navigationItem.title =@"123";
    //self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    //self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
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




- (IBAction)saveNote:(id)sender {
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"notes.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    NSArray * notesArray = (NSArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray * tmp = nil;
    if (notesArray) {
        tmp = [[NSMutableArray alloc] initWithArray:notesArray];
    } else {
        tmp = [[NSMutableArray alloc] init];
    }
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *  currenttime=[dateformatter stringFromDate:senddate];
    NSLog(@"123=%@",currenttime);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger year = [comps year];
    NSInteger week = [comps weekday];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    //NSInteger sec = [comps second];
    //NSString *month2;
  
    Note * note = [[Note alloc] init];
    note.content = self.Text.text;
    note.year = [NSString stringWithFormat: @"%ld", (long)year];
    if (month == 1) {
        note.month = [NSString stringWithFormat: @"JAN  "];
    }
    else if(month == 2){
        note.month = [NSString stringWithFormat: @"FEB  "];
    }
    else if(month == 3){
        note.month = [NSString stringWithFormat: @"MAR  "];
    }
    else if(month == 4){
        note.month = [NSString stringWithFormat: @"APR  "];
    }
    else if(month == 5){
        note.month = [NSString stringWithFormat: @"MAY  "];
    }
    else if(month == 6){
        note.month = [NSString stringWithFormat: @"JUN  "];
    }
    else if(month == 7){
        note.month = [NSString stringWithFormat: @"JUL  "];
    }
    else if(month == 8){
        note.month = [NSString stringWithFormat: @"AUG  "];
    }
    else if(month == 9){
        note.month = [NSString stringWithFormat: @"SEP  "];
    }
    else if(month == 10){
        note.month = [NSString stringWithFormat: @"OCT  "];
    }
    else if(month == 11){
        note.month = [NSString stringWithFormat: @"NOV  "];
    }
    else if(month == 12){
        note.month = [NSString stringWithFormat: @"DEC  "];
    }
    //self.month.text = note.month;
    //note.month = [NSString stringWithFormat: @"%ld", (long)month];
    if (week == 1) {
        note.week = [NSString stringWithFormat: @"Sunday"];
    }
    else if(week == 2){
        note.week = [NSString stringWithFormat: @"Monday"];
    }
    else if(week == 3){
        note.week = [NSString stringWithFormat: @"Tuesday"];
    }
    else if(week == 4){
        note.week = [NSString stringWithFormat: @"Wednesday"];
    }
    else if(week == 5){
        note.week = [NSString stringWithFormat: @"Thursday"];
    }
    else if(week == 6){
        note.week = [NSString stringWithFormat: @"Friday"];
    }
    else if(week == 7){
        note.week = [NSString stringWithFormat: @"Saturday"];
    }
    //    note.week = [NSString stringWithFormat: @"%ld", (long)week];

    note.date = [NSString stringWithFormat: @"%ld", (long)day];

    note.hour = [NSString stringWithFormat: @"%ld", (long)hour];

    note.minute = [NSString stringWithFormat: @"%ld", (long)min];
    
    note.imagepath = self.imagepath;
    
    note.imagepaths = self.imagepaths;
    
    note.title = self.restname.text;
    
    note.location = self.restlocation.text;
    
    note.restimageurl = self.yelpObject.image_url;
    
    
    
    NSLog(@"123456789=%@",self.restimage.imageURL);
    
    //note.title = ;
    
    [tmp addObject:note];
    
    NSData * notes = [NSKeyedArchiver archivedDataWithRootObject:tmp];
    [notes writeToURL:file atomically:NO];
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[self.view addSubview:self.noteview.view];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController* controller = [storyboard instantiateViewControllerWithIdentifier:@"rootController"];
    [self presentViewController:controller animated:YES completion:nil];
}


- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    //NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [paths objectAtIndex:0];
    
    //在上面的基础上，获得一个完整的文件路径和名字：
    
    NSString * file = [documentDirectory stringByAppendingPathComponent:imageName];
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *docPath = [paths objectAtIndex:0];
    //NSString *myFile = [docPath stringByAppendingPathComponent:@"Documents"];
    
    // 将图片写入文件
    
    //[imageData writeToFile:fullPath atomically:YES];
    [imageData writeToFile:file atomically:YES];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //NSString *
    NSDate *  senddate=[NSDate date];
    
   // NSLog(@"123=%@",currenttime);
    self.photonumber = self.photonumber+1;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *  currenttime=[dateFormatter stringFromDate:senddate];
    NSString *imagename = [[NSString alloc] initWithFormat:@"%@-%ld.png",currenttime,(long)self.photonumber];
    NSLog(@"imagename==%@",imagename);
    
    NSLog(@"imagepaths==%@",self.imagepaths);
    
    [self saveImage:image withName:imagename];
    
    //NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imagename];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [paths objectAtIndex:0];
    
    //在上面的基础上，获得一个完整的文件路径和名字：
    
    NSString * fullPath = [documentDirectory stringByAppendingPathComponent:imagename];
    
    //NSData *data=[NSData dataWithContentsOfFile:fullPath options:0 error:NULL];
    
    self.imagepath = fullPath;
    //NSLog(@"fullpath========%@",fullPath);
    [self.imagepaths addObject:fullPath];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    _isFullScreen = NO;
    [self.image setImage:savedImage];
    
    self.image.tag = 100;
    [self.collectionView reloadData];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    _isFullScreen = !_isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.image.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.image.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.image.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (_isFullScreen) {
            // 放大尺寸
            
            self.image.frame = CGRectMake(0, 0, 320, 480);
        }
        else {
            // 缩小尺寸
            self.image.frame = CGRectMake(50, 65, 90, 115);
        }
        
        // commit动画
        [UIView commitAnimations];
        
    }
    
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        //[imagePickerController release];
    }
}




- (IBAction)choosephoto:(id)sender {
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"Select" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Take Photo",@"Choose from Photos", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"Select" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Choose from Photos", nil];
    }
    
    sheet.tag = 255;
    
    //self.photonumber = self.photonumber + 1;
    [sheet showInView:self.view];
    
    //[self.collectionView reloadData];

}

-(void)dismissKeyboard {
    [self.Text resignFirstResponder];
}



#pragma mark - CollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photonumber+1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger rowNo = indexPath.row;
    NSLog(@"photonumber=%ld",(long)self.photonumber);
    
    if (rowNo<self.photonumber) {
        //static NSString *cellId = @"photoCell";
        PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
        
        
        NSString *imageToLoad = [self.imagepaths objectAtIndex:rowNo];
        //加载图片
        //cell.singlephoto.image = [UIImage imageNamed:imageToLoad];
        NSLog(@"imagetoload=%@",imageToLoad);
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:imageToLoad];
        
        //_isFullScreen = NO;
        [cell.singlephoto setImage:savedImage];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }
    else
    {
        PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor blackColor];
        
        NSLog(@"2222222");
        
        return cell;
    
    }
    
    
    
    //cell.singlephoto = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add.png"]];
    //NSString *imageToLoad = [NSString stringWithFormat:@"%ld.png", (long)indexPath.row];
    //NSString *imageToLoad = @"add.png";
    //加载图片
    //cell.singlephoto.image = [UIImage imageNamed:imageToLoad];
    

    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120, 120);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


@end
