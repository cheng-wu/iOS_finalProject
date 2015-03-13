//
//  NoteDetailViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/12.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "AsyncImageView.h"
#import "SelfPhotoCollectionViewCell.h"

@interface NoteDetailViewController ()<UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation NoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    // Do any additional setup after loading the view.
    self.restname.text = self.notedetail.title;
    self.restlocation.text = self.notedetail.location;
    self.year.text = self.notedetail.year;
    self.month.text = self.notedetail.month;
    self.date.text = self.notedetail.date;
    self.textview.text = self.notedetail.content;
    self.restimage.imageURL = [NSURL URLWithString:self.notedetail.restimageurl];
    self.imagepaths = self.notedetail.imagepaths;
    NSLog(@"1111111=%ld",self.imagepaths.count);

    [self.collectionview reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
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


#pragma mark - CollectionView DataSource2
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagepaths.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger rowNo = indexPath.row;
    //NSLog(@"photonumber=%ld",(long)self.photonumber);
    

        //static NSString *cellId = @"photoCell";
    SelfPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"singleCell" forIndexPath:indexPath];
        
        
    NSString *imageToLoad = [self.imagepaths objectAtIndex:rowNo];
        //加载图片
        //cell.singlephoto.image = [UIImage imageNamed:imageToLoad];
    //NSLog(@"imagetoload=%@",imageToLoad);
    NSLog(@"rwono=%ld",rowNo);
    NSLog(@"imagepath=%@",imageToLoad);
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:imageToLoad];
        
        //_isFullScreen = NO;
    [cell.singleimage setImage:savedImage];
        
    cell.backgroundColor = [UIColor whiteColor];
        
    return cell;
    
    
    
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
