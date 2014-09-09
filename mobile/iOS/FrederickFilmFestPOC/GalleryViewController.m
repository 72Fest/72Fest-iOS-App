//
//  GalleryViewController.m
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryTableViewCell.h"
#import "PhotoDetailViewController.h"
#import "ImageCache.h"
#import "LoaderBoxViewController.h"
#import "DiskCacheManager.h"
#import "VoteManager.h"
#import "FrederickFilmFestPOCAppDelegate.h"
#import "UIImage+Color.h"
#import "IOSCompatability.h"

@interface GalleryViewController ()

- (void)getVoteTotals;

@property (nonatomic, strong) UIBarButtonItem *refreshBtn;
@property (nonatomic, strong) UINib *nibLoader;
@property (nonatomic, strong) LoaderBoxViewController *loaderBoxVC;

@end

@implementation GalleryViewController

@synthesize imageNames = _imageNames;
@synthesize galleryTableView = _galleryTableView;
@synthesize photoListParser = _photoListParser;
@synthesize refreshBtn = _refreshBtn;
@synthesize nibLoader = _nibLoader;
@synthesize isRefreshing = _isRefreshing;
@synthesize loaderBoxVC = _loaderBoxVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        UITabBarItem *tbi = [[UITabBarItem alloc] initWithTitle:@"Gallery" image:[UIImage imageNamed:@"gallery.png"] tag:2];
//        [self setTabBarItem:tbi];
//        [tbi release];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if (SYSTEM_IS_IOS7) {
        //set tint for nav controller
        [[self.navigationController navigationBar] setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar performSelector:@selector(setBarTintColor:) withObject:THEME_CLR];
        
    } else {
        [[self.navigationController navigationBar] setTintColor:THEME_CLR];
        [[self.navigationController navigationBar] setBackgroundImage:[UIImage imageWithColor:THEME_CLR] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    //set up refresh button
    //self.refreshBtn = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonSystemItemAction target:self action:@selector(refreshPressed:)];
    self.refreshBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"01-refresh.png"] style:UIBarButtonSystemItemAction target:self action:@selector(refreshPressed:)];
    self.navigationItem.rightBarButtonItem = self.refreshBtn;
    
    UIBarButtonItem *menuBtn =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hamburgerIcon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(menuBtnPressed:)];
    [[self navigationItem] setLeftBarButtonItem:menuBtn];
    
    //set up nav bar header
    UIImageView *iv = 
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filmFestLogo.png"]];
    [[self navigationItem] setTitleView:iv];
    
    //set up loader box
    self.loaderBoxVC = [[LoaderBoxViewController alloc] init];
    [self.view addSubview:self.loaderBoxVC.view];
    //[self.loaderBoxVC setLoading:YES];
    
    CGRect curFrame = self.view.frame;
    CGRect loaderFrame = self.loaderBoxVC.view.frame;
    //center the loader box
    loaderFrame.origin.x = (curFrame.size.width/2) - (loaderFrame.size.width/2);
    loaderFrame.origin.y = (curFrame.size.height/2) - (loaderFrame.size.height);
    self.loaderBoxVC.view.frame = loaderFrame;
    
    [self setIsRefreshing:YES];
    
    //set up the table view
    //remove the cell separators
    [self.galleryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.galleryTableView setRowHeight:GALLERY_TABLE_CELL_HEIGHT];
    
    //load request for vote totals
    [self getVoteTotals];
    
    //load request for images
    self.photoListParser = [[PhotoListParser alloc] init];
    [self.photoListParser setDelegate:self];
    [self.photoListParser loadURL:[NSURL URLWithString:PHOTO_LIST_URL_STR]];
    
    self.nibLoader = [UINib nibWithNibName:GALLERY_CELL_CLASS_NAME 
                                bundle:[NSBundle mainBundle]];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    //lets clear out the cache when there is low memory
    NSLog(@"Purging image thumb cache due to low memory warning!");
    [[ImageCache sharedImageCache] purgeCache];
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    NSLog(@"Purging image thumb cache since view was unloaded!");
    [[ImageCache sharedImageCache] purgeCache];
    [self setGalleryTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setIsRefreshing:(BOOL)isRefreshing {
    _isRefreshing = isRefreshing;
    
    [self.loaderBoxVC setLoading:isRefreshing];
    
    if (_isRefreshing) {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [spinner startAnimating];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    } else {
        self.navigationItem.rightBarButtonItem = self.refreshBtn;
    }
}

- (void)refreshGalleryData {
    [self setIsRefreshing:YES];
    [self.photoListParser loadURL:[NSURL URLWithString:PHOTO_LIST_URL_STR]];
}

- (void)getVoteTotals {
    dispatch_async(dispatch_queue_create("Vote Totals Queue", NULL), ^{
        [[VoteManager defaultManager] getVoteTotals];
    }); 
}

#pragma mark - button actions
- (void)refreshPressed:(id)sender {
    [self refreshGalleryData];
}

- (void)galleryThumbPressed:(GalleryCellDataItem *)sender {
    //UITabBarController *tbc = [(FrederickFilmFestPOCAppDelegate *)[[UIApplication sharedApplication] delegate] tabBarController];
    
    PhotoDetailViewController *detailVC = [[PhotoDetailViewController alloc] initWithNibName:nil bundle:nil];
    [detailVC setPhotosList:self.imageNames];
    [detailVC setSelectedPhotIndex:sender.itemIndexPath.row];
    
    //wrap everything around a nav controller
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:detailVC];
    
    
    detailVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(photoDetailCloseBtnPressed:)];
    
    [self presentViewController:nc animated:YES completion:nil];
    
}

