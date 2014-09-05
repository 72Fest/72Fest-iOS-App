//
//  VotingOperation.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/14/13.
//
//

#import "VotingOperation.h"
#import "VoteManager.h"
#import "ConnectionInfo.h"

@interface VotingOperation()
@property (nonatomic, strong) NSString *imageKey;

@end

@implementation VotingOperation
- (id)initWithImageKey:(NSString *)imageKey andDelgate:(id <VotingOperationDelegate>)delegate {
    self = [super init];
    if (self) {
        self.imageKey = imageKey;
        self.delegate = delegate;
    }
    
    return self;
}

- (void)main {
    @autoreleasepool {
        if (self.isCancelled) return;
        
        self.voteTotal = 0;
        
        NSString *url = VOTE_TOTALS_URL_FOR_ID(self.imageKey);
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        if (self.isCancelled) return;
        
        if (!data) {
            NSLog(@"Failed to retieve votes in thread");
            return;
        }
        
        NSError *err = nil;
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options: nil error: &err];

        NSString *statusStr = [results valueForKey:API_MESSAGE_STATUS_KEY];
        int status = [statusStr intValue];
        if (!status) {
            NSLog(@"Could not find votes for key");
            return;
        }
        
        NSDictionary *totalsArray = [results valueForKey:API_MESSAGE_KEY];
        if (self.isCancelled) return;
        
        NSNumber *voteNum = [totalsArray valueForKey:VOTE_TOTALS_VOTES_KEY];
        self.voteTotal = [voteNum integerValue];
        
        if (self.isCancelled) return;

        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(votingOperationDidReceiveVoteTotal:) withObject:self waitUntilDone:NO];
    }
}
@end
