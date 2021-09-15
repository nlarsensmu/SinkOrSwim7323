//
//  MagicDataModel.m
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

#import "RootViewModel.h"

@implementation RootViewModel

NSArray* screenTypes;
NSArray* screenIdents;

+(RootViewModel*)sharedinstance{
    
    static RootViewModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[RootViewModel alloc] init];
    } );
    return _sharedInstance;
}

-(NSArray*) screenTypes{
    if(!screenTypes){
        screenTypes = @[@"Card Search", @"Leader Board", @"Draft Helper"];
    }
    return screenTypes;
}

-(NSArray*) screenIdents{
    if(!screenIdents){
        screenIdents = @[@"CardSearch", @"LeaderBoard", @"DraftHelper"];
    }
    return screenIdents;
}

-(NSInteger)numberOfScreens{
    return self.screenTypes.count;
}

-(NSString*)getNameFromIndex:(NSInteger)index{
    return self.screenTypes[index];
}


-(NSString*)getScreenIdentFromIndex:(NSInteger)index{
    return self.screenIdents[index];
}
@end
