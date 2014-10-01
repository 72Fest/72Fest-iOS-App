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
#import "TeamDetailsViewController.h"
#import "ConnectionInfo.h"

#define CELL_SELECTION_CLR [UIColor colorWithRed:144.0/255.0 green:188.0/255.0 blue:195.0/255.0 alpha:1.0]

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
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        //Add background color to selected state of cell
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = CELL_SELECTION_CLR;
        [cell setSelectedBackgroundView:bgColorView];
    }
    
    NSDictionary *teamData = [self.dataProvider objectAtIndex:indexPath.row];
    NSString *teamName = [teamData valueForKey:TEAMS_FIELD_NAME];
    
    cell.textLabel.text = teamName;
    return cell;
    
    return ( cell );
}

#pragma mark - TableView delegate implementations
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TeamDetailsViewController *vc = [[TeamDetailsViewController alloc] initWithNibName:nil bundle:nil];

    NSDictionary *teamData = [self.dataProvider objectAtIndex:indexPath.row];
    [vc setTeamData:teamData];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        //we want to get the current year to incorporate into the title
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        NSString *yearString = [formatter stringFromDate:[NSDate date]];
        
        UIColor *bgColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:.9];
        UILabel *label = [[UILabel alloc] init];
        [label setText:[NSString stringWithFormat:@"%@ Teams List", yearString]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:22.0]];
        
        [label setBackgroundColor:bgColor];
        return label;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
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
