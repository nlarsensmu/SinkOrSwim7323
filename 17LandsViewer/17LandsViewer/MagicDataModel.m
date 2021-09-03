//
//  MagicDataModel.m
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

#import "MagicDataModel.h"

@implementation MagicDataModel

+(MagicDataModel*)sharedinstance{
    
    static MagicDataModel* _sharedInstance = nil;
    
    
    
    return _sharedInstance;
}

@end
