//
//  TeamDetailsViewController.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/10/14.
//
//

#import "TeamDetailsViewController.h"
#import "Teams.h"

@interface TeamDetailsViewController ()

- (NSString *)processTemplate:(NSString *)template;
- (NSString *)genVideoEmbeddedLink:(NSString *)srcLink;

@property (nonatomic, strong) NSString *htmlTemplate;
@end

@implementation TeamDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //load in HTML template
        NSString *path = [[NSBundle mainBundle] pathForResource:@"teamDetailsTemplate"
                                                         ofType:@"html"];
        
        self.htmlTemplate = [NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSString *teamName = [self.teamData valueForKey:TEAMS_FIELD_NAME];
    [[self navigationItem] setTitle:teamName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    NSString *html = [self processTemplate:self.htmlTemplate];
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)processTemplate:(NSString *)template {
    NSString *processedStr;
    
    NSString *teamName = [self.teamData objectForKey:TEAMS_FIELD_NAME];
    NSString *teamLogo = [self.teamData objectForKey:TEAMS_FIELD_LOGO];
    NSString *teamBio = [self.teamData objectForKey:TEAMS_FIELD_BIO];
    
    NSArray *teamFilms = [self.teamData objectForKey:TEAMS_FIELD_FILMS];
    
    processedStr = [template stringByReplacingOccurrencesOfString:@"{{TeamName}}" withString:teamName];
    processedStr = [processedStr stringByReplacingOccurrencesOfString:@"{{TeamBio}}" withString:teamBio];
    processedStr = [processedStr stringByReplacingOccurrencesOfString:@"{{TeamLogoURL}}" withString:teamLogo];
    
    //loop through films
    if (teamFilms.count) {
        NSString *filmsStr = @"";
        NSString *filmURL;
        
        for (NSDictionary *curFilmData in teamFilms) {
            filmURL = [curFilmData valueForKey:TEAMS_FIELD_FILM_URL];
            if (([filmURL rangeOfString:@"youtube"].location != NSNotFound) ||
                ([filmURL rangeOfString:@"vimeo"].location != NSNotFound) ) {
                filmsStr = [filmsStr stringByAppendingString:[self genVideoEmbeddedLink:filmURL]];
            }
        }
        
        //add film header
        filmsStr = [@"<h3>Films</h3>" stringByAppendingString:filmsStr];
        processedStr = [processedStr stringByReplacingOccurrencesOfString:@"{{TeamFilms}}" withString:filmsStr];
    } else {
        //just remove placeholder all together as there are no films to disiplay
        processedStr = [processedStr stringByReplacingOccurrencesOfString:@"{{TeamFilms}}" withString:@""];
    }
    
    return processedStr;
}

- (NSString *)genVideoEmbeddedLink:(NSString *)srcLink {
    NSString *iframeTemplate =
        @"<div class='filmContainer'><iframe width='240' height='135' src='{{url}}' frameborder='0' allowfullscreen></iframe></div>";
    
    return [iframeTemplate stringByReplacingOccurrencesOfString:@"{{url}}" withString:srcLink];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
