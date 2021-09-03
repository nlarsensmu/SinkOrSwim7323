//
//  MagicDataModel.h
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootViewModel : NSObject

+(RootViewModel*)sharedinstance;
-(NSInteger)numberOfScreens;
-(NSString*)getNameFromIndex:(NSInteger)index;
-(NSString*)getScreenIdentFromIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