- (void)photoDetailCloseBtnPressed:(id)sender {
     //UITabBarController *tbc = [(FrederickFilmFestPOCAppDelegate *)[[UIApplication sharedApplication] delegate] tabBarController];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)menuBtnPressed:(id)sender {
     [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

#pragma mark - Photo Galleries Protocol
- (void)photoListParser:(id)photoListParser loadCompletedWithData:(NSArray *)photoListData {
    NSLog(@"GOT ALL DATA!!!!!!!!!!!!");
    
    //make sure this is run in the main queue
    dispatch_async(dispatch_get_main_queue(), ^ {
        //update the data source for the grid
        self.imageNames = photoListData;
    
        [self setIsRefreshing:NO];
    });
}

- (void)setImageNames:(NSArray *)imageNames {
    if (imageNames != _imageNames) {
        //handle the retains/releases
        _imageNames = imageNames;
        
        //update the table view now that the
        //data source has changed!
        [self.galleryTableView reloadData];
    }
}


- (GalleryTableViewCell *)retrieveGalleryCellForTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath andDequeueName:(NSString *)dequeueName {
    
    BOOL isNewCell = YES;
    
    GalleryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueName];
    if (cell == nil) {
        NSArray *nibItems = [self.nibLoader instantiateWithOwner:self options:nil];
        
        cell = [nibItems objectAtIndex:0];
    } else {
        //remove any images that may still exist
        //since we are resuing
        [cell clearItems];
    }
    
    //populate data
    
    //retreive the real number of rows
    NSUInteger realTotalRows = [self.imageNames count];
    
    //calculate the start index for the thumbs
    NSInteger startRowIndex = ([indexPath row] * THUMBS_PER_ROW);
    
    //([indexPath row] * THUMBS_PER_ROW) - (realTotalRows % THUMBS_PER_ROW);
    NSIndexPath *curIndexPath;
    
    NSArray *dataItems = [cell dataItems];
    GalleryCellDataItem *curGalleryDataItem;
    
    for (int curDataItemIdx = 0; curDataItemIdx < dataItems.count; curDataItemIdx++) {
        //if we reach the end of the dataset, lets break
        if ((startRowIndex + curDataItemIdx) == realTotalRows) {
            break;
        }
        curGalleryDataItem = (GalleryCellDataItem *)[dataItems objectAtIndex:curDataItemIdx];
        
        //set action
        if (isNewCell){
            [curGalleryDataItem addTarget:self action:@selector(galleryThumbPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        curIndexPath = [NSIndexPath indexPathForRow:((startRowIndex) + curDataItemIdx) inSection:indexPath.section];
        
        //save index path in the gallery data item
        [curGalleryDataItem setItemIndexPath:curIndexPath];
        
        //clear out thumb before doing GCD work
        //[curGalleryDataItem setThumb:nil];
        
        //get URL for cur thumb
        NSDictionary *imgDict = [[self.imageNames objectAtIndex:curIndexPath.row] copy];
        NSString *curThumbStr = [imgDict objectForKey:XML_TAG_THUMB_URL];
        NSURL *imgURL = [NSURL URLWithString:curThumbStr];
        
        //check if we can pull the image from the cache
        UIImage *cachedImg = [[ImageCache sharedImageCache] thumbForKey:curThumbStr];

        if (cachedImg) {
            //image is cached so let's just pull it from memory
            [curGalleryDataItem setThumb:cachedImg];
        } else {
            //image is not retrieved yet, pull it from the site
            dispatch_queue_t imageThumbCellQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

            __block UIImage *img;
             NSString *curFilename = [curThumbStr lastPathComponent];
            dispatch_async(imageThumbCellQueue, ^{
                if ([[DiskCacheManager defaultManager] existsInCache:curFilename]) {
                    //TODO:Seems to be a problem here
                    img = [UIImage imageWithData:[[DiskCacheManager defaultManager] retrieveFromCache:curFilename]];
                } else {
                    NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
                    img = [UIImage imageWithData:imgData];
                    [[DiskCacheManager defaultManager] saveToCache:imgData withFilename:curFilename];
                }
                
                //save thumb image to cache
                [[ImageCache sharedImageCache] setThumb:img forKey:curThumbStr];
                
                dispatch_async(dispatch_get_main_queue(), ^ {
                    [curGalleryDataItem setThumb:img];
                });
                
                
            });
        }
    }

    
    return cell;
}

#pragma mark - TableView protocol implementations
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger rowCount = [self.imageNames count];
    
    return ceil(rowCount/(float)THUMBS_PER_ROW);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString * PlainCellIdentifier = @"GalleryThumbCell";
    
    GalleryTableViewCell * cell = [self retrieveGalleryCellForTableView:tableView withIndexPath:indexPath andDequeueName:PlainCellIdentifier];
            
    
    return ( cell );
}



@end
