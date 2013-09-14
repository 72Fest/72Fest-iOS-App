//
//  VotingOperation.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/14/13.
//
//

#import "VotingOperation.h"
#import "VoteManager.h"

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
        
        self.voteTotal = [[VoteManager defaultManager] getUpdatedTotalForId:self.imageKey];

        if (self.isCancelled) return;

        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(votingOperationDidReceiveVoteTotal:) withObject:self waitUntilDone:NO];
    }
}
@end
