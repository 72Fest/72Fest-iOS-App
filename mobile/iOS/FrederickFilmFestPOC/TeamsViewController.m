//
//  TeamsViewController.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/10/14.
//
//

#import "TeamsViewController.h"
#import "TWTSideMenuViewController.h"
#import "Teams.h"
#import "ConnectionInfo.h"

@interface TeamsViewController ()
- (void)fetchTeamsList;

@property (nonatomic, strong) NSMutableArray *dataProvider;
@end

@implementation TeamsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *iv =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filmFestLogo.png"]];
    [[self navigationItem] setTitleView:iv];
    
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hamburgerIcon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnPressed:)];
    self.navigationItem.leftBarButtonItem = menuBtn;
    
    [self fetchTeamsList];
}

- (void)fetchTeamsList;
{
 
    __block TeamsViewController * weakSelf = self;
    NSURL *url = [NSURL URLWithString:TEAM_LIST_URL_STR];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil) {
             NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             NSNumber *status = [result valueForKey:API_MESSAGE_STATUS_KEY];
             
             if ([status boolValue]) {
                 NSMutableArray *teamsResults = [result valueForKey:API_MESSAGE_KEY];
                 
                 weakSelf.dataProvider = teamsResults;
                 [weakSelf.teamsTableView reloadData];
             } else {
                 NSLog(@"API call for teams is invalid");
             }
         } else {
             NSLog(@"Failed to fetch team data");
         }
     }];
}

#pragma mark - TableView protocol implementations
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataProvider.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *teamPlainCellIdentifier = @"TeamNameCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:teamPlainCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:teamPlainCellIdentifier];
    }
    
    NSDictionary *teamData = [self.dataProvider objectAtIndex:indexPath.row];
    NSString *teamName = [teamData valueForKey:TEAMS_FIELD_NAME];
    
    cell.textLabel.text = teamName;
    return cell;
    
    return ( cell );
}

#pragma mark - IB actions
- (void)btnPressed:(id)sender {
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
